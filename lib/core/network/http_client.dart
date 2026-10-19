import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

class DioClient {
  final Dio dio;
  final PersistCookieJar cookieJar;
  final String origin;

  DioClient(this.dio, this.cookieJar, this.origin);
}

/// One Dio instance and persistent cookie jar per normalized origin.
class AppHttpClient {
  AppHttpClient._();

  static final Map<String, Future<DioClient>> _clients = {};

  static Future<DioClient> create({
    required String baseUrl,
    Map<String, String>? extraHeaders,
  }) {
    final origin = _normalizeOrigin(baseUrl);
    return _clients.putIfAbsent(
      origin,
      () => _createClient(origin, extraHeaders).catchError(
        (Object error, StackTrace stackTrace) {
          _clients.remove(origin);
          Error.throwWithStackTrace(error, stackTrace);
        },
      ),
    );
  }

  static Future<DioClient> _createClient(
    String origin,
    Map<String, String>? extraHeaders,
  ) async {
    final dir = await getApplicationDocumentsDirectory();
    final hostKey = Uri.parse(origin).host
        .replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_');
    final jar = PersistCookieJar(
      storage: FileStorage('${dir.path}/.cookies/$hostKey/'),
    );

    final dio = Dio(BaseOptions(
      baseUrl: '$origin/',
      connectTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 25),
      headers: <String, dynamic>{
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
            'AppleWebKit/537.36 (KHTML, like Gecko) '
            'Chrome/131.0.0.0 Safari/537.36',
        'Accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,'
            'image/avif,image/webp,image/apng,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.9',
        ...?extraHeaders,
      },
      followRedirects: true,
      maxRedirects: 5,
      // Let the caller classify HTTP statuses such as 403 and 429.
      validateStatus: (status) => status != null && status >= 200 && status < 600,
    ));

    dio.interceptors.add(CookieManager(jar));
    return DioClient(dio, jar, origin);
  }

  static String _normalizeOrigin(String baseUrl) {
    final uri = Uri.parse(baseUrl);
    if (!uri.hasScheme || uri.host.isEmpty ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      throw ArgumentError.value(baseUrl, 'baseUrl', 'Must be an absolute HTTP(S) URL');
    }
    final normalized = Uri(
      scheme: uri.scheme.toLowerCase(),
      userInfo: uri.userInfo.isEmpty ? null : uri.userInfo,
      host: uri.host.toLowerCase(),
      port: uri.hasPort ? uri.port : null,
    );
    return normalized.toString().replaceFirst(RegExp(r'/$'), '');
  }

  static Future<void> closeOrigin(String baseUrl) async {
    final origin = _normalizeOrigin(baseUrl);
    final pending = _clients.remove(origin);
    if (pending == null) return;
    try {
      (await pending).dio.close(force: true);
    } catch (_) {}
  }

  static Future<void> closeAll() async {
    final pending = _clients.values.toList(growable: false);
    _clients.clear();
    await Future.wait(pending.map((future) async {
      try {
        (await future).dio.close(force: true);
      } catch (_) {}
    }));
  }
}
