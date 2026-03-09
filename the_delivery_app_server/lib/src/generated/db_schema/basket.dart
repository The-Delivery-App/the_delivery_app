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

abstract class Basket implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Basket._({
    this.id,
    required this.userId,
    required this.lastUpdated,
  });

  factory Basket({
    int? id,
    required int userId,
    required DateTime lastUpdated,
  }) = _BasketImpl;

  factory Basket.fromJson(Map<String, dynamic> jsonSerialization) {
    return Basket(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      lastUpdated: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastUpdated'],
      ),
    );
  }

  static final t = BasketTable();

  static const db = BasketRepository._();

  @override
  int? id;

  int userId;

  DateTime lastUpdated;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Basket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Basket copyWith({
    int? id,
    int? userId,
    DateTime? lastUpdated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Basket',
      if (id != null) 'id': id,
      'userId': userId,
      'lastUpdated': lastUpdated.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Basket',
      if (id != null) 'id': id,
      'userId': userId,
      'lastUpdated': lastUpdated.toJson(),
    };
  }

  static BasketInclude include() {
    return BasketInclude._();
  }

  static BasketIncludeList includeList({
    _i1.WhereExpressionBuilder<BasketTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BasketTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BasketTable>? orderByList,
    BasketInclude? include,
  }) {
    return BasketIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Basket.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Basket.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BasketImpl extends Basket {
  _BasketImpl({
    int? id,
    required int userId,
    required DateTime lastUpdated,
  }) : super._(
         id: id,
         userId: userId,
         lastUpdated: lastUpdated,
       );

  /// Returns a shallow copy of this [Basket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Basket copyWith({
    Object? id = _Undefined,
    int? userId,
    DateTime? lastUpdated,
  }) {
    return Basket(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class BasketUpdateTable extends _i1.UpdateTable<BasketTable> {
  BasketUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastUpdated(DateTime value) =>
      _i1.ColumnValue(
        table.lastUpdated,
        value,
      );
}

class BasketTable extends _i1.Table<int?> {
  BasketTable({super.tableRelation}) : super(tableName: 'basket') {
    updateTable = BasketUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    lastUpdated = _i1.ColumnDateTime(
      'lastUpdated',
      this,
    );
  }

  late final BasketUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnDateTime lastUpdated;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    lastUpdated,
  ];
}

class BasketInclude extends _i1.IncludeObject {
  BasketInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Basket.t;
}

class BasketIncludeList extends _i1.IncludeList {
  BasketIncludeList._({
    _i1.WhereExpressionBuilder<BasketTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Basket.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Basket.t;
}

class BasketRepository {
  const BasketRepository._();

  /// Returns a list of [Basket]s matching the given query parameters.
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
  Future<List<Basket>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BasketTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BasketTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BasketTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Basket>(
      where: where?.call(Basket.t),
      orderBy: orderBy?.call(Basket.t),
      orderByList: orderByList?.call(Basket.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Basket] matching the given query parameters.
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
  Future<Basket?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BasketTable>? where,
    int? offset,
    _i1.OrderByBuilder<BasketTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BasketTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Basket>(
      where: where?.call(Basket.t),
      orderBy: orderBy?.call(Basket.t),
      orderByList: orderByList?.call(Basket.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Basket] by its [id] or null if no such row exists.
  Future<Basket?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Basket>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Basket]s in the list and returns the inserted rows.
  ///
  /// The returned [Basket]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Basket>> insert(
    _i1.Session session,
    List<Basket> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Basket>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Basket] and returns the inserted row.
  ///
  /// The returned [Basket] will have its `id` field set.
  Future<Basket> insertRow(
    _i1.Session session,
    Basket row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Basket>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Basket]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Basket>> update(
    _i1.Session session,
    List<Basket> rows, {
    _i1.ColumnSelections<BasketTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Basket>(
      rows,
      columns: columns?.call(Basket.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Basket]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Basket> updateRow(
    _i1.Session session,
    Basket row, {
    _i1.ColumnSelections<BasketTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Basket>(
      row,
      columns: columns?.call(Basket.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Basket] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Basket?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<BasketUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Basket>(
      id,
      columnValues: columnValues(Basket.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Basket]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Basket>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<BasketUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BasketTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BasketTable>? orderBy,
    _i1.OrderByListBuilder<BasketTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Basket>(
      columnValues: columnValues(Basket.t.updateTable),
      where: where(Basket.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Basket.t),
      orderByList: orderByList?.call(Basket.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Basket]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Basket>> delete(
    _i1.Session session,
    List<Basket> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Basket>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Basket].
  Future<Basket> deleteRow(
    _i1.Session session,
    Basket row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Basket>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Basket>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BasketTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Basket>(
      where: where(Basket.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BasketTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Basket>(
      where: where?.call(Basket.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Basket] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BasketTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Basket>(
      where: where(Basket.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
