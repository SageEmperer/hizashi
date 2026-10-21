// lib/core/repositories/novel_repository.dart
import 'package:hizashi/core/database/daos/novel_dao.dart';
import 'package:hizashi/models/novel.dart';
import 'package:hizashi/sources/core/novel_source_register.dart';

class NovelRepository {
  final NovelDao _dao;
  final NovelSourceRegistry _registry;

  NovelRepository(this._dao, this._registry);

  /// Core method
  Future<NovelDetailModal> getNovelDetail({
    required String sourceId,
    required String novelId,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cached = await _dao.getNovelDetail(sourceId, novelId);
      if (cached != null) return cached;
    }

    final source = _registry.getSource(sourceId);
    final detail = await source.fetchNovelDetail(novelId);

    await _dao.saveNovelDetail(detail);
    return detail;
  }

  Future<List<NovelChapterModal>> getNovelChapters({
    required String sourceId,
    required String novelId,
  }) async {
    final source = _registry.getSource(sourceId);
    return source.fetchNovelChapters(novelId);
  }
}
