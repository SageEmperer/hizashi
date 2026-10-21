// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_dao.dart';

// ignore_for_file: type=lint
mixin _$LibraryDaoMixin on DatabaseAccessor<AppDatabase> {
  $LibraryCategoryTableTable get libraryCategoryTable =>
      attachedDatabase.libraryCategoryTable;
  LibraryDaoManager get managers => LibraryDaoManager(this);
}

class LibraryDaoManager {
  final _$LibraryDaoMixin _db;
  LibraryDaoManager(this._db);
  $$LibraryCategoryTableTableTableManager get libraryCategoryTable =>
      $$LibraryCategoryTableTableTableManager(
        _db.attachedDatabase,
        _db.libraryCategoryTable,
      );
}
