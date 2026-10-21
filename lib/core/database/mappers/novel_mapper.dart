// lib/core/database/mappers/novel_mapper.dart
import 'package:hizashi/models/novel.dart';
import 'package:drift/drift.dart' show Value;
import '../../../../core/database/app_database.dart';

extension NovelMapper on NovelTableData {
  NovelModal toNovelModal() {
    return NovelModal(
      sourceId: sourceId,
      novelId: novelId,
      title: title,
      coverUrl: coverUrl,
    );
  }

  NovelDetailModal toDetailModal() {
    return NovelDetailModal(
      sourceId: sourceId,
      novelId: novelId,
      title: title,
      coverUrl: coverUrl,
      description: description ?? '',
      author: author,
      status: null,
      genres: [],
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
      chapterCount: const Value(0), // ← fixed
      lastRead: Value(DateTime.now()), // ← fixed
    );
  }
}

// ======= Novel Chapter ========

extension NovelChapterMapper on NovelChapterTableData {
  NovelChapterModal toNovelChapterModal() {
    return NovelChapterModal(
      sourceId: sourceId,
      novelId: novelId,
      chapterId: chapterId,
      title: title,
      url: url,
      chapterNumber: chapterNumber,
    );
  }
}

// This must be on NovelChapterModal (your model), not on TableData
extension NovelChapterCompanionMapper on NovelChapterModal {
  NovelChapterTableCompanion toCompanion() {
    return NovelChapterTableCompanion.insert(
      sourceId: sourceId,
      novelId: novelId,
      chapterId: chapterId,
      title: title,
      url: url,
      chapterNumber: chapterNumber,
    );
  }
}
