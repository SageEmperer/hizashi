import 'dart:async';
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:hizashi/core/network/cf_session_store.dart';
import 'package:hizashi/core/network/headless_challenge_solver.dart';
import 'package:hizashi/core/network/http_client.dart';

typedef HtmlValidator = bool Function(String html);

/// Tries Dio first. A bounded browser attempt is used only for likely
/// challenge responses. Use validateHtml for source-specific validation.
class CloudflareAwareFetcher {
  CloudflareAwareFetcher._();

  static final Map<String, Future<void>> _domainLocks = {};

  static Future<String> fetchHtml({
    required String baseUrl,
    required String path,
    required String readySelector,
    HtmlValidator? validateHtml,
    Duration challengeTimeout = const Duration(seconds: 30),
    CancelToken? cancelToken,
    Map<String, String>? extraHeaders,
  }) async {
    final baseUri = Uri.parse(baseUrl);
    if (!baseUri.hasScheme || baseUri.host.isEmpty) {
      throw ArgumentError.value(baseUrl, 'baseUrl', 'Must be an absolute URL');
    }

    final domain = baseUri.host.toLowerCase();
    final client = await AppHttpClient.create(
      baseUrl: baseUrl,
      extraHeaders: extraHeaders,
    );

    final initial = await _tryPlainRequest(client, path, cancelToken);
    if (initial.html != null && _isUsableHtml(initial.html!, validateHtml)) {
      // A normal HTTP success is not proof of a Cloudflare clearance session.
      return initial.html!;
    }

    if (initial.statusCode == 429) {
      throw io.HttpException(
        'The source rate-limited this request (HTTP 429). Retry later.',
        uri: baseUri.resolve(path),
      );
    }

    final challenge = initial.challengeDetected || initial.statusCode == 403;
    if (!challenge) {
      throw io.HttpException(
        initial.errorMessage ?? 'Source request failed.',
        uri: baseUri.resolve(path),
      );
    }

    await CfSessionStore.instance.invalidate(domain);

    return _withDomainLock<String>(domain, () async {
      _checkCancelled(cancelToken);

      // A concurrent request may have completed recovery while we waited.
      final retry = await _tryPlainRequest(client, path, cancelToken);
      if (retry.html != null && _isUsableHtml(retry.html!, validateHtml)) {
        return retry.html!;
      }

      final url = baseUri.resolve(path).toString();
      final html = await HeadlessChallengeSolver.solve(
        url: url,
        readySelector: readySelector,
        timeout: challengeTimeout,
      );
      _checkCancelled(cancelToken);

      if (_looksLikeChallenge(html)) {
        throw const FormatException(
          'The source still returned a verification page. '
          'Interactive verification may be required.',
        );
      }
      if (!_isUsableHtml(html, validateHtml)) {
        throw const FormatException(
          'The loaded page did not contain valid content.',
        );
      }

      final browserCookies = await HeadlessChallengeSolver.cookiesFor(url);
      if (browserCookies.isNotEmpty) {
        final dioCookies = browserCookies
            .map((cookie) {
              final converted = io.Cookie(cookie.name, cookie.value);
              if (cookie.domain?.isNotEmpty == true)
                converted.domain = cookie.domain!;
              if (cookie.path?.isNotEmpty == true)
                converted.path = cookie.path!;
              if (cookie.isSecure == true) converted.secure = true;
              if (cookie.isHttpOnly == true) converted.httpOnly = true;
              if (cookie.expiresDate != null) {
                converted.expires = DateTime.fromMillisecondsSinceEpoch(
                  cookie.expiresDate!,
                );
              }
              return converted;
            })
            .toList(growable: false);
        await client.cookieJar.saveFromResponse(Uri.parse(url), dioCookies);
      }

      // Confirm that the copied cookies work in Dio before marking verified.
      final verified = await _tryPlainRequest(client, path, cancelToken);
      if (verified.html != null &&
          _isUsableHtml(verified.html!, validateHtml)) {
        await CfSessionStore.instance.markVerified(domain);
        return verified.html!;
      }

      // Browser-rendered HTML may be usable even if the cookie stores are not
      // interoperable. Return it, but do not claim the Dio session is verified.
      return html;
    });
  }

  static Future<_PlainResult> _tryPlainRequest(
    DioClient client,
    String path,
    CancelToken? cancelToken,
  ) async {
    try {
      final response = await client.dio.get<String>(
        path,
        cancelToken: cancelToken,
        options: Options(responseType: ResponseType.plain),
      );
      final status = response.statusCode;
      final body = response.data ?? '';

      if (_looksLikeChallenge(body)) {
        return _PlainResult(
          statusCode: status,
          challengeDetected: true,
          errorMessage: 'A browser verification page was returned.',
        );
      }

      if (status != null &&
          status >= 200 &&
          status < 300 &&
          body.trim().isNotEmpty) {
        return _PlainResult(statusCode: status, html: body);
      }

      return _PlainResult(
        statusCode: status,
        challengeDetected: status == 403,
        errorMessage: 'Source returned HTTP ${status ?? 'unknown'}.',
      );
    } on DioException catch (error) {
      if (CancelToken.isCancel(error)) rethrow;
      return _PlainResult(
        errorMessage: error.message ?? 'Network request failed.',
      );
    } catch (error) {
      return _PlainResult(errorMessage: error.toString());
    }
  }

  static bool _isUsableHtml(String html, HtmlValidator? validator) {
    final value = html.trim();
    if (value.isEmpty || _looksLikeChallenge(value)) return false;
    final lower = value.toLowerCase();
    if (lower.contains('<title>404') ||
        lower.contains('page not found') ||
        lower.contains('access denied'))
      return false;
    return validator?.call(value) ?? true;
  }

  static bool _looksLikeChallenge(String html) {
    final value = html.toLowerCase();
    return value.contains('challenge-platform') ||
        value.contains('cf-chl-') ||
        value.contains('cf_chl_') ||
        value.contains('just a moment...') ||
        value.contains('performing security verification') ||
        value.contains('checking your browser before accessing');
  }

  static void _checkCancelled(CancelToken? token) {
    if (token?.isCancelled == true) {
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.cancel,
        message: 'Request was cancelled.',
        error: token!.cancelError,
      );
    }
  }

  static Future<T> _withDomainLock<T>(
    String domain,
    Future<T> Function() action,
  ) async {
    final previous = _domainLocks[domain];
    final gate = Completer<void>();
    _domainLocks[domain] = gate.future;

    try {
      if (previous != null) await previous;
      return await action();
    } finally {
      if (!gate.isCompleted) gate.complete();
      if (identical(_domainLocks[domain], gate.future)) {
        _domainLocks.remove(domain);
      }
    }
  }
}

class _PlainResult {
  final int? statusCode;
  final String? html;
  final bool challengeDetected;
  final String? errorMessage;

  const _PlainResult({
    this.statusCode,
    this.html,
    this.challengeDetected = false,
    this.errorMessage,
  });
}
