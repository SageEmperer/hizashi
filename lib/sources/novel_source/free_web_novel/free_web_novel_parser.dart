import 'package:hizashi/core/network/cloudflare_aware_fetcher.dart';
import 'package:hizashi/models/source/source.dart';
import 'package:html/dom.dart' show Element;
import 'package:html/parser.dart' as html_parser;
import 'package:hizashi/models/novel.dart';
import 'package:http/http.dart' as http;
import 'package:hizashi/core/network/http_client.dart';

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

    final descriptionElement = document.querySelector('.txt .inner');

    final description =
        descriptionElement
            ?.querySelectorAll('p')
            .map((element) => element.text.trim())
            .where((text) => text.isNotEmpty)
            .join('\n\n') ??
        '';

    // Helper: find the .item whose span title matches the requested value.
    String? getInfo(String title) {
      final items = document.querySelectorAll('.txt .item');

      for (final item in items) {
        final icon = item.querySelector('span[title]');

        if (icon?.attributes['title'] == title) {
          final value = item.querySelector('.right');
          final text = value?.text.trim();

          if (text != null && text.isNotEmpty) {
            return text;
          }
        }
      }

      return null;
    }

    // Author
    final author = getInfo('Author');

    // Status
    final status = getInfo('Status');

    // Find a metadata item by its span title.
    Element? getInfoItem(String title) {
      for (final item in document.querySelectorAll('.txt .item')) {
        if (item.querySelector('span[title]')?.attributes['title'] == title) {
          return item;
        }
      }

      return null;
    }

    // Genres
    final genres =
        getInfoItem('Genre')
            ?.querySelectorAll('.right a')
            .map((element) => element.text.trim())
            .where((name) => name.isNotEmpty)
            .toSet()
            .map((name) => GenreModal(name: name))
            .toList() ??
        <GenreModal>[];

    // Cover image
    final imageElement = document.querySelector('.pic picture img');
    final sourceElement = document.querySelector(
      '.pic picture source[type="image/webp"]',
    );

    String? coverPath;

    // Prefer the highest-resolution WebP image from srcset.
    final srcset = sourceElement?.attributes['srcset'];

    if (srcset != null && srcset.isNotEmpty) {
      final candidates = srcset.split(',');

      if (candidates.isNotEmpty) {
        // Example: /cache/cover-webp/...-w300.webp 300w
        final largestCandidate = candidates.last.trim();
        coverPath = largestCandidate.split(RegExp(r'\s+')).first;
      }
    }

    // Fall back to the regular img src.
    coverPath ??= imageElement?.attributes['src'];

    final coverUrl = coverPath == null
        ? ''
        : Uri.parse('${sourceInfo.sourceUrl}$coverPath').toString();

    return NovelDetailModal(
      sourceId: sourceInfo.sourceId.toString(),
      novelId: novelId,
      title: titleElement?.text.trim() ?? "",
      coverUrl: coverUrl,
      description: description,
      author: author,
      status: status,
      genres: genres,
    );
  }

  List<NovelChapterModal> parseNovelChapters(String html, String novelId) {
    final document = html_parser.parse(html);

    // Get the highest chapter number from the latest-chapters section.
    final latestChapterDiv = document.querySelector('ul.ul-list5');
    final lastChapter = latestChapterDiv?.querySelector('li a');

    final lastChapterMatch = RegExp(
      r'Chapter\s+(\d+)',
      caseSensitive: false,
    ).firstMatch(lastChapter?.text ?? '');

    final lastChapterNumber = lastChapterMatch != null
        ? int.parse(lastChapterMatch.group(1)!)
        : 0;

    // Generate the chapter list.
    final chapters = <NovelChapterModal>[];

    for (int chapterNum = 1; chapterNum <= lastChapterNumber; chapterNum++) {
      chapters.add(
        NovelChapterModal(
          sourceId: sourceInfo.sourceId.toString(),
          novelId: novelId,
          chapterId: '$chapterNum',
          title: 'Chapter $chapterNum',
          url: 'chapter-$chapterNum',
          chapterNumber: chapterNum,
        ),
      );
    }

    // Extract actual chapter titles and URLs from the HTML.
    for (final element in document.querySelectorAll('li a.con')) {
      final title = element.attributes['title']?.trim() ?? element.text.trim();

      final href = element.attributes['href'];

      if (href == null || href.isEmpty) continue;

      final match = RegExp(
        r'/chapter-(\d+)',
        caseSensitive: false,
      ).firstMatch(href);

      if (match == null) continue;

      final chapterNumber = int.parse(match.group(1)!);

      // Match the extracted chapter to the generated chapter.
      final index = chapters.indexWhere(
        (chapter) => chapter.chapterNumber == chapterNumber,
      );

      if (index == -1) continue;

      chapters[index] = NovelChapterModal(
        sourceId: sourceInfo.sourceId.toString(),
        novelId: novelId,
        chapterId: '$chapterNumber',
        title: title,
        url: href,
        chapterNumber: chapterNumber,
      );
    }

    return chapters;
  }
}
