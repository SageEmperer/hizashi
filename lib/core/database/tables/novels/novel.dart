// lib/core/database/tables/novels/novel.dart

import 'package:drift/drift.dart';

class NovelTable extends Table {
  // NovelTable() : super('novels');

  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get author => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get coverUrl => text()();
  TextColumn get sourceId => text()();
  TextColumn get novelId => text()();
  IntColumn get chapterCount => integer()();
  DateTimeColumn get lastRead => dateTime()();

  // @override
  // Set<Column> get primaryKey => {id};
}
