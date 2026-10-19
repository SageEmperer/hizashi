import 'package:flutter/material.dart';
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
      setState(() {
        novelDetail = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novel Detail")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // novel cover================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Novel cover
                    // novel image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://freewebnovel.com/cache/cover-webp/1/1991/1991-1653728234-w100.webp",
                        fit: BoxFit.contain,
                        height: 170,
                        width: 120,
                      ),
                    ),
                    // novel small info
                    SizedBox(width: 10),
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
                              // line height
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Author name",
                            style: TextStyle(fontSize: 12),
                          ),
                          const Text(
                            "Novel status",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Novel Cover end here ================

                // ======= novel activity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _novelHelperButtons(
                      context,
                      icon: Icons.bookmark_border,
                      label: "Add To Library",
                      onPressed: () {
                        print("Added to library");
                      },
                    ),
                    _novelHelperButtons(
                      context,
                      icon: Icons.timer_outlined,
                      label: "Last Read",
                      onPressed: () {
                        print("27 days");
                      },
                      isActive: false,
                    ),
                    _novelHelperButtons(
                      context,
                      icon: Icons.download_outlined,
                      label: "Download",
                      onPressed: () {
                        print("Download clicked");
                      },
                      isActive: false,
                    ),
                    _novelHelperButtons(
                      context,
                      icon: Icons.share_outlined,
                      label: "Share",
                      onPressed: () {
                        print("Share clicked");
                      },
                      isActive: false,
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // ======= novel activity end
                Text(
                  """Growing up in poverty, Sunny never expected anything good from life. However, even he did not anticipate being chosen by the Nightmare Spell and becoming one of the Awakened

                  – an elite group of people gifted with supernatural powers.

                  Transported into a ruined magical world, he found himself facing against terrible monsters

                  – and other Awakened

                  – in a deadly battle of survival.

                  What's worse, the divine power he received happened to possess a small, but potentially fatal side effect…""",
                  style: TextStyle(fontSize: 12),
                ),

                // ============ expanded
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "398 Chapters",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                      const Text("Chapter 1"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========================= components ============================

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
}
