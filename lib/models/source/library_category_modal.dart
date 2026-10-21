// lib/models/source/library_category_modal.dart

enum LibraryCategoryType { Manga, Novel }

class LibraryCategoryModal {
  final String name;
  final bool isHidden;
  final LibraryCategoryType type;

  const LibraryCategoryModal({
    required this.name,
    required this.type,
    this.isHidden = false,
  });

  const LibraryCategoryModal.manga({required this.name, this.isHidden = false})
    : type = LibraryCategoryType.Manga;

  const LibraryCategoryModal.novel({required this.name, this.isHidden = false})
    : type = LibraryCategoryType.Novel;
}
