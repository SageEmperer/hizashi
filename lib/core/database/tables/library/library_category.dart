// lib/core/database/tables/library/library_category.dart

import 'package:drift/drift.dart';

class LibraryCategoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  // Stores: manga or novel
  TextColumn get type => text()();

  BoolColumn get isHidden => boolean().withDefault(const Constant(false))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {name, type},
  ];
}
