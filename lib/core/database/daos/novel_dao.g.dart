// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel_dao.dart';

// ignore_for_file: type=lint
mixin _$NovelDaoMixin on DatabaseAccessor<AppDatabase> {
  $NovelTableTable get novelTable => attachedDatabase.novelTable;
  $NovelChapterTableTable get novelChapterTable =>
      attachedDatabase.novelChapterTable;
  NovelDaoManager get managers => NovelDaoManager(this);
}

class NovelDaoManager {
  final _$NovelDaoMixin _db;
  NovelDaoManager(this._db);
  $$NovelTableTableTableManager get novelTable =>
      $$NovelTableTableTableManager(_db.attachedDatabase, _db.novelTable);
  $$NovelChapterTableTableTableManager get novelChapterTable =>
      $$NovelChapterTableTableTableManager(
        _db.attachedDatabase,
        _db.novelChapterTable,
      );
}
