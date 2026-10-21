import 'package:flutter/material.dart';
import 'package:hizashi/common/widgets/baseUi/CustomBadge.dart';
import 'package:hizashi/constants/novel_sources.dart';
import 'package:hizashi/core/database/app_database.dart';
import 'package:hizashi/core/database/daos/library_dao.dart';
import 'package:hizashi/core/database/daos/novel_dao.dart';
import 'package:hizashi/models/novel.dart';
import 'package:hizashi/models/source/source.dart';
import 'package:hizashi/sources/core/base_novel_source.dart';
import 'package:hizashi/sources/core/novel_source_register.dart';
import 'package:hizashi/models/source/library_category_modal.dart';

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
  late final NovelDao _dao;
  late final LibraryDao _libraryDao;

  NovelDetailModal? novelDetail;
  final List<NovelChapterModal> chapterLists = [];

  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    sourceInfo = NovelSourcesConstants.getSourceFromString(widget.sourceId);
    _novelSource = NovelSourceRegistry().getSource(widget.sourceId);
    _dao = NovelDao(AppDatabase()); // or use a shared instance
    _libraryDao = LibraryDao(AppDatabase());

    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadData({bool forceRefresh = false}) async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      NovelDetailModal detail;
      List<NovelChapterModal> chapters;

      if (!forceRefresh) {
        // ---------- Novel Detail ----------
        final cachedDetail = await _dao.getNovelDetail(
          widget.sourceId,
          widget.novelId,
        );

        if (cachedDetail != null) {
          detail = cachedDetail;
        } else {
          detail = await _novelSource.fetchNovelDetail(widget.novelId);
          await _dao.saveNovelDetail(detail);
        }

        // ---------- Chapters ----------
        final cachedChapters = await _dao.getNovelChapters(
          widget.sourceId,
          widget.novelId,
        );

        if (cachedChapters.isNotEmpty) {
          chapters = cachedChapters;
        } else {
          chapters = await _novelSource.fetchNovelChapters(widget.novelId);
          await _dao.saveNovelChapters(chapters);
        }
      } else {
        // Force refresh both
        detail = await _novelSource.fetchNovelDetail(widget.novelId);
        await _dao.saveNovelDetail(detail);

        chapters = await _novelSource.fetchNovelChapters(widget.novelId);
        await _dao.saveNovelChapters(chapters);
      }

      if (!mounted) return;
      setState(() {
        novelDetail = detail;
        chapterLists
          ..clear()
          ..addAll(chapters.reversed);
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sourceInfo?.sourceName ?? 'Source'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _loadData(forceRefresh: true),
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : error != null
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error: $error', textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _loadData(forceRefresh: true),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: () => _loadData(forceRefresh: true),
                child: CustomScrollView(
                  slivers: [
                    // ---------- Header ----------
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cover + Info
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    novelDetail?.coverUrl ?? '',
                                    fit: BoxFit.contain,
                                    height: 170,
                                    width: 120,
                                    errorBuilder: (_, __, ___) =>
                                        const SizedBox(height: 170, width: 120),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        novelDetail?.title ?? '',
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
                                        value: novelDetail?.author ?? 'Unknown',
                                      ),
                                      const SizedBox(height: 8),
                                      _novelSmallInfo(
                                        context,
                                        icon: Icons.access_time_filled_sharp,
                                        label: "Status",
                                        value: novelDetail?.status ?? 'Unknown',
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children:
                                            novelDetail?.genres
                                                .map(
                                                  (g) => CustomBadge(
                                                    label: g.name,
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

                            // Helper buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _novelHelperButtons(
                                  context,
                                  icon: Icons.bookmark_border,
                                  label: "Add To Library",
                                  onPressed: () => _showLibraryDialog(
                                    context,
                                    sourceId: widget.sourceId,
                                    novelId: widget.novelId,
                                  ),
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
                              novelDetail?.description ?? '',
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

                    // ---------- Chapters ----------
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
                            chapterNumber: chapter.chapterNumber,
                            title: chapter.title,
                          ),
                        );
                      }, childCount: chapterLists.length),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // ========================= components ============================

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

  Widget _novelHelperButtons(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isActive = true,
  }) {
    return Column(
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

  Widget _novelChapters(
    BuildContext context, {
    required int chapterNumber,
    required String title,
    String? releaseDate,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Column(
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
                if (releaseDate?.isNotEmpty == true) ...[
                  const SizedBox(height: 2),
                  Text(
                    releaseDate!,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
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

  Future<void> _showLibraryDialog(
    BuildContext context, {
    required String sourceId,
    required String novelId,
  }) async {
    final categories = await _libraryDao.getCategoriesByType(
      LibraryCategoryType.Novel,
    );

    if (!context.mounted) return;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return _LibraryDialogContent(
          categories: categories,
          libraryDao: _libraryDao,
        );
      },
    );
  }
}

class _LibraryDialogContent extends StatefulWidget {
  final List<LibraryCategoryModal> categories;
  final LibraryDao libraryDao;

  const _LibraryDialogContent({
    required this.categories,
    required this.libraryDao,
  });

  @override
  State<_LibraryDialogContent> createState() => _LibraryDialogContentState();
}

class _LibraryDialogContentState extends State<_LibraryDialogContent> {
  late final Set<String> selectedCategories;
  late final TextEditingController categoryController;

  @override
  void initState() {
    super.initState();
    selectedCategories = {};
    categoryController = TextEditingController();
  }

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add to Library'),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: Column(
          children: [
            Expanded(
              child: widget.categories.isEmpty
                  ? const Center(child: Text('No categories found'))
                  : ListView.builder(
                      itemCount: widget.categories.length,
                      itemBuilder: (context, index) {
                        final category = widget.categories[index];

                        return CheckboxListTile(
                          value: selectedCategories.contains(category.name),
                          title: Text(category.name),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (checked) {
                            setState(() {
                              if (checked == true) {
                                selectedCategories.add(category.name);
                              } else {
                                selectedCategories.remove(category.name);
                              }
                            });
                          },
                        );
                      },
                    ),
            ),
            const Divider(),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                hintText: 'New category',
                prefixIcon: Icon(Icons.edit_outlined),
                border: OutlineInputBorder(),
                isDense: true,
              ),
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            final newName = categoryController.text.trim();

            try {
              if (newName.isNotEmpty) {
                final alreadyExists = widget.categories.any(
                  (category) =>
                      category.name.toLowerCase() == newName.toLowerCase(),
                );

                if (!alreadyExists) {
                  await widget.libraryDao.saveCategory(
                    LibraryCategoryModal.novel(name: newName),
                  );
                }

                selectedCategories.add(newName);
              }

              if (!context.mounted) return;
              Navigator.pop(context);

              debugPrint('Selected categories: $selectedCategories');
            } catch (e) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to save category: $e')),
              );
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
