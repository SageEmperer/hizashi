// lib/constants/novel_sources.dart

import 'package:hizashi/models/source/source.dart';

abstract class NovelSourcesConstants {
  static const List<SourceModel> list = [
      SourceModel(
        sourceId: SourceId.freeWebNovel,
        sourceName: "Free WebNovel",
        sourceUrl: "https://freewebnovel.com",
        sourceImagePath: "assets/images/source_images/freewebnovel.png",
        sourceType: SourceType.novel,
      ),
  ];


  // get one source
  static SourceModel getSource(SourceId sourceId) {
    return list.firstWhere((element) => element.sourceId == sourceId);
  }   

  static SourceModel? getSourceFromString(String sourceIdString) {
    try {
      final enumId = SourceId.values.byName(sourceIdString);
      return getSource(enumId);
    } catch (_) {
      return null;
    }
  }
}