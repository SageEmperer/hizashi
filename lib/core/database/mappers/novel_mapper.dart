// lib/core/database/mappers/novel_mapper.dart
import 'package:hizashi/models/novel.dart';
import 'package:drift/drift.dart' show Value;

import '../../../../core/database/app_database.dart';

extension NovelMapper on NovelTableData {
  // Convert Drift DB row -> Your NovelModal
  NovelModal toNovelModal() {
    return NovelModal(
      sourceId: sourceId,
      novelId: novelId,
      title: title,
      coverUrl: coverUrl,
    );
  }

  // Convert Drift DB row -> Your NovelDetailModal
  NovelDetailModal toDetailModal() {
    return NovelDetailModal(
      sourceId: sourceId,
      novelId: novelId,
      title: title,
      coverUrl: coverUrl,
      description: description ?? '',
      author: author,
      status: null, // map if you have a status column
      genres: [], // handle relational genres separately
    );
  }
}

extension NovelDetailCompanionMapper on NovelDetailModal {
  NovelTableCompanion toCompanion() {
    return NovelTableCompanion.insert(
      title: title,
      coverUrl: coverUrl,
      sourceId: sourceId,
      novelId: novelId,
      description: Value(description),
      author: Value(author),
      chapterCount: 0, // Update this if your parser extracts total chapters
      lastRead: DateTime.now(),
    );
  }
}
