/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class FoodTag
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FoodTag._({
    this.id,
    required this.tagId,
    required this.foodId,
  });

  factory FoodTag({
    int? id,
    required int tagId,
    required int foodId,
  }) = _FoodTagImpl;

  factory FoodTag.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodTag(
      id: jsonSerialization['id'] as int?,
      tagId: jsonSerialization['tagId'] as int,
      foodId: jsonSerialization['foodId'] as int,
    );
  }

  static final t = FoodTagTable();

  static const db = FoodTagRepository._();

  @override
  int? id;

  int tagId;

  int foodId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FoodTag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodTag copyWith({
    int? id,
    int? tagId,
    int? foodId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodTag',
      if (id != null) 'id': id,
      'tagId': tagId,
      'foodId': foodId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FoodTag',
      if (id != null) 'id': id,
      'tagId': tagId,
      'foodId': foodId,
    };
  }

  static FoodTagInclude include() {
    return FoodTagInclude._();
  }

  static FoodTagIncludeList includeList({
    _i1.WhereExpressionBuilder<FoodTagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodTagTable>? orderByList,
    FoodTagInclude? include,
  }) {
    return FoodTagIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodTag.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FoodTag.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodTagImpl extends FoodTag {
  _FoodTagImpl({
    int? id,
    required int tagId,
    required int foodId,
  }) : super._(
         id: id,
         tagId: tagId,
         foodId: foodId,
       );

  /// Returns a shallow copy of this [FoodTag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodTag copyWith({
    Object? id = _Undefined,
    int? tagId,
    int? foodId,
  }) {
    return FoodTag(
      id: id is int? ? id : this.id,
      tagId: tagId ?? this.tagId,
      foodId: foodId ?? this.foodId,
    );
  }
}

class FoodTagUpdateTable extends _i1.UpdateTable<FoodTagTable> {
  FoodTagUpdateTable(super.table);

  _i1.ColumnValue<int, int> tagId(int value) => _i1.ColumnValue(
    table.tagId,
    value,
  );

  _i1.ColumnValue<int, int> foodId(int value) => _i1.ColumnValue(
    table.foodId,
    value,
  );
}

class FoodTagTable extends _i1.Table<int?> {
  FoodTagTable({super.tableRelation}) : super(tableName: 'food_tag') {
    updateTable = FoodTagUpdateTable(this);
    tagId = _i1.ColumnInt(
      'tagId',
      this,
    );
    foodId = _i1.ColumnInt(
      'foodId',
      this,
    );
  }

  late final FoodTagUpdateTable updateTable;

  late final _i1.ColumnInt tagId;

  late final _i1.ColumnInt foodId;

  @override
  List<_i1.Column> get columns => [
    id,
    tagId,
    foodId,
  ];
}

class FoodTagInclude extends _i1.IncludeObject {
  FoodTagInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FoodTag.t;
}

class FoodTagIncludeList extends _i1.IncludeList {
  FoodTagIncludeList._({
    _i1.WhereExpressionBuilder<FoodTagTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FoodTag.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FoodTag.t;
}

class FoodTagRepository {
  const FoodTagRepository._();

  /// Returns a list of [FoodTag]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<FoodTag>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodTagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodTagTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FoodTag>(
      where: where?.call(FoodTag.t),
      orderBy: orderBy?.call(FoodTag.t),
      orderByList: orderByList?.call(FoodTag.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FoodTag] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<FoodTag?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodTagTable>? where,
    int? offset,
    _i1.OrderByBuilder<FoodTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodTagTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FoodTag>(
      where: where?.call(FoodTag.t),
      orderBy: orderBy?.call(FoodTag.t),
      orderByList: orderByList?.call(FoodTag.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FoodTag] by its [id] or null if no such row exists.
  Future<FoodTag?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FoodTag>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FoodTag]s in the list and returns the inserted rows.
  ///
  /// The returned [FoodTag]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FoodTag>> insert(
    _i1.Session session,
    List<FoodTag> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FoodTag>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FoodTag] and returns the inserted row.
  ///
  /// The returned [FoodTag] will have its `id` field set.
  Future<FoodTag> insertRow(
    _i1.Session session,
    FoodTag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FoodTag>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FoodTag]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FoodTag>> update(
    _i1.Session session,
    List<FoodTag> rows, {
    _i1.ColumnSelections<FoodTagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FoodTag>(
      rows,
      columns: columns?.call(FoodTag.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodTag]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FoodTag> updateRow(
    _i1.Session session,
    FoodTag row, {
    _i1.ColumnSelections<FoodTagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FoodTag>(
      row,
      columns: columns?.call(FoodTag.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodTag] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FoodTag?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FoodTagUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FoodTag>(
      id,
      columnValues: columnValues(FoodTag.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FoodTag]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FoodTag>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FoodTagUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FoodTagTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodTagTable>? orderBy,
    _i1.OrderByListBuilder<FoodTagTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FoodTag>(
      columnValues: columnValues(FoodTag.t.updateTable),
      where: where(FoodTag.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodTag.t),
      orderByList: orderByList?.call(FoodTag.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FoodTag]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FoodTag>> delete(
    _i1.Session session,
    List<FoodTag> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FoodTag>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FoodTag].
  Future<FoodTag> deleteRow(
    _i1.Session session,
    FoodTag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FoodTag>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FoodTag>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FoodTagTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FoodTag>(
      where: where(FoodTag.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodTagTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FoodTag>(
      where: where?.call(FoodTag.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FoodTag] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FoodTagTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FoodTag>(
      where: where(FoodTag.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
