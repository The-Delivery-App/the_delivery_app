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

abstract class BasketFood
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  BasketFood._({
    this.id,
    required this.basketId,
    required this.foodId,
    required this.qty,
  });

  factory BasketFood({
    int? id,
    required int basketId,
    required int foodId,
    required int qty,
  }) = _BasketFoodImpl;

  factory BasketFood.fromJson(Map<String, dynamic> jsonSerialization) {
    return BasketFood(
      id: jsonSerialization['id'] as int?,
      basketId: jsonSerialization['basketId'] as int,
      foodId: jsonSerialization['foodId'] as int,
      qty: jsonSerialization['qty'] as int,
    );
  }

  static final t = BasketFoodTable();

  static const db = BasketFoodRepository._();

  @override
  int? id;

  int basketId;

  int foodId;

  int qty;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BasketFood]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BasketFood copyWith({
    int? id,
    int? basketId,
    int? foodId,
    int? qty,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BasketFood',
      if (id != null) 'id': id,
      'basketId': basketId,
      'foodId': foodId,
      'qty': qty,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BasketFood',
      if (id != null) 'id': id,
      'basketId': basketId,
      'foodId': foodId,
      'qty': qty,
    };
  }

  static BasketFoodInclude include() {
    return BasketFoodInclude._();
  }

  static BasketFoodIncludeList includeList({
    _i1.WhereExpressionBuilder<BasketFoodTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BasketFoodTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BasketFoodTable>? orderByList,
    BasketFoodInclude? include,
  }) {
    return BasketFoodIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BasketFood.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BasketFood.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BasketFoodImpl extends BasketFood {
  _BasketFoodImpl({
    int? id,
    required int basketId,
    required int foodId,
    required int qty,
  }) : super._(
         id: id,
         basketId: basketId,
         foodId: foodId,
         qty: qty,
       );

  /// Returns a shallow copy of this [BasketFood]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BasketFood copyWith({
    Object? id = _Undefined,
    int? basketId,
    int? foodId,
    int? qty,
  }) {
    return BasketFood(
      id: id is int? ? id : this.id,
      basketId: basketId ?? this.basketId,
      foodId: foodId ?? this.foodId,
      qty: qty ?? this.qty,
    );
  }
}

class BasketFoodUpdateTable extends _i1.UpdateTable<BasketFoodTable> {
  BasketFoodUpdateTable(super.table);

  _i1.ColumnValue<int, int> basketId(int value) => _i1.ColumnValue(
    table.basketId,
    value,
  );

  _i1.ColumnValue<int, int> foodId(int value) => _i1.ColumnValue(
    table.foodId,
    value,
  );

  _i1.ColumnValue<int, int> qty(int value) => _i1.ColumnValue(
    table.qty,
    value,
  );
}

class BasketFoodTable extends _i1.Table<int?> {
  BasketFoodTable({super.tableRelation}) : super(tableName: 'basket_food') {
    updateTable = BasketFoodUpdateTable(this);
    basketId = _i1.ColumnInt(
      'basketId',
      this,
    );
    foodId = _i1.ColumnInt(
      'foodId',
      this,
    );
    qty = _i1.ColumnInt(
      'qty',
      this,
    );
  }

  late final BasketFoodUpdateTable updateTable;

  late final _i1.ColumnInt basketId;

  late final _i1.ColumnInt foodId;

  late final _i1.ColumnInt qty;

  @override
  List<_i1.Column> get columns => [
    id,
    basketId,
    foodId,
    qty,
  ];
}

class BasketFoodInclude extends _i1.IncludeObject {
  BasketFoodInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BasketFood.t;
}

class BasketFoodIncludeList extends _i1.IncludeList {
  BasketFoodIncludeList._({
    _i1.WhereExpressionBuilder<BasketFoodTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BasketFood.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BasketFood.t;
}

class BasketFoodRepository {
  const BasketFoodRepository._();

  /// Returns a list of [BasketFood]s matching the given query parameters.
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
  Future<List<BasketFood>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BasketFoodTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BasketFoodTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BasketFoodTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BasketFood>(
      where: where?.call(BasketFood.t),
      orderBy: orderBy?.call(BasketFood.t),
      orderByList: orderByList?.call(BasketFood.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BasketFood] matching the given query parameters.
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
  Future<BasketFood?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BasketFoodTable>? where,
    int? offset,
    _i1.OrderByBuilder<BasketFoodTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BasketFoodTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BasketFood>(
      where: where?.call(BasketFood.t),
      orderBy: orderBy?.call(BasketFood.t),
      orderByList: orderByList?.call(BasketFood.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BasketFood] by its [id] or null if no such row exists.
  Future<BasketFood?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BasketFood>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BasketFood]s in the list and returns the inserted rows.
  ///
  /// The returned [BasketFood]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<BasketFood>> insert(
    _i1.Session session,
    List<BasketFood> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BasketFood>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BasketFood] and returns the inserted row.
  ///
  /// The returned [BasketFood] will have its `id` field set.
  Future<BasketFood> insertRow(
    _i1.Session session,
    BasketFood row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BasketFood>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BasketFood]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BasketFood>> update(
    _i1.Session session,
    List<BasketFood> rows, {
    _i1.ColumnSelections<BasketFoodTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BasketFood>(
      rows,
      columns: columns?.call(BasketFood.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BasketFood]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BasketFood> updateRow(
    _i1.Session session,
    BasketFood row, {
    _i1.ColumnSelections<BasketFoodTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BasketFood>(
      row,
      columns: columns?.call(BasketFood.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BasketFood] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BasketFood?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<BasketFoodUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BasketFood>(
      id,
      columnValues: columnValues(BasketFood.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BasketFood]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BasketFood>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<BasketFoodUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BasketFoodTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BasketFoodTable>? orderBy,
    _i1.OrderByListBuilder<BasketFoodTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BasketFood>(
      columnValues: columnValues(BasketFood.t.updateTable),
      where: where(BasketFood.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BasketFood.t),
      orderByList: orderByList?.call(BasketFood.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BasketFood]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BasketFood>> delete(
    _i1.Session session,
    List<BasketFood> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BasketFood>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BasketFood].
  Future<BasketFood> deleteRow(
    _i1.Session session,
    BasketFood row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BasketFood>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BasketFood>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BasketFoodTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BasketFood>(
      where: where(BasketFood.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BasketFoodTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BasketFood>(
      where: where?.call(BasketFood.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BasketFood] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BasketFoodTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BasketFood>(
      where: where(BasketFood.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
