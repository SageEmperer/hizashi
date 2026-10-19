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

class NovelDetailModal {
  final String sourceId;
  final String novelId;
  final String title;
  final String coverUrl;
  final String description;

  NovelDetailModal({
    required this.sourceId,
    required this.novelId,
    required this.title,
    required this.coverUrl,
    required this.description,
  });
}
