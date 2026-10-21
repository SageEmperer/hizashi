// lib/core/database/daos/novel_dao.dart

import 'package:drift/drift.dart';
import 'package:hizashi/core/database/app_database.dart';
import 'package:hizashi/core/database/mappers/novel_mapper.dart';
import 'package:hizashi/core/database/tables/novels/novel.dart';
import 'package:hizashi/core/utils/database_utils.dart';
import 'package:hizashi/models/novel.dart';

part 'novel_dao.g.dart';

@DriftAccessor(tables: [NovelTable, NovelChapterTable])
class NovelDao extends DatabaseAccessor<AppDatabase> with _$NovelDaoMixin {
  NovelDao(AppDatabase db) : super(db);

  Future<NovelDetailModal?> getNovelDetail(
    String sourceId,
    String novelId,
  ) async {
    final normalizedSourceId = normalizeSourceId(sourceId);

    final row =
        await (select(novelTable)..where(
              (table) =>
                  table.sourceId.equals(normalizedSourceId) &
                  table.novelId.equals(novelId),
            ))
            .getSingleOrNull();

    return row?.toDetailModal();
  }

  Future<void> saveNovelDetail(
    NovelDetailModal detail, {
    String? sourceId,
  }) async {
    final normalizedSourceId = normalizeSourceId(sourceId ?? detail.sourceId);

    final companion = NovelTableCompanion.insert(
      title: detail.title,
      coverUrl: detail.coverUrl,
      sourceId: normalizedSourceId,
      novelId: detail.novelId,
      description: Value(detail.description),
      author: Value(detail.author),
    );

    try {
      await into(novelTable).insert(
        companion,
        onConflict: DoUpdate(
          (_) => companion,
          target: [novelTable.sourceId, novelTable.novelId], // ← important
        ),
      );

      final saved =
          await (select(novelTable)..where(
                (t) =>
                    t.sourceId.equals(normalizedSourceId) &
                    t.novelId.equals(detail.novelId),
              ))
              .getSingleOrNull();

      if (saved == null) {
        throw StateError(
          'Novel was not found after saving: $normalizedSourceId / ${detail.novelId}',
        );
      }

      print(
        'Novel saved: ${saved.title}, '
        'sourceId=${saved.sourceId}, novelId=${saved.novelId}',
      );
    } catch (e, stackTrace) {
      print('Failed to save novel: $e');
      print(stackTrace);
      rethrow;
    }
  }

  Future<bool> exists(String sourceId, String novelId) async {
    final normalizedSourceId = normalizeSourceId(sourceId);

    final row =
        await (select(novelTable)..where(
              (table) =>
                  table.sourceId.equals(normalizedSourceId) &
                  table.novelId.equals(novelId),
            ))
            .getSingleOrNull();

    return row != null;
  }

  // ============= saving the novel chapters ============
  Future<void> saveNovelChapters(List<NovelChapterModal> chapters) async {
    if (chapters.isEmpty) return;

    await batch((batch) {
      for (final chapter in chapters) {
        final cleanSourceId = normalizeSourceId(chapter.sourceId);
        batch.insert(
          novelChapterTable,
          NovelChapterTableCompanion.insert(
            sourceId: cleanSourceId,
            novelId: chapter.novelId,
            chapterId: chapter.chapterId,
            title: chapter.title,
            url: chapter.url,
            chapterNumber: chapter.chapterNumber,
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  // ============= fetch novel chapters from DB ============
  Future<List<NovelChapterModal>> getNovelChapters(
    String sourceId,
    String novelId,
  ) async {
    final normalizedSourceId = normalizeSourceId(sourceId);

    final rows =
        await (select(novelChapterTable)
              ..where(
                (t) =>
                    t.sourceId.equals(normalizedSourceId) &
                    t.novelId.equals(novelId),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.chapterNumber)]))
            .get();

    return rows
        .map(
          (row) => NovelChapterModal(
            sourceId: row.sourceId,
            novelId: row.novelId,
            chapterId: row.chapterId,
            title: row.title,
            url: row.url,
            chapterNumber: row.chapterNumber,
          ),
        )
        .toList();
  }
}
