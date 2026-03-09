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

abstract class SpecialDeals
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SpecialDeals._({
    this.id,
    required this.placeId,
    this.thumbnail,
    required this.description,
    required this.discountAmount,
  });

  factory SpecialDeals({
    int? id,
    required int placeId,
    String? thumbnail,
    required String description,
    required double discountAmount,
  }) = _SpecialDealsImpl;

  factory SpecialDeals.fromJson(Map<String, dynamic> jsonSerialization) {
    return SpecialDeals(
      id: jsonSerialization['id'] as int?,
      placeId: jsonSerialization['placeId'] as int,
      thumbnail: jsonSerialization['thumbnail'] as String?,
      description: jsonSerialization['description'] as String,
      discountAmount: (jsonSerialization['discountAmount'] as num).toDouble(),
    );
  }

  static final t = SpecialDealsTable();

  static const db = SpecialDealsRepository._();

  @override
  int? id;

  int placeId;

  String? thumbnail;

  String description;

  double discountAmount;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SpecialDeals]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpecialDeals copyWith({
    int? id,
    int? placeId,
    String? thumbnail,
    String? description,
    double? discountAmount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SpecialDeals',
      if (id != null) 'id': id,
      'placeId': placeId,
      if (thumbnail != null) 'thumbnail': thumbnail,
      'description': description,
      'discountAmount': discountAmount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SpecialDeals',
      if (id != null) 'id': id,
      'placeId': placeId,
      if (thumbnail != null) 'thumbnail': thumbnail,
      'description': description,
      'discountAmount': discountAmount,
    };
  }

  static SpecialDealsInclude include() {
    return SpecialDealsInclude._();
  }

  static SpecialDealsIncludeList includeList({
    _i1.WhereExpressionBuilder<SpecialDealsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpecialDealsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpecialDealsTable>? orderByList,
    SpecialDealsInclude? include,
  }) {
    return SpecialDealsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SpecialDeals.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SpecialDeals.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpecialDealsImpl extends SpecialDeals {
  _SpecialDealsImpl({
    int? id,
    required int placeId,
    String? thumbnail,
    required String description,
    required double discountAmount,
  }) : super._(
         id: id,
         placeId: placeId,
         thumbnail: thumbnail,
         description: description,
         discountAmount: discountAmount,
       );

  /// Returns a shallow copy of this [SpecialDeals]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpecialDeals copyWith({
    Object? id = _Undefined,
    int? placeId,
    Object? thumbnail = _Undefined,
    String? description,
    double? discountAmount,
  }) {
    return SpecialDeals(
      id: id is int? ? id : this.id,
      placeId: placeId ?? this.placeId,
      thumbnail: thumbnail is String? ? thumbnail : this.thumbnail,
      description: description ?? this.description,
      discountAmount: discountAmount ?? this.discountAmount,
    );
  }
}

class SpecialDealsUpdateTable extends _i1.UpdateTable<SpecialDealsTable> {
  SpecialDealsUpdateTable(super.table);

  _i1.ColumnValue<int, int> placeId(int value) => _i1.ColumnValue(
    table.placeId,
    value,
  );

  _i1.ColumnValue<String, String> thumbnail(String? value) => _i1.ColumnValue(
    table.thumbnail,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<double, double> discountAmount(double value) =>
      _i1.ColumnValue(
        table.discountAmount,
        value,
      );
}

class SpecialDealsTable extends _i1.Table<int?> {
  SpecialDealsTable({super.tableRelation}) : super(tableName: 'special_deals') {
    updateTable = SpecialDealsUpdateTable(this);
    placeId = _i1.ColumnInt(
      'placeId',
      this,
    );
    thumbnail = _i1.ColumnString(
      'thumbnail',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    discountAmount = _i1.ColumnDouble(
      'discountAmount',
      this,
    );
  }

  late final SpecialDealsUpdateTable updateTable;

  late final _i1.ColumnInt placeId;

  late final _i1.ColumnString thumbnail;

  late final _i1.ColumnString description;

  late final _i1.ColumnDouble discountAmount;

  @override
  List<_i1.Column> get columns => [
    id,
    placeId,
    thumbnail,
    description,
    discountAmount,
  ];
}

class SpecialDealsInclude extends _i1.IncludeObject {
  SpecialDealsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SpecialDeals.t;
}

class SpecialDealsIncludeList extends _i1.IncludeList {
  SpecialDealsIncludeList._({
    _i1.WhereExpressionBuilder<SpecialDealsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SpecialDeals.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SpecialDeals.t;
}

class SpecialDealsRepository {
  const SpecialDealsRepository._();

  /// Returns a list of [SpecialDeals]s matching the given query parameters.
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
  Future<List<SpecialDeals>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpecialDealsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpecialDealsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpecialDealsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SpecialDeals>(
      where: where?.call(SpecialDeals.t),
      orderBy: orderBy?.call(SpecialDeals.t),
      orderByList: orderByList?.call(SpecialDeals.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SpecialDeals] matching the given query parameters.
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
  Future<SpecialDeals?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpecialDealsTable>? where,
    int? offset,
    _i1.OrderByBuilder<SpecialDealsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpecialDealsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SpecialDeals>(
      where: where?.call(SpecialDeals.t),
      orderBy: orderBy?.call(SpecialDeals.t),
      orderByList: orderByList?.call(SpecialDeals.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SpecialDeals] by its [id] or null if no such row exists.
  Future<SpecialDeals?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SpecialDeals>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SpecialDeals]s in the list and returns the inserted rows.
  ///
  /// The returned [SpecialDeals]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SpecialDeals>> insert(
    _i1.Session session,
    List<SpecialDeals> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SpecialDeals>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SpecialDeals] and returns the inserted row.
  ///
  /// The returned [SpecialDeals] will have its `id` field set.
  Future<SpecialDeals> insertRow(
    _i1.Session session,
    SpecialDeals row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SpecialDeals>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SpecialDeals]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SpecialDeals>> update(
    _i1.Session session,
    List<SpecialDeals> rows, {
    _i1.ColumnSelections<SpecialDealsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SpecialDeals>(
      rows,
      columns: columns?.call(SpecialDeals.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SpecialDeals]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SpecialDeals> updateRow(
    _i1.Session session,
    SpecialDeals row, {
    _i1.ColumnSelections<SpecialDealsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SpecialDeals>(
      row,
      columns: columns?.call(SpecialDeals.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SpecialDeals] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SpecialDeals?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SpecialDealsUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SpecialDeals>(
      id,
      columnValues: columnValues(SpecialDeals.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SpecialDeals]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SpecialDeals>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SpecialDealsUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SpecialDealsTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpecialDealsTable>? orderBy,
    _i1.OrderByListBuilder<SpecialDealsTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SpecialDeals>(
      columnValues: columnValues(SpecialDeals.t.updateTable),
      where: where(SpecialDeals.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SpecialDeals.t),
      orderByList: orderByList?.call(SpecialDeals.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SpecialDeals]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SpecialDeals>> delete(
    _i1.Session session,
    List<SpecialDeals> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SpecialDeals>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SpecialDeals].
  Future<SpecialDeals> deleteRow(
    _i1.Session session,
    SpecialDeals row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SpecialDeals>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SpecialDeals>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SpecialDealsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SpecialDeals>(
      where: where(SpecialDeals.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpecialDealsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SpecialDeals>(
      where: where?.call(SpecialDeals.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SpecialDeals] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SpecialDealsTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SpecialDeals>(
      where: where(SpecialDeals.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
