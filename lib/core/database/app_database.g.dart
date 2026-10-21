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
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastReadMeta = const VerificationMeta(
    'lastRead',
  );
  @override
  late final GeneratedColumn<DateTime> lastRead = GeneratedColumn<DateTime>(
    'last_read',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
    }
    if (data.containsKey('last_read')) {
      context.handle(
        _lastReadMeta,
        lastRead.isAcceptableOrUnknown(data['last_read']!, _lastReadMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sourceId, novelId},
  ];
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
      ),
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
  final DateTime? lastRead;
  const NovelTableData({
    required this.id,
    required this.title,
    this.author,
    this.description,
    required this.coverUrl,
    required this.sourceId,
    required this.novelId,
    required this.chapterCount,
    this.lastRead,
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
    if (!nullToAbsent || lastRead != null) {
      map['last_read'] = Variable<DateTime>(lastRead);
    }
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
      lastRead: lastRead == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRead),
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
      lastRead: serializer.fromJson<DateTime?>(json['lastRead']),
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
      'lastRead': serializer.toJson<DateTime?>(lastRead),
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
    Value<DateTime?> lastRead = const Value.absent(),
  }) => NovelTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    author: author.present ? author.value : this.author,
    description: description.present ? description.value : this.description,
    coverUrl: coverUrl ?? this.coverUrl,
    sourceId: sourceId ?? this.sourceId,
    novelId: novelId ?? this.novelId,
    chapterCount: chapterCount ?? this.chapterCount,
    lastRead: lastRead.present ? lastRead.value : this.lastRead,
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
  final Value<DateTime?> lastRead;
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
    this.chapterCount = const Value.absent(),
    this.lastRead = const Value.absent(),
  }) : title = Value(title),
       coverUrl = Value(coverUrl),
       sourceId = Value(sourceId),
       novelId = Value(novelId);
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
    Value<DateTime?>? lastRead,
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

class $NovelChapterTableTable extends NovelChapterTable
    with TableInfo<$NovelChapterTableTable, NovelChapterTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NovelChapterTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterNumberMeta = const VerificationMeta(
    'chapterNumber',
  );
  @override
  late final GeneratedColumn<int> chapterNumber = GeneratedColumn<int>(
    'chapter_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceId,
    novelId,
    chapterId,
    title,
    url,
    chapterNumber,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'novel_chapter_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<NovelChapterTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('chapter_number')) {
      context.handle(
        _chapterNumberMeta,
        chapterNumber.isAcceptableOrUnknown(
          data['chapter_number']!,
          _chapterNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chapterNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sourceId, novelId, chapterNumber},
  ];
  @override
  NovelChapterTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NovelChapterTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      novelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}novel_id'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      chapterNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter_number'],
      )!,
    );
  }

  @override
  $NovelChapterTableTable createAlias(String alias) {
    return $NovelChapterTableTable(attachedDatabase, alias);
  }
}

class NovelChapterTableData extends DataClass
    implements Insertable<NovelChapterTableData> {
  final int id;
  final String sourceId;
  final String novelId;
  final String chapterId;
  final String title;
  final String url;
  final int chapterNumber;
  const NovelChapterTableData({
    required this.id,
    required this.sourceId,
    required this.novelId,
    required this.chapterId,
    required this.title,
    required this.url,
    required this.chapterNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_id'] = Variable<String>(sourceId);
    map['novel_id'] = Variable<String>(novelId);
    map['chapter_id'] = Variable<String>(chapterId);
    map['title'] = Variable<String>(title);
    map['url'] = Variable<String>(url);
    map['chapter_number'] = Variable<int>(chapterNumber);
    return map;
  }

  NovelChapterTableCompanion toCompanion(bool nullToAbsent) {
    return NovelChapterTableCompanion(
      id: Value(id),
      sourceId: Value(sourceId),
      novelId: Value(novelId),
      chapterId: Value(chapterId),
      title: Value(title),
      url: Value(url),
      chapterNumber: Value(chapterNumber),
    );
  }

  factory NovelChapterTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NovelChapterTableData(
      id: serializer.fromJson<int>(json['id']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      novelId: serializer.fromJson<String>(json['novelId']),
      chapterId: serializer.fromJson<String>(json['chapterId']),
      title: serializer.fromJson<String>(json['title']),
      url: serializer.fromJson<String>(json['url']),
      chapterNumber: serializer.fromJson<int>(json['chapterNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceId': serializer.toJson<String>(sourceId),
      'novelId': serializer.toJson<String>(novelId),
      'chapterId': serializer.toJson<String>(chapterId),
      'title': serializer.toJson<String>(title),
      'url': serializer.toJson<String>(url),
      'chapterNumber': serializer.toJson<int>(chapterNumber),
    };
  }

  NovelChapterTableData copyWith({
    int? id,
    String? sourceId,
    String? novelId,
    String? chapterId,
    String? title,
    String? url,
    int? chapterNumber,
  }) => NovelChapterTableData(
    id: id ?? this.id,
    sourceId: sourceId ?? this.sourceId,
    novelId: novelId ?? this.novelId,
    chapterId: chapterId ?? this.chapterId,
    title: title ?? this.title,
    url: url ?? this.url,
    chapterNumber: chapterNumber ?? this.chapterNumber,
  );
  NovelChapterTableData copyWithCompanion(NovelChapterTableCompanion data) {
    return NovelChapterTableData(
      id: data.id.present ? data.id.value : this.id,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      novelId: data.novelId.present ? data.novelId.value : this.novelId,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      title: data.title.present ? data.title.value : this.title,
      url: data.url.present ? data.url.value : this.url,
      chapterNumber: data.chapterNumber.present
          ? data.chapterNumber.value
          : this.chapterNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NovelChapterTableData(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('novelId: $novelId, ')
          ..write('chapterId: $chapterId, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('chapterNumber: $chapterNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sourceId, novelId, chapterId, title, url, chapterNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NovelChapterTableData &&
          other.id == this.id &&
          other.sourceId == this.sourceId &&
          other.novelId == this.novelId &&
          other.chapterId == this.chapterId &&
          other.title == this.title &&
          other.url == this.url &&
          other.chapterNumber == this.chapterNumber);
}

class NovelChapterTableCompanion
    extends UpdateCompanion<NovelChapterTableData> {
  final Value<int> id;
  final Value<String> sourceId;
  final Value<String> novelId;
  final Value<String> chapterId;
  final Value<String> title;
  final Value<String> url;
  final Value<int> chapterNumber;
  const NovelChapterTableCompanion({
    this.id = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.novelId = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.title = const Value.absent(),
    this.url = const Value.absent(),
    this.chapterNumber = const Value.absent(),
  });
  NovelChapterTableCompanion.insert({
    this.id = const Value.absent(),
    required String sourceId,
    required String novelId,
    required String chapterId,
    required String title,
    required String url,
    required int chapterNumber,
  }) : sourceId = Value(sourceId),
       novelId = Value(novelId),
       chapterId = Value(chapterId),
       title = Value(title),
       url = Value(url),
       chapterNumber = Value(chapterNumber);
  static Insertable<NovelChapterTableData> custom({
    Expression<int>? id,
    Expression<String>? sourceId,
    Expression<String>? novelId,
    Expression<String>? chapterId,
    Expression<String>? title,
    Expression<String>? url,
    Expression<int>? chapterNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceId != null) 'source_id': sourceId,
      if (novelId != null) 'novel_id': novelId,
      if (chapterId != null) 'chapter_id': chapterId,
      if (title != null) 'title': title,
      if (url != null) 'url': url,
      if (chapterNumber != null) 'chapter_number': chapterNumber,
    });
  }

  NovelChapterTableCompanion copyWith({
    Value<int>? id,
    Value<String>? sourceId,
    Value<String>? novelId,
    Value<String>? chapterId,
    Value<String>? title,
    Value<String>? url,
    Value<int>? chapterNumber,
  }) {
    return NovelChapterTableCompanion(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      novelId: novelId ?? this.novelId,
      chapterId: chapterId ?? this.chapterId,
      title: title ?? this.title,
      url: url ?? this.url,
      chapterNumber: chapterNumber ?? this.chapterNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (novelId.present) {
      map['novel_id'] = Variable<String>(novelId.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (chapterNumber.present) {
      map['chapter_number'] = Variable<int>(chapterNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NovelChapterTableCompanion(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('novelId: $novelId, ')
          ..write('chapterId: $chapterId, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('chapterNumber: $chapterNumber')
          ..write(')'))
        .toString();
  }
}

class $LibraryCategoryTableTable extends LibraryCategoryTable
    with TableInfo<$LibraryCategoryTableTable, LibraryCategoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LibraryCategoryTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isHiddenMeta = const VerificationMeta(
    'isHidden',
  );
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hidden" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, type, isHidden];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'library_category_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<LibraryCategoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is_hidden')) {
      context.handle(
        _isHiddenMeta,
        isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {name, type},
  ];
  @override
  LibraryCategoryTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LibraryCategoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      isHidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_hidden'],
      )!,
    );
  }

  @override
  $LibraryCategoryTableTable createAlias(String alias) {
    return $LibraryCategoryTableTable(attachedDatabase, alias);
  }
}

class LibraryCategoryTableData extends DataClass
    implements Insertable<LibraryCategoryTableData> {
  final int id;
  final String name;
  final String type;
  final bool isHidden;
  const LibraryCategoryTableData({
    required this.id,
    required this.name,
    required this.type,
    required this.isHidden,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['is_hidden'] = Variable<bool>(isHidden);
    return map;
  }

  LibraryCategoryTableCompanion toCompanion(bool nullToAbsent) {
    return LibraryCategoryTableCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      isHidden: Value(isHidden),
    );
  }

  factory LibraryCategoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LibraryCategoryTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'isHidden': serializer.toJson<bool>(isHidden),
    };
  }

  LibraryCategoryTableData copyWith({
    int? id,
    String? name,
    String? type,
    bool? isHidden,
  }) => LibraryCategoryTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    isHidden: isHidden ?? this.isHidden,
  );
  LibraryCategoryTableData copyWithCompanion(
    LibraryCategoryTableCompanion data,
  ) {
    return LibraryCategoryTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LibraryCategoryTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isHidden: $isHidden')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, isHidden);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LibraryCategoryTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.isHidden == this.isHidden);
}

class LibraryCategoryTableCompanion
    extends UpdateCompanion<LibraryCategoryTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> type;
  final Value<bool> isHidden;
  const LibraryCategoryTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.isHidden = const Value.absent(),
  });
  LibraryCategoryTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String type,
    this.isHidden = const Value.absent(),
  }) : name = Value(name),
       type = Value(type);
  static Insertable<LibraryCategoryTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<bool>? isHidden,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (isHidden != null) 'is_hidden': isHidden,
    });
  }

  LibraryCategoryTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? type,
    Value<bool>? isHidden,
  }) {
    return LibraryCategoryTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      isHidden: isHidden ?? this.isHidden,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LibraryCategoryTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isHidden: $isHidden')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NovelTableTable novelTable = $NovelTableTable(this);
  late final $NovelChapterTableTable novelChapterTable =
      $NovelChapterTableTable(this);
  late final $LibraryCategoryTableTable libraryCategoryTable =
      $LibraryCategoryTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    novelTable,
    novelChapterTable,
    libraryCategoryTable,
  ];
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
      Value<int> chapterCount,
      Value<DateTime?> lastRead,
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
      Value<DateTime?> lastRead,
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
                Value<DateTime?> lastRead = const Value.absent(),
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
                Value<int> chapterCount = const Value.absent(),
                Value<DateTime?> lastRead = const Value.absent(),
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
typedef $$NovelChapterTableTableCreateCompanionBuilder =
    NovelChapterTableCompanion Function({
      Value<int> id,
      required String sourceId,
      required String novelId,
      required String chapterId,
      required String title,
      required String url,
      required int chapterNumber,
    });
typedef $$NovelChapterTableTableUpdateCompanionBuilder =
    NovelChapterTableCompanion Function({
      Value<int> id,
      Value<String> sourceId,
      Value<String> novelId,
      Value<String> chapterId,
      Value<String> title,
      Value<String> url,
      Value<int> chapterNumber,
    });

class $$NovelChapterTableTableFilterComposer
    extends Composer<_$AppDatabase, $NovelChapterTableTable> {
  $$NovelChapterTableTableFilterComposer({
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

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get novelId => $composableBuilder(
    column: $table.novelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chapterId => $composableBuilder(
    column: $table.chapterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapterNumber => $composableBuilder(
    column: $table.chapterNumber,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NovelChapterTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NovelChapterTableTable> {
  $$NovelChapterTableTableOrderingComposer({
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

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get novelId => $composableBuilder(
    column: $table.novelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chapterId => $composableBuilder(
    column: $table.chapterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapterNumber => $composableBuilder(
    column: $table.chapterNumber,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NovelChapterTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NovelChapterTableTable> {
  $$NovelChapterTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<String> get novelId =>
      $composableBuilder(column: $table.novelId, builder: (column) => column);

  GeneratedColumn<String> get chapterId =>
      $composableBuilder(column: $table.chapterId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<int> get chapterNumber => $composableBuilder(
    column: $table.chapterNumber,
    builder: (column) => column,
  );
}

class $$NovelChapterTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NovelChapterTableTable,
          NovelChapterTableData,
          $$NovelChapterTableTableFilterComposer,
          $$NovelChapterTableTableOrderingComposer,
          $$NovelChapterTableTableAnnotationComposer,
          $$NovelChapterTableTableCreateCompanionBuilder,
          $$NovelChapterTableTableUpdateCompanionBuilder,
          (
            NovelChapterTableData,
            BaseReferences<
              _$AppDatabase,
              $NovelChapterTableTable,
              NovelChapterTableData
            >,
          ),
          NovelChapterTableData,
          PrefetchHooks Function()
        > {
  $$NovelChapterTableTableTableManager(
    _$AppDatabase db,
    $NovelChapterTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NovelChapterTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NovelChapterTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NovelChapterTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<String> novelId = const Value.absent(),
                Value<String> chapterId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<int> chapterNumber = const Value.absent(),
              }) => NovelChapterTableCompanion(
                id: id,
                sourceId: sourceId,
                novelId: novelId,
                chapterId: chapterId,
                title: title,
                url: url,
                chapterNumber: chapterNumber,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sourceId,
                required String novelId,
                required String chapterId,
                required String title,
                required String url,
                required int chapterNumber,
              }) => NovelChapterTableCompanion.insert(
                id: id,
                sourceId: sourceId,
                novelId: novelId,
                chapterId: chapterId,
                title: title,
                url: url,
                chapterNumber: chapterNumber,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NovelChapterTableTable, NovelChapterTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $NovelChapterTableTable,
                    NovelChapterTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NovelChapterTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NovelChapterTableTable,
      NovelChapterTableData,
      $$NovelChapterTableTableFilterComposer,
      $$NovelChapterTableTableOrderingComposer,
      $$NovelChapterTableTableAnnotationComposer,
      $$NovelChapterTableTableCreateCompanionBuilder,
      $$NovelChapterTableTableUpdateCompanionBuilder,
      (
        NovelChapterTableData,
        BaseReferences<
          _$AppDatabase,
          $NovelChapterTableTable,
          NovelChapterTableData
        >,
      ),
      NovelChapterTableData,
      PrefetchHooks Function()
    >;
typedef $$LibraryCategoryTableTableCreateCompanionBuilder =
    LibraryCategoryTableCompanion Function({
      Value<int> id,
      required String name,
      required String type,
      Value<bool> isHidden,
    });
typedef $$LibraryCategoryTableTableUpdateCompanionBuilder =
    LibraryCategoryTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> type,
      Value<bool> isHidden,
    });

class $$LibraryCategoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $LibraryCategoryTableTable> {
  $$LibraryCategoryTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LibraryCategoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LibraryCategoryTableTable> {
  $$LibraryCategoryTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LibraryCategoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LibraryCategoryTableTable> {
  $$LibraryCategoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);
}

class $$LibraryCategoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LibraryCategoryTableTable,
          LibraryCategoryTableData,
          $$LibraryCategoryTableTableFilterComposer,
          $$LibraryCategoryTableTableOrderingComposer,
          $$LibraryCategoryTableTableAnnotationComposer,
          $$LibraryCategoryTableTableCreateCompanionBuilder,
          $$LibraryCategoryTableTableUpdateCompanionBuilder,
          (
            LibraryCategoryTableData,
            BaseReferences<
              _$AppDatabase,
              $LibraryCategoryTableTable,
              LibraryCategoryTableData
            >,
          ),
          LibraryCategoryTableData,
          PrefetchHooks Function()
        > {
  $$LibraryCategoryTableTableTableManager(
    _$AppDatabase db,
    $LibraryCategoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LibraryCategoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LibraryCategoryTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LibraryCategoryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
              }) => LibraryCategoryTableCompanion(
                id: id,
                name: name,
                type: type,
                isHidden: isHidden,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String type,
                Value<bool> isHidden = const Value.absent(),
              }) => LibraryCategoryTableCompanion.insert(
                id: id,
                name: name,
                type: type,
                isHidden: isHidden,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $LibraryCategoryTableTable,
                    LibraryCategoryTableData
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $LibraryCategoryTableTable,
                    LibraryCategoryTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LibraryCategoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LibraryCategoryTableTable,
      LibraryCategoryTableData,
      $$LibraryCategoryTableTableFilterComposer,
      $$LibraryCategoryTableTableOrderingComposer,
      $$LibraryCategoryTableTableAnnotationComposer,
      $$LibraryCategoryTableTableCreateCompanionBuilder,
      $$LibraryCategoryTableTableUpdateCompanionBuilder,
      (
        LibraryCategoryTableData,
        BaseReferences<
          _$AppDatabase,
          $LibraryCategoryTableTable,
          LibraryCategoryTableData
        >,
      ),
      LibraryCategoryTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NovelTableTableTableManager get novelTable =>
      $$NovelTableTableTableManager(_db, _db.novelTable);
  $$NovelChapterTableTableTableManager get novelChapterTable =>
      $$NovelChapterTableTableTableManager(_db, _db.novelChapterTable);
  $$LibraryCategoryTableTableTableManager get libraryCategoryTable =>
      $$LibraryCategoryTableTableTableManager(_db, _db.libraryCategoryTable);
}
