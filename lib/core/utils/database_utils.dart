// lib/core/utils/database_utils.dart
String normalizeSourceId(String sourceId) {
  return sourceId.trim().split('.').last.toLowerCase();
}
