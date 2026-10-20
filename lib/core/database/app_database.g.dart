// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NovelTableTable extends NovelTable
    with TableInfo<$NovelTableTable, NovelTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NovelTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverUrlMeta = const VerificationMeta(
    'coverUrl',
  );
  @override
  late final GeneratedColumn<String> coverUrl = GeneratedColumn<String>(
    'cover_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _novelIdMeta = const VerificationMeta(
    'novelId',
  );
  @override
  late final GeneratedColumn<String> novelId = GeneratedColumn<String>(
    'novel_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterCountMeta = const VerificationMeta(
    'chapterCount',
  );
  @override
  late final GeneratedColumn<int> chapterCount = GeneratedColumn<int>(
    'chapter_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastReadMeta = const VerificationMeta(
    'lastRead',
  );
  @override
  late final GeneratedColumn<DateTime> lastRead = GeneratedColumn<DateTime>(
    'last_read',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    author,
    description,
    coverUrl,
    sourceId,
    novelId,
    chapterCount,
    lastRead,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'novel_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<NovelTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('cover_url')) {
      context.handle(
        _coverUrlMeta,
        coverUrl.isAcceptableOrUnknown(data['cover_url']!, _coverUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_coverUrlMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('novel_id')) {
      context.handle(
        _novelIdMeta,
        novelId.isAcceptableOrUnknown(data['novel_id']!, _novelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_novelIdMeta);
    }
    if (data.containsKey('chapter_count')) {
      context.handle(
        _chapterCountMeta,
        chapterCount.isAcceptableOrUnknown(
          data['chapter_count']!,
          _chapterCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chapterCountMeta);
    }
    if (data.containsKey('last_read')) {
      context.handle(
        _lastReadMeta,
        lastRead.isAcceptableOrUnknown(data['last_read']!, _lastReadMeta),
      );
    } else if (isInserting) {
      context.missing(_lastReadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NovelTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NovelTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      coverUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_url'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      novelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}novel_id'],
      )!,
      chapterCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter_count'],
      )!,
      lastRead: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_read'],
      )!,
    );
  }

  @override
  $NovelTableTable createAlias(String alias) {
    return $NovelTableTable(attachedDatabase, alias);
  }
}

class NovelTableData extends DataClass implements Insertable<NovelTableData> {
  final int id;
  final String title;
  final String? author;
  final String? description;
  final String coverUrl;
  final String sourceId;
  final String novelId;
  final int chapterCount;
  final DateTime lastRead;
  const NovelTableData({
    required this.id,
    required this.title,
    this.author,
    this.description,
    required this.coverUrl,
    required this.sourceId,
    required this.novelId,
    required this.chapterCount,
    required this.lastRead,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['cover_url'] = Variable<String>(coverUrl);
    map['source_id'] = Variable<String>(sourceId);
    map['novel_id'] = Variable<String>(novelId);
    map['chapter_count'] = Variable<int>(chapterCount);
    map['last_read'] = Variable<DateTime>(lastRead);
    return map;
  }

  NovelTableCompanion toCompanion(bool nullToAbsent) {
    return NovelTableCompanion(
      id: Value(id),
      title: Value(title),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      coverUrl: Value(coverUrl),
      sourceId: Value(sourceId),
      novelId: Value(novelId),
      chapterCount: Value(chapterCount),
      lastRead: Value(lastRead),
    );
  }

  factory NovelTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NovelTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String?>(json['author']),
      description: serializer.fromJson<String?>(json['description']),
      coverUrl: serializer.fromJson<String>(json['coverUrl']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      novelId: serializer.fromJson<String>(json['novelId']),
      chapterCount: serializer.fromJson<int>(json['chapterCount']),
      lastRead: serializer.fromJson<DateTime>(json['lastRead']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String?>(author),
      'description': serializer.toJson<String?>(description),
      'coverUrl': serializer.toJson<String>(coverUrl),
      'sourceId': serializer.toJson<String>(sourceId),
      'novelId': serializer.toJson<String>(novelId),
      'chapterCount': serializer.toJson<int>(chapterCount),
      'lastRead': serializer.toJson<DateTime>(lastRead),
    };
  }

  NovelTableData copyWith({
    int? id,
    String? title,
    Value<String?> author = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? coverUrl,
    String? sourceId,
    String? novelId,
    int? chapterCount,
    DateTime? lastRead,
  }) => NovelTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    author: author.present ? author.value : this.author,
    description: description.present ? description.value : this.description,
    coverUrl: coverUrl ?? this.coverUrl,
    sourceId: sourceId ?? this.sourceId,
    novelId: novelId ?? this.novelId,
    chapterCount: chapterCount ?? this.chapterCount,
    lastRead: lastRead ?? this.lastRead,
  );
  NovelTableData copyWithCompanion(NovelTableCompanion data) {
    return NovelTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      description: data.description.present
          ? data.description.value
          : this.description,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      novelId: data.novelId.present ? data.novelId.value : this.novelId,
      chapterCount: data.chapterCount.present
          ? data.chapterCount.value
          : this.chapterCount,
      lastRead: data.lastRead.present ? data.lastRead.value : this.lastRead,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NovelTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('sourceId: $sourceId, ')
          ..write('novelId: $novelId, ')
          ..write('chapterCount: $chapterCount, ')
          ..write('lastRead: $lastRead')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    author,
    description,
    coverUrl,
    sourceId,
    novelId,
    chapterCount,
    lastRead,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NovelTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.author == this.author &&
          other.description == this.description &&
          other.coverUrl == this.coverUrl &&
          other.sourceId == this.sourceId &&
          other.novelId == this.novelId &&
          other.chapterCount == this.chapterCount &&
          other.lastRead == this.lastRead);
}

class NovelTableCompanion extends UpdateCompanion<NovelTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> author;
  final Value<String?> description;
  final Value<String> coverUrl;
  final Value<String> sourceId;
  final Value<String> novelId;
  final Value<int> chapterCount;
  final Value<DateTime> lastRead;
  const NovelTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.novelId = const Value.absent(),
    this.chapterCount = const Value.absent(),
    this.lastRead = const Value.absent(),
  });
  NovelTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    required String coverUrl,
    required String sourceId,
    required String novelId,
    required int chapterCount,
    required DateTime lastRead,
  }) : title = Value(title),
       coverUrl = Value(coverUrl),
       sourceId = Value(sourceId),
       novelId = Value(novelId),
       chapterCount = Value(chapterCount),
       lastRead = Value(lastRead);
  static Insertable<NovelTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? description,
    Expression<String>? coverUrl,
    Expression<String>? sourceId,
    Expression<String>? novelId,
    Expression<int>? chapterCount,
    Expression<DateTime>? lastRead,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (description != null) 'description': description,
      if (coverUrl != null) 'cover_url': coverUrl,
      if (sourceId != null) 'source_id': sourceId,
      if (novelId != null) 'novel_id': novelId,
      if (chapterCount != null) 'chapter_count': chapterCount,
      if (lastRead != null) 'last_read': lastRead,
    });
  }

  NovelTableCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? author,
    Value<String?>? description,
    Value<String>? coverUrl,
    Value<String>? sourceId,
    Value<String>? novelId,
    Value<int>? chapterCount,
    Value<DateTime>? lastRead,
  }) {
    return NovelTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      sourceId: sourceId ?? this.sourceId,
      novelId: novelId ?? this.novelId,
      chapterCount: chapterCount ?? this.chapterCount,
      lastRead: lastRead ?? this.lastRead,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (coverUrl.present) {
      map['cover_url'] = Variable<String>(coverUrl.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (novelId.present) {
      map['novel_id'] = Variable<String>(novelId.value);
    }
    if (chapterCount.present) {
      map['chapter_count'] = Variable<int>(chapterCount.value);
    }
    if (lastRead.present) {
      map['last_read'] = Variable<DateTime>(lastRead.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NovelTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('sourceId: $sourceId, ')
          ..write('novelId: $novelId, ')
          ..write('chapterCount: $chapterCount, ')
          ..write('lastRead: $lastRead')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NovelTableTable novelTable = $NovelTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [novelTable];
}

typedef $$NovelTableTableCreateCompanionBuilder =
    NovelTableCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> author,
      Value<String?> description,
      required String coverUrl,
      required String sourceId,
      required String novelId,
      required int chapterCount,
      required DateTime lastRead,
    });
typedef $$NovelTableTableUpdateCompanionBuilder =
    NovelTableCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> author,
      Value<String?> description,
      Value<String> coverUrl,
      Value<String> sourceId,
      Value<String> novelId,
      Value<int> chapterCount,
      Value<DateTime> lastRead,
    });

class $$NovelTableTableFilterComposer
    extends Composer<_$AppDatabase, $NovelTableTable> {
  $$NovelTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get novelId => $composableBuilder(
    column: $table.novelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapterCount => $composableBuilder(
    column: $table.chapterCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastRead => $composableBuilder(
    column: $table.lastRead,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NovelTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NovelTableTable> {
  $$NovelTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get novelId => $composableBuilder(
    column: $table.novelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapterCount => $composableBuilder(
    column: $table.chapterCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastRead => $composableBuilder(
    column: $table.lastRead,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NovelTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NovelTableTable> {
  $$NovelTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<String> get novelId =>
      $composableBuilder(column: $table.novelId, builder: (column) => column);

  GeneratedColumn<int> get chapterCount => $composableBuilder(
    column: $table.chapterCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastRead =>
      $composableBuilder(column: $table.lastRead, builder: (column) => column);
}

class $$NovelTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NovelTableTable,
          NovelTableData,
          $$NovelTableTableFilterComposer,
          $$NovelTableTableOrderingComposer,
          $$NovelTableTableAnnotationComposer,
          $$NovelTableTableCreateCompanionBuilder,
          $$NovelTableTableUpdateCompanionBuilder,
          (
            NovelTableData,
            BaseReferences<_$AppDatabase, $NovelTableTable, NovelTableData>,
          ),
          NovelTableData,
          PrefetchHooks Function()
        > {
  $$NovelTableTableTableManager(_$AppDatabase db, $NovelTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NovelTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NovelTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NovelTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> coverUrl = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<String> novelId = const Value.absent(),
                Value<int> chapterCount = const Value.absent(),
                Value<DateTime> lastRead = const Value.absent(),
              }) => NovelTableCompanion(
                id: id,
                title: title,
                author: author,
                description: description,
                coverUrl: coverUrl,
                sourceId: sourceId,
                novelId: novelId,
                chapterCount: chapterCount,
                lastRead: lastRead,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required String coverUrl,
                required String sourceId,
                required String novelId,
                required int chapterCount,
                required DateTime lastRead,
              }) => NovelTableCompanion.insert(
                id: id,
                title: title,
                author: author,
                description: description,
                coverUrl: coverUrl,
                sourceId: sourceId,
                novelId: novelId,
                chapterCount: chapterCount,
                lastRead: lastRead,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NovelTableTable, NovelTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $NovelTableTable,
                    NovelTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NovelTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NovelTableTable,
      NovelTableData,
      $$NovelTableTableFilterComposer,
      $$NovelTableTableOrderingComposer,
      $$NovelTableTableAnnotationComposer,
      $$NovelTableTableCreateCompanionBuilder,
      $$NovelTableTableUpdateCompanionBuilder,
      (
        NovelTableData,
        BaseReferences<_$AppDatabase, $NovelTableTable, NovelTableData>,
      ),
      NovelTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NovelTableTableTableManager get novelTable =>
      $$NovelTableTableTableManager(_db, _db.novelTable);
}
