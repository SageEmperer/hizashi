enum SourceType { manga, novel }

enum SourceId {
  // Novel Sources
  freeWebNovel,

  // Manga Sources
  mangaDex,
}



class SourceModel {
  final SourceId sourceId;
  final String sourceName;
  final String sourceUrl;
  final String sourceImagePath;
  final SourceType sourceType;


  const SourceModel({
    required this.sourceId,
    required this.sourceName,
    required this.sourceUrl,
    required this.sourceImagePath,
    required this.sourceType,
  });
}