import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Persists a hint about domains where browser verification recently completed.
/// This is a hint only; it does not prove a session is currently valid.
class CfSessionStore {
  CfSessionStore._();
  static final CfSessionStore instance = CfSessionStore._();

  Map<String, int> _lastVerifiedMs = <String, int>{};
  File? _file;
  Future<void>? _loading;
  Future<void> _writeQueue = Future<void>.value();

  Future<void> _ensureLoaded() => _loading ??= _load();

  Future<void> _load() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      _file = File('${dir.path}/.cf_sessions.json');
      if (!await _file!.exists()) return;

      final decoded = jsonDecode(await _file!.readAsString());
      if (decoded is! Map) return;
      final loaded = <String, int>{};
      decoded.forEach((key, value) {
        if (key is String && value is num) loaded[key] = value.toInt();
      });
      _lastVerifiedMs = loaded;
    } catch (_) {
      // A corrupt cache must not prevent network requests.
      _lastVerifiedMs = <String, int>{};
    }
  }

  Future<void> markVerified(String domain) async {
    await _ensureLoaded();
    _lastVerifiedMs[_normalize(domain)] = DateTime.now().millisecondsSinceEpoch;
    await _persist();
  }

  Future<bool> isLikelyValid(
    String domain, {
    Duration ttl = const Duration(minutes: 25),
  }) async {
    await _ensureLoaded();
    final timestamp = _lastVerifiedMs[_normalize(domain)];
    if (timestamp == null) return false;
    final age = DateTime.now().millisecondsSinceEpoch - timestamp;
    return age >= 0 && age < ttl.inMilliseconds;
  }

  Future<void> invalidate(String domain) async {
    await _ensureLoaded();
    _lastVerifiedMs.remove(_normalize(domain));
    await _persist();
  }

  Future<void> _persist() async {
    final file = _file;
    if (file == null) return;
    final snapshot = jsonEncode(_lastVerifiedMs);
    _writeQueue = _writeQueue.then((_) async {
      try {
        await file.writeAsString(snapshot, flush: true);
      } catch (_) {
        // Persistence is best-effort.
      }
    });
    await _writeQueue;
  }

  String _normalize(String domain) =>
      domain.trim().toLowerCase().replaceFirst(RegExp(r'\.$'), '');
}
