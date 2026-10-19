import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hizashi/common/widgets/cards/bookCard.dart';
import 'package:hizashi/constants/novel_sources.dart';
import 'package:hizashi/models/novel.dart';
import 'package:hizashi/models/source/source.dart';
import 'package:hizashi/navigation/app_route_names.dart';
import 'package:hizashi/sources/core/base_novel_source.dart';
import 'package:hizashi/sources/core/novel_source_register.dart';

class SourceNovelScreen extends StatefulWidget {
  final String sourceId;
  const SourceNovelScreen({super.key, required this.sourceId});

  @override
  State<SourceNovelScreen> createState() => _SourceNovelScreenState();
}

class _SourceNovelScreenState extends State<SourceNovelScreen> {
  late final SourceModel? sourceInfo;
  late final BaseNovelSource _novelSource;

  final List<NovelModal> novels = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? errorMessage;
  int _currentPage = 1;
  bool _hasMore = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    sourceInfo = NovelSourcesConstants.getSourceFromString(widget.sourceId);
    _novelSource = NovelSourceRegistry().getSource(widget.sourceId);
    _scrollController.addListener(_onScroll);

    fetchNovels();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_isLoading || _isLoadingMore || !_hasMore) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // Trigger next page fetch when scrolled 80% down
    if (currentScroll >= maxScroll * 0.8) {
      _fetchNextPage();
    }
  }

  Future<void> fetchNovels() async {
    if (_isLoading || _isLoadingMore) return;

    setState(() {
      if (_currentPage == 1) {
        _isLoading = true;
      } else {
        _isLoadingMore = true;
      }
      errorMessage = null;
    });

    try {
      final result = await _novelSource.fetchPopular(page: _currentPage);

      if (!mounted) return;

      setState(() {
        if (result.isEmpty) {
          _hasMore = false;
        } else {
          novels.addAll(result);
          _currentPage++; // Only increment page upon successful data retrieval
        }
        _isLoading = false;
        _isLoadingMore = false;
      });

      debugPrint(
        'Source: ${_novelSource.sourceId} | Page: ${_currentPage - 1} | Fetched: ${result.length}',
      );
    } catch (e, stackTrace) {
      debugPrint('Failed to fetch novels: $e');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
        errorMessage = e.toString();
        // Stop infinite scroll attempts if rate-limited or errored to prevent looping
        _hasMore = false;
      });
    }
  }

  void _fetchNextPage() {
    if (!_hasMore || _isLoadingMore || _isLoading) return;
    fetchNovels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${sourceInfo?.sourceName ?? 'Source'}")),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (_isLoading && novels.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (errorMessage != null && novels.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(errorMessage!, textAlign: TextAlign.center),
                ),
              );
            }
            if (novels.isEmpty) {
              return const Center(child: Text("No Novels Found"));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
                childAspectRatio: 0.58,
              ),
              itemCount: novels.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= novels.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final novel = novels[index];
                return BookCard(
                  title: novel.title,
                  coverUrl: novel.coverUrl,
                  onTap: () {
                    context.pushNamed(
                      AppRouteNames.novelDetailScreen,
                      pathParameters: {
                        "sourceId": widget.sourceId,
                        "novelId": novel.novelId,
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
