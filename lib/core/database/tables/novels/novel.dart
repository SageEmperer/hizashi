// lib/core/database/tables/novels/novel.dart
import 'package:drift/drift.dart';

class NovelTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();
  TextColumn get author => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get coverUrl => text()();
  TextColumn get sourceId => text()();
  TextColumn get novelId => text()();
  IntColumn get chapterCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastRead => dateTime().nullable()();

  // IMPORTANT: this makes insertOnConflictUpdate work
  @override
  List<Set<Column>> get uniqueKeys => [
    {sourceId, novelId},
  ];
}

// ======= novel chapter ========
class NovelChapterTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get sourceId => text()();
  TextColumn get novelId => text()();
  TextColumn get chapterId => text()();
  TextColumn get title => text()();
  TextColumn get url => text()();
  IntColumn get chapterNumber => integer()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {sourceId, novelId, chapterNumber},
  ];
}
