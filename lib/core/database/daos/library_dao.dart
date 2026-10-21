// lib/core/database/daos/library_dao.dart

import 'package:drift/drift.dart';
import 'package:hizashi/core/database/app_database.dart';
import 'package:hizashi/core/database/tables/library/library_category.dart';
import 'package:hizashi/models/source/library_category_modal.dart';

part 'library_dao.g.dart';

@DriftAccessor(tables: [LibraryCategoryTable])
class LibraryDao extends DatabaseAccessor<AppDatabase> with _$LibraryDaoMixin {
  LibraryDao(AppDatabase db) : super(db);

  // --------------------------------------------------
  // DEFAULT CATEGORIES
  // --------------------------------------------------

  Future<void> ensureDefaultCategories() async {
    await transaction(() async {
      for (final type in LibraryCategoryType.values) {
        final categoryType = type.name;

        final existing =
            await (select(libraryCategoryTable)..where(
                  (t) => t.type.equals(categoryType) & t.name.equals('Reading'),
                ))
                .getSingleOrNull();

        if (existing == null) {
          await into(libraryCategoryTable).insert(
            LibraryCategoryTableCompanion.insert(
              name: 'Reading',
              type: categoryType,
            ),
            mode: InsertMode.insertOrIgnore,
          );
        }
      }
    });
  }

  // --------------------------------------------------
  // FETCH
  // --------------------------------------------------

  Future<List<LibraryCategoryModal>> getAllCategories() async {
    await ensureDefaultCategories();

    final rows =
        await (select(libraryCategoryTable)..orderBy([
              (t) => OrderingTerm.asc(t.type),
              (t) => OrderingTerm.asc(t.id),
            ]))
            .get();

    return rows.map(_toModal).toList();
  }

  Future<List<LibraryCategoryModal>> getCategoriesByType(
    LibraryCategoryType type,
  ) async {
    await ensureDefaultCategories();

    final rows =
        await (select(libraryCategoryTable)
              ..where((t) => t.type.equals(type.name))
              ..orderBy([(t) => OrderingTerm.asc(t.id)]))
            .get();

    return rows.map(_toModal).toList();
  }

  Future<LibraryCategoryModal?> getCategory(
    String name,
    LibraryCategoryType type,
  ) async {
    final row =
        await (select(libraryCategoryTable)
              ..where((t) => t.name.equals(name) & t.type.equals(type.name)))
            .getSingleOrNull();

    return row == null ? null : _toModal(row);
  }

  // --------------------------------------------------
  // SAVE
  // --------------------------------------------------

  Future<void> saveCategory(LibraryCategoryModal category) async {
    final name = category.name.trim();

    if (name.isEmpty) {
      throw ArgumentError('Category name cannot be empty.');
    }

    await into(libraryCategoryTable).insert(
      LibraryCategoryTableCompanion.insert(
        name: name,
        type: category.type.name,
        isHidden: Value(category.isHidden),
      ),
      mode: InsertMode.insertOrAbort,
    );
  }

  // --------------------------------------------------
  // UPDATE
  // --------------------------------------------------

  Future<bool> updateCategory({
    required String oldName,
    required LibraryCategoryType oldType,
    required LibraryCategoryModal category,
  }) async {
    final newName = category.name.trim();

    if (newName.isEmpty) {
      throw ArgumentError('Category name cannot be empty.');
    }

    // Keep the default Reading category's name and type fixed.
    if (oldName == 'Reading' &&
        (newName != 'Reading' || category.type != oldType)) {
      throw StateError(
        'The default Reading category cannot be renamed or moved.',
      );
    }

    final changed =
        await (update(libraryCategoryTable)..where(
              (t) => t.name.equals(oldName) & t.type.equals(oldType.name),
            ))
            .write(
              LibraryCategoryTableCompanion(
                name: Value(newName),
                type: Value(category.type.name),
                isHidden: Value(category.isHidden),
              ),
            );

    return changed > 0;
  }

  // --------------------------------------------------
  // DELETE
  // --------------------------------------------------

  Future<bool> deleteCategory(String name, LibraryCategoryType type) async {
    if (name == 'Reading') {
      throw StateError('The default Reading category cannot be deleted.');
    }

    final deleted = await (delete(
      libraryCategoryTable,
    )..where((t) => t.name.equals(name) & t.type.equals(type.name))).go();

    return deleted > 0;
  }

  // --------------------------------------------------
  // MAPPER
  // --------------------------------------------------

  LibraryCategoryModal _toModal(LibraryCategoryTableData row) {
    return LibraryCategoryModal(
      name: row.name,
      isHidden: row.isHidden,
      type: LibraryCategoryType.values.byName(row.type),
    );
  }
}
