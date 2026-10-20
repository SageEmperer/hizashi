class NovelModal {
  final String sourceId;
  final String novelId;
  final String title;
  final String coverUrl;

  NovelModal({
    required this.sourceId,
    required this.novelId,
    required this.title,
    required this.coverUrl,
  });
}

class GenreModal {
  final String name;

  GenreModal({required this.name});
}

class NovelDetailModal {
  final String sourceId;
  final String novelId;
  final String title;
  final String coverUrl;
  final String description;
  final String? author;
  final String? status;
  // genre
  final List<GenreModal> genres;

  NovelDetailModal({
    required this.sourceId,
    required this.novelId,
    required this.title,
    required this.coverUrl,
    required this.description,
    this.author,
    this.status,
    this.genres = const [],
  });
}

class NovelChapterModal {
  final String sourceId;
  final String novelId;
  final String chapterId;
  final String title;
  final String url;
  final int? chapterNumber;

  const NovelChapterModal({
    required this.sourceId,
    required this.novelId,
    required this.chapterId,
    required this.title,
    required this.url,
    this.chapterNumber,
  });
}
