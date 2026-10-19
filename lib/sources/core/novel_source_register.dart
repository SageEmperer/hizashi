import 'package:hizashi/constants/novel_sources.dart';
import 'package:hizashi/models/source/source.dart';
import 'package:hizashi/sources/core/base_novel_source.dart';
import 'package:hizashi/sources/novel_source/free_web_novel/free_web_novel_parser.dart';
import 'package:hizashi/sources/novel_source/free_web_novel/free_web_novel_source.dart';

class NovelSourceRegistry {
  BaseNovelSource getSource(String sourceId) {
    // SourceModel scribeSource = NovelSourcesConstants.getSourceFromString(
    //   sourceId as SourceId,
    // )

    final sourceInfo = NovelSourcesConstants.getSourceFromString(sourceId);

    if (sourceInfo == null) {
      throw ArgumentError('Source configuration not found: $sourceId');
    }

    if (sourceId == 'freeWebNovel') {
      return FreeWebNovelSource(
        parser: FreeWebNovelParser(sourceInfo: sourceInfo),
      );
    }

    throw ArgumentError('Unknown novel source: $sourceId');
  }
}
