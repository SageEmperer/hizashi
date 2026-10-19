import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:cookie_jar/cookie_jar.dart' as cj;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// Visible fallback for sources requiring user interaction.
class WebViewScraper {
  WebViewScraper._();

  static Future<String?> fetchHtml({
    required BuildContext context,
    required String url,
    required String readySelector,
    cj.PersistCookieJar? cookieJar,
    Duration timeout = const Duration(minutes: 3),
  }) {
    return Navigator.of(context).push<String>(
      MaterialPageRoute<String>(
        builder: (_) => _WebViewScraperPage(
          url: url,
          readySelector: readySelector,
          cookieJar: cookieJar,
          timeout: timeout,
        ),
      ),
    );
  }

  static Future<void> syncCookiesToJar({
    required String url,
    required cj.PersistCookieJar cookieJar,
  }) async {
    final cookies = await CookieManager.instance().getCookies(url: WebUri(url));
    final uri = Uri.parse(url);
    final converted = cookies.map((cookie) {
      final result = io.Cookie(cookie.name, cookie.value);
      if (cookie.domain?.isNotEmpty == true) result.domain = cookie.domain!;
      if (cookie.path?.isNotEmpty == true) result.path = cookie.path!;
      if (cookie.isSecure == true) result.secure = true;
      if (cookie.isHttpOnly == true) result.httpOnly = true;
      if (cookie.expiresDate != null) {
        result.expires = DateTime.fromMillisecondsSinceEpoch(cookie.expiresDate!);
      }
      return result;
    }).toList(growable: false);

    await cookieJar.saveFromResponse(uri, converted);
  }
}

class _WebViewScraperPage extends StatefulWidget {
  final String url;
  final String readySelector;
  final cj.PersistCookieJar? cookieJar;
  final Duration timeout;

  const _WebViewScraperPage({
    required this.url,
    required this.readySelector,
    required this.timeout,
    this.cookieJar,
  });

  @override
  State<_WebViewScraperPage> createState() => _WebViewScraperPageState();
}

class _WebViewScraperPageState extends State<_WebViewScraperPage> {
  InAppWebViewController? _controller;
  Timer? _pollTimer;
  Timer? _watchdog;
  bool _checking = true;
  bool _challenge = false;
  bool _completed = false;
  bool _inspecting = false;

  @override
  void initState() {
    super.initState();
    _watchdog = Timer(widget.timeout, () {
      _finishWithError('Timed out waiting for the source page.');
    });
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _watchdog?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading source'),
        actions: [
          IconButton(
            tooltip: 'Reload',
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller?.reload(),
          ),
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              domStorageEnabled: true,
              javaScriptCanOpenWindowsAutomatically: true,
              mediaPlaybackRequiresUserGesture: true,
            ),
            onWebViewCreated: (controller) => _controller = controller,
            onLoadStart: (controller, url) {
              if (!mounted || _completed) return;
              setState(() {
                _checking = true;
                _challenge = false;
              });
            },
            onLoadStop: (controller, url) async {
              _controller = controller;
              await _inspect(controller);
              _pollTimer?.cancel();
              _pollTimer = Timer.periodic(
                const Duration(seconds: 1),
                (_) => unawaited(_inspect(controller)),
              );
            },
            onReceivedError: (controller, request, error) {
              if (request.isForMainFrame == true) {
                debugPrint('WebView navigation error: ${error.description}');
              }
            },
            onReceivedHttpError: (controller, request, response) {
              if (request.isForMainFrame == true) {
                debugPrint('WebView HTTP status: ${response.statusCode}');
              }
            },
            onConsoleMessage: (controller, message) {
              debugPrint('[Source WebView] ${message.message}');
            },
          ),
          if (_challenge)
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Verification is required. Complete it in the page above. '
                        'If a CAPTCHA or human check is required, complete it manually.',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (_checking && !_challenge)
            const Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
    );
  }

  void _startPolling(InAppWebViewController controller) {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => unawaited(_inspect(controller)),
    );
  }

  Future<void> _inspect(InAppWebViewController controller) async {
    if (_completed || _inspecting) return;
    _inspecting = true;
    try {
      final selector = jsonEncode(widget.readySelector);
      final result = await controller.evaluateJavascript(source: '''
        (() => {
          const title = (document.title || '').toLowerCase();
          const body = document.body ? document.body.innerText.toLowerCase() : '';
          const html = document.documentElement
            ? document.documentElement.innerHTML.toLowerCase() : '';
          const element = document.querySelector($selector);
          const ready = !!element &&
            (((element.innerText || element.textContent || '').trim().length > 0)
              || element.children.length > 0);
          const challenge = title.includes('just a moment') ||
            body.includes('performing security verification') ||
            body.includes('checking your browser') ||
            html.includes('challenge-platform') || html.includes('cf-chl-');
          return { ready: ready, challenge: challenge };
        })();
      ''');

      if (result is! Map) return;
      if (result['ready'] == true) {
        await _returnHtml(controller);
        return;
      }
      if (mounted && !_completed) {
        setState(() {
          _checking = false;
          _challenge = result['challenge'] == true;
        });
      }
    } catch (error) {
      debugPrint('Could not inspect source page: $error');
    } finally {
      _inspecting = false;
    }
  }

  Future<void> _returnHtml(InAppWebViewController controller) async {
    if (_completed) return;
    final result = await controller.evaluateJavascript(
      source: 'document.documentElement.outerHTML;',
    );
    if (result == null || result.toString().trim().isEmpty) {
      _finishWithError('The source returned an empty page.');
      return;
    }

    try {
      final jar = widget.cookieJar;
      if (jar != null) {
        await WebViewScraper.syncCookiesToJar(url: widget.url, cookieJar: jar);
      }
    } catch (error) {
      debugPrint('Cookie synchronization failed: $error');
    }

    if (!mounted || _completed) return;
    _completed = true;
    _pollTimer?.cancel();
    _watchdog?.cancel();
    Navigator.of(context).pop(result.toString());
  }

  void _finishWithError(String message) {
    if (!mounted || _completed) return;
    _completed = true;
    _pollTimer?.cancel();
    _watchdog?.cancel();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    Navigator.of(context).pop();
  }
}
