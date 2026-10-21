import 'package:hizashi/constants/novel_sources.dart';
import 'package:hizashi/core/network/cloudflare_aware_fetcher.dart';
import 'package:hizashi/models/novel.dart';
import 'package:hizashi/models/source/source.dart';
import 'package:hizashi/sources/core/base_novel_source.dart';
import 'package:hizashi/sources/novel_source/free_web_novel/free_web_novel_parser.dart';

class FreeWebNovelSource extends BaseNovelSource {
  final FreeWebNovelParser parser;

  FreeWebNovelSource({required this.parser});

  @override
  String get sourceId => 'freeWebNovel';

  late final SourceModel sourceInfo =
      NovelSourcesConstants.getSourceFromString(sourceId) ??
      (throw StateError('Source configuration not found: $sourceId'));

  Future<String> _fetchPage(Uri uri) {
    return CloudflareAwareFetcher.fetchHtml(
      baseUrl: uri.origin,
      path: '${uri.path}${uri.hasQuery ? '?${uri.query}' : ''}',
      readySelector: 'body',
    );
  }

  @override
  Future<List<NovelModal>> fetchPopular({int page = 1}) async {
    final uri = Uri.parse('${sourceInfo.sourceUrl}/sort/most-popular/${page}');

    final html = await _fetchPage(uri);

    return parser.parseNovelList(html);
  }

  @override
  Future<List<NovelModal>> fetchNew({int page = 1}) async {
    // Implement using the actual latest-novels URL.
    return [];
  }

  @override
  Future<List<NovelModal>> search(String query, {int page = 1}) async {
    // Implement using the actual search URL.
    return [];
  }

  @override
  Future<NovelDetailModal> fetchNovelDetail(String novelId) async {
    print("fetching teh novel data----------------------------");
    // Implement using the actual novel detail URL.
    final uri = Uri.parse('${sourceInfo.sourceUrl}/novel/$novelId');
    final html = await _fetchPage(uri);
    return parser.parseNovelDetail(html, novelId) ??
        (throw FormatException('Unable to parse novel detail: $novelId'));
  }

  @override
  Future<List<NovelChapterModal>> fetchNovelChapters(String novelId) async {
    // Implement using the actual novel chapters URL.
    final uri = Uri.parse('${sourceInfo.sourceUrl}/novel/$novelId');
    final html = await _fetchPage(uri);
    return parser.parseNovelChapters(html, novelId);
    (throw FormatException('Unable to parse novel chapters: $novelId'));
  }
}
