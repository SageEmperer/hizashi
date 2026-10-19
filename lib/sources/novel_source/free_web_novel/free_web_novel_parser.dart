import 'package:hizashi/models/source/source.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:hizashi/models/novel.dart';

class FreeWebNovelParser {
  final SourceModel sourceInfo;

  FreeWebNovelParser({required this.sourceInfo});

  List<NovelModal> parseNovelList(String html) {
    final document = html_parser.parse(html);
    // Replace with selectors from the actual website.
    final novelElements = document.querySelectorAll('.novel-item');

    final novels = <NovelModal>[];

    for (final element in document.querySelectorAll('.li-row')) {
      final titleElement = element.querySelector('.tit a');
      final imageElement = element.querySelector('img');
      final scribeUrl = titleElement?.attributes['href'];
      // split by '/' and get end of the string
      final id = scribeUrl?.split('/').last;

      if (id == null || id.isEmpty) {
        continue;
      }

      final title = titleElement?.text.trim();

      String? image =
          imageElement?.attributes['data-src'] ??
          imageElement?.attributes['src'];

      if (title == null || title.isEmpty) {
        continue;
      }

      if (image != null && image.isNotEmpty) {
        image = "${sourceInfo.sourceUrl}$image";
      }

      novels.add(
        NovelModal(
          title: title,
          coverUrl: image != null && image.isNotEmpty ? image : '',
          sourceId: sourceInfo.sourceId.toString(),
          novelId: id,
        ),
      );
    }

    return novels;
  }

  NovelDetailModal? parseNovelDetail(String html, String novelId) {
    final document = html_parser.parse(html);
    final titleElement = document.querySelector('h1.tit');

    return NovelDetailModal(
      sourceId: sourceInfo.sourceId.toString(),
      novelId: novelId,
      title: titleElement?.text.trim() ?? "",
      coverUrl:
          "https://freewebnovel.com/cache/cover-webp/1/1991/1991-1653728234-w100.webp",
      description: "Shadow Slave",
    );
  }
}
