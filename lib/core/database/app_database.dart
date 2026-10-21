// lib/core/database/app_database.dart
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:hizashi/core/database/tables/novels/novel.dart';
import 'package:hizashi/core/database/tables/library/library_category.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'hizashi.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [NovelTable, NovelChapterTable, LibraryCategoryTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());

  static final AppDatabase instance = AppDatabase._internal();
  factory AppDatabase() => instance;

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Create the new chapters table
          await m.createTable(novelChapterTable);
        }
        if (from < 3) {
          await m.createTable(libraryCategoryTable);
        }
      },
    );
  }
}
