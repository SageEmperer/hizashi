import 'package:hizashi/models/novel.dart';

abstract class BaseNovelSource {
  String get sourceId;

  Future<List<NovelModal>> fetchPopular({int page = 1});

  Future<List<NovelModal>> fetchNew({int page = 1});

  Future<List<NovelModal>> search(String query, {int page = 1});

  // novel detail
  Future<NovelDetailModal> fetchNovelDetail(String novelId);

  // novel chapters
  Future<List<NovelChapterModal>> fetchNovelChapters(String novelId);
}
