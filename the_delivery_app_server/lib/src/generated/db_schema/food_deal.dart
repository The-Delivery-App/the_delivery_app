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

abstract class FoodDeal
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FoodDeal._({
    this.id,
    required this.specialDealId,
    required this.foodId,
    required this.itemQty,
  });

  factory FoodDeal({
    int? id,
    required int specialDealId,
    required int foodId,
    required int itemQty,
  }) = _FoodDealImpl;

  factory FoodDeal.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodDeal(
      id: jsonSerialization['id'] as int?,
      specialDealId: jsonSerialization['specialDealId'] as int,
      foodId: jsonSerialization['foodId'] as int,
      itemQty: jsonSerialization['itemQty'] as int,
    );
  }

  static final t = FoodDealTable();

  static const db = FoodDealRepository._();

  @override
  int? id;

  int specialDealId;

  int foodId;

  int itemQty;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FoodDeal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodDeal copyWith({
    int? id,
    int? specialDealId,
    int? foodId,
    int? itemQty,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodDeal',
      if (id != null) 'id': id,
      'specialDealId': specialDealId,
      'foodId': foodId,
      'itemQty': itemQty,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FoodDeal',
      if (id != null) 'id': id,
      'specialDealId': specialDealId,
      'foodId': foodId,
      'itemQty': itemQty,
    };
  }

  static FoodDealInclude include() {
    return FoodDealInclude._();
  }

  static FoodDealIncludeList includeList({
    _i1.WhereExpressionBuilder<FoodDealTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodDealTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodDealTable>? orderByList,
    FoodDealInclude? include,
  }) {
    return FoodDealIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodDeal.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FoodDeal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodDealImpl extends FoodDeal {
  _FoodDealImpl({
    int? id,
    required int specialDealId,
    required int foodId,
    required int itemQty,
  }) : super._(
         id: id,
         specialDealId: specialDealId,
         foodId: foodId,
         itemQty: itemQty,
       );

  /// Returns a shallow copy of this [FoodDeal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodDeal copyWith({
    Object? id = _Undefined,
    int? specialDealId,
    int? foodId,
    int? itemQty,
  }) {
    return FoodDeal(
      id: id is int? ? id : this.id,
      specialDealId: specialDealId ?? this.specialDealId,
      foodId: foodId ?? this.foodId,
      itemQty: itemQty ?? this.itemQty,
    );
  }
}

class FoodDealUpdateTable extends _i1.UpdateTable<FoodDealTable> {
  FoodDealUpdateTable(super.table);

  _i1.ColumnValue<int, int> specialDealId(int value) => _i1.ColumnValue(
    table.specialDealId,
    value,
  );

  _i1.ColumnValue<int, int> foodId(int value) => _i1.ColumnValue(
    table.foodId,
    value,
  );

  _i1.ColumnValue<int, int> itemQty(int value) => _i1.ColumnValue(
    table.itemQty,
    value,
  );
}

class FoodDealTable extends _i1.Table<int?> {
  FoodDealTable({super.tableRelation}) : super(tableName: 'food_deal') {
    updateTable = FoodDealUpdateTable(this);
    specialDealId = _i1.ColumnInt(
      'specialDealId',
      this,
    );
    foodId = _i1.ColumnInt(
      'foodId',
      this,
    );
    itemQty = _i1.ColumnInt(
      'itemQty',
      this,
    );
  }

  late final FoodDealUpdateTable updateTable;

  late final _i1.ColumnInt specialDealId;

  late final _i1.ColumnInt foodId;

  late final _i1.ColumnInt itemQty;

  @override
  List<_i1.Column> get columns => [
    id,
    specialDealId,
    foodId,
    itemQty,
  ];
}

class FoodDealInclude extends _i1.IncludeObject {
  FoodDealInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FoodDeal.t;
}

class FoodDealIncludeList extends _i1.IncludeList {
  FoodDealIncludeList._({
    _i1.WhereExpressionBuilder<FoodDealTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FoodDeal.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FoodDeal.t;
}

class FoodDealRepository {
  const FoodDealRepository._();

  /// Returns a list of [FoodDeal]s matching the given query parameters.
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
  Future<List<FoodDeal>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodDealTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodDealTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodDealTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FoodDeal>(
      where: where?.call(FoodDeal.t),
      orderBy: orderBy?.call(FoodDeal.t),
      orderByList: orderByList?.call(FoodDeal.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FoodDeal] matching the given query parameters.
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
  Future<FoodDeal?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodDealTable>? where,
    int? offset,
    _i1.OrderByBuilder<FoodDealTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodDealTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FoodDeal>(
      where: where?.call(FoodDeal.t),
      orderBy: orderBy?.call(FoodDeal.t),
      orderByList: orderByList?.call(FoodDeal.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FoodDeal] by its [id] or null if no such row exists.
  Future<FoodDeal?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FoodDeal>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FoodDeal]s in the list and returns the inserted rows.
  ///
  /// The returned [FoodDeal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FoodDeal>> insert(
    _i1.Session session,
    List<FoodDeal> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FoodDeal>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FoodDeal] and returns the inserted row.
  ///
  /// The returned [FoodDeal] will have its `id` field set.
  Future<FoodDeal> insertRow(
    _i1.Session session,
    FoodDeal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FoodDeal>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FoodDeal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FoodDeal>> update(
    _i1.Session session,
    List<FoodDeal> rows, {
    _i1.ColumnSelections<FoodDealTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FoodDeal>(
      rows,
      columns: columns?.call(FoodDeal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodDeal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FoodDeal> updateRow(
    _i1.Session session,
    FoodDeal row, {
    _i1.ColumnSelections<FoodDealTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FoodDeal>(
      row,
      columns: columns?.call(FoodDeal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodDeal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FoodDeal?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FoodDealUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FoodDeal>(
      id,
      columnValues: columnValues(FoodDeal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FoodDeal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FoodDeal>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FoodDealUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FoodDealTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodDealTable>? orderBy,
    _i1.OrderByListBuilder<FoodDealTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FoodDeal>(
      columnValues: columnValues(FoodDeal.t.updateTable),
      where: where(FoodDeal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodDeal.t),
      orderByList: orderByList?.call(FoodDeal.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FoodDeal]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FoodDeal>> delete(
    _i1.Session session,
    List<FoodDeal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FoodDeal>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FoodDeal].
  Future<FoodDeal> deleteRow(
    _i1.Session session,
    FoodDeal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FoodDeal>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FoodDeal>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FoodDealTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FoodDeal>(
      where: where(FoodDeal.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodDealTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FoodDeal>(
      where: where?.call(FoodDeal.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FoodDeal] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FoodDealTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FoodDeal>(
      where: where(FoodDeal.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
