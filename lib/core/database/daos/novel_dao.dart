import 'package:drift/drift.dart';
import 'package:hizashi/models/novel.dart';
import '../app_database.dart';
import '../tables/novels/novel.dart';
import 'package:hizashi/core/database/mappers/novel_mapper.dart';

part 'novel_dao.g.dart';

@DriftAccessor(tables: [NovelTable])
class NovelDao extends DatabaseAccessor<AppDatabase> with _$NovelDaoMixin {
  NovelDao(AppDatabase db) : super(db);

  Future<NovelDetailModal?> getNovelDetail(String novelId) async {
    final novel = await (select(
      novelTable,
    )..where((t) => t.novelId.equals(novelId))).getSingleOrNull();

    if (novel == null) return null;
    return novel.toDetailModal();
  }

  // ADD THIS: Insert or update novel details when fetched from network
  Future<void> saveNovelDetail(NovelDetailModal detail) async {
    await into(novelTable).insertOnConflictUpdate(detail.toCompanion());
  }
}
