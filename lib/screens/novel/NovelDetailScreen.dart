import 'package:flutter/material.dart';
import 'package:hizashi/common/widgets/baseUi/CustomBadge.dart';
import 'package:hizashi/constants/novel_sources.dart';
import 'package:hizashi/models/novel.dart';
import 'package:hizashi/models/source/source.dart';
import 'package:hizashi/sources/core/base_novel_source.dart';
import 'package:hizashi/sources/core/novel_source_register.dart';

class NovelDetailScreen extends StatefulWidget {
  final String sourceId;
  final String novelId;

  const NovelDetailScreen({
    super.key,
    required this.sourceId,
    required this.novelId,
  });

  @override
  State<NovelDetailScreen> createState() => _NovelDetailScreenState();
}

class _NovelDetailScreenState extends State<NovelDetailScreen> {
  late final SourceModel? sourceInfo;
  late final BaseNovelSource _novelSource;

  NovelDetailModal? novelDetail;
  final List<NovelChapterModal> chapterLists = [];

  @override
  void initState() {
    super.initState();
    sourceInfo = NovelSourcesConstants.getSourceFromString(widget.sourceId);
    _novelSource = NovelSourceRegistry().getSource(widget.sourceId);
    fetchNovelDetail();
  }

  Future<void> fetchNovelDetail() async {
    if (novelDetail == null) {
      final result = await _novelSource.fetchNovelDetail(widget.novelId);
      final chapters = await _novelSource.fetchNovelChapters(widget.novelId);

      print(chapters);

      setState(() {
        novelDetail = result;
        chapterLists.addAll(chapters.reversed);
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${sourceInfo?.sourceName ?? 'Source'}")),
      body: SafeArea(
        child: novelDetail == null
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: [
                  // Header section containing cover, info, buttons, description
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Novel cover row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "${novelDetail?.coverUrl}",
                                  fit: BoxFit.contain,
                                  height: 170,
                                  width: 120,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      novelDetail?.title ?? 'Loading...',
                                      softWrap: true,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        height: 1.1,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    _novelSmallInfo(
                                      context,
                                      icon: Icons.person,
                                      label: "Author",
                                      value:
                                          novelDetail?.author ?? 'Loading...',
                                    ),
                                    const SizedBox(height: 8),
                                    _novelSmallInfo(
                                      context,
                                      icon: Icons.access_time_filled_sharp,
                                      label: "Status",
                                      value:
                                          novelDetail?.status ?? 'Loading...',
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children:
                                          novelDetail?.genres
                                              .map(
                                                (genre) => CustomBadge(
                                                  label: genre.name,
                                                ),
                                              )
                                              .toList() ??
                                          [],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Helper buttons row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _novelHelperButtons(
                                context,
                                icon: Icons.bookmark_border,
                                label: "Add To Library",
                                onPressed: () => print("Added to library"),
                              ),
                              _novelHelperButtons(
                                context,
                                icon: Icons.timer_outlined,
                                label: "Last Read",
                                onPressed: () => print("27 days"),
                                isActive: false,
                              ),
                              _novelHelperButtons(
                                context,
                                icon: Icons.download_outlined,
                                label: "Download",
                                onPressed: () => print("Download clicked"),
                                isActive: false,
                              ),
                              _novelHelperButtons(
                                context,
                                icon: Icons.share_outlined,
                                label: "Share",
                                onPressed: () => print("Share clicked"),
                                isActive: false,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${novelDetail?.description}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "${chapterLists.isNotEmpty ? chapterLists.first.chapterNumber : 0} Chapters",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),

                  // Virtualized Chapter List (renders only visible items on screen)
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final chapter = chapterLists[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 1.0,
                        ),
                        child: _novelChapters(
                          context,
                          chapterNumber: chapter.chapterNumber ?? 0,
                          title: chapter.title,
                        ),
                      );
                    }, childCount: chapterLists.length),
                  ),
                ],
              ),
      ),
    );
  }

  // ========================= components ============================

  // ====== novel small info
  Widget _novelSmallInfo(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15),
        const SizedBox(width: 4),

        Text('$label:', style: const TextStyle(fontSize: 12)),

        const SizedBox(width: 6),

        Expanded(
          child: Text(
            value,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ====== novel helpers

  Widget _novelHelperButtons(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    isActive = true,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 20,
            color: isActive ? Colors.white : Colors.grey,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.white : Colors.grey,
          ),
        ),
      ],
    );
  }

  // ======== novel chapters
  Widget _novelChapters(
    BuildContext context, {
    required int chapterNumber,
    required String title,
    String? releaseDate = null,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                if (releaseDate?.isNotEmpty == true)
                  Text(
                    releaseDate!,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.download_for_offline_outlined),
        ),
      ],
    );
  }
}
