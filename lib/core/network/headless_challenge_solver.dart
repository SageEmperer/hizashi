import 'dart:async';
import 'dart:convert';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// Loads JavaScript-rendered content in a non-visible WebView.
/// It does not solve CAPTCHAs or challenges requiring human interaction.
class HeadlessChallengeSolver {
  HeadlessChallengeSolver._();

  static Future<String> solve({
    required String url,
    required String readySelector,
    Duration timeout = const Duration(seconds: 30),
    Duration pollInterval = const Duration(milliseconds: 500),
  }) async {
    if (url.trim().isEmpty) throw ArgumentError.value(url, 'url');
    if (readySelector.trim().isEmpty) {
      throw ArgumentError.value(readySelector, 'readySelector');
    }

    final completer = Completer<String>();
    final deadline = DateTime.now().add(timeout);
    HeadlessInAppWebView? headless;
    InAppWebViewController? controller;
    Timer? watchdog;
    Timer? pollTimer;
    var disposed = false;
    var inspecting = false;

    void fail(Object error, [StackTrace? stack]) {
      if (!completer.isCompleted) completer.completeError(error, stack);
    }

    Future<void> inspect() async {
      if (disposed || completer.isCompleted || inspecting) return;
      inspecting = true;
      try {
        final active = controller;
        if (active == null) return;
        if (DateTime.now().isAfter(deadline)) {
          fail(TimeoutException('Page content did not become ready.', timeout));
          return;
        }

        // JSON encoding safely escapes quotes and backslashes in CSS selectors.
        final selector = jsonEncode(readySelector);
        final ready = await active.evaluateJavascript(source: '''
          (() => {
            const element = document.querySelector($selector);
            if (!element) return false;
            const text = (element.innerText || element.textContent || '').trim();
            return text.length > 0 || element.children.length > 0;
          })();
        ''');

        if (ready == true) {
          final html = await active.getHtml();
          if (html != null && html.trim().isNotEmpty && !completer.isCompleted) {
            completer.complete(html);
          }
        }
      } catch (error, stack) {
        if (DateTime.now().isAfter(deadline)) fail(error, stack);
      } finally {
        inspecting = false;
      }
    }

    headless = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(url)),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        domStorageEnabled: true,
        userAgent:
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
            'AppleWebKit/537.36 (KHTML, like Gecko) '
            'Chrome/131.0.0.0 Safari/537.36',
      ),
      onWebViewCreated: (value) => controller = value,
      onLoadStop: (value, uri) async {
        controller = value;
        await inspect();
      },
      onReceivedError: (value, request, error) {
        if (request.isForMainFrame == true) {
          fail(Exception('WebView navigation failed: ${error.description}'));
        }
      },
    );

    watchdog = Timer(timeout, () {
      fail(TimeoutException('Page load timed out.', timeout));
    });

    try {
      await headless.run();
      pollTimer = Timer.periodic(pollInterval, (_) => unawaited(inspect()));
      await inspect();
      return await completer.future;
    } finally {
      disposed = true;
      watchdog.cancel();
      pollTimer?.cancel();
      try {
        await headless.dispose();
      } catch (_) {}
    }
  }

  static Future<List<Cookie>> cookiesFor(String url) =>
      CookieManager.instance().getCookies(url: WebUri(url));
}
