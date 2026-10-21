// lib/core/database/mappers/library_category_mapper.dart

import 'package:drift/drift.dart' show Value;
import 'package:hizashi/core/database/app_database.dart';
import 'package:hizashi/models/source/library_category_modal.dart';

extension LibraryCategoryMapper on LibraryCategoryTableData {
  LibraryCategoryModal toLibraryCategoryModal() {
    return LibraryCategoryModal(
      name: name,
      isHidden: isHidden,
      type: LibraryCategoryType.values.byName(type),
    );
  }
}

extension LibraryCategoryCompanionMapper on LibraryCategoryModal {
  LibraryCategoryTableCompanion toCompanion() {
    return LibraryCategoryTableCompanion.insert(
      name: name,
      type: type.name,
      isHidden: Value(isHidden),
    );
  }
}
