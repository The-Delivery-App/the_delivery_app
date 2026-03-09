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

abstract class Restaurant
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Restaurant._({
    this.id,
    required this.restName,
    this.logoThumb,
    double? estimatedDeliveryTime,
    this.cuisine,
  }) : estimatedDeliveryTime = estimatedDeliveryTime ?? 30.0;

  factory Restaurant({
    int? id,
    required String restName,
    String? logoThumb,
    double? estimatedDeliveryTime,
    String? cuisine,
  }) = _RestaurantImpl;

  factory Restaurant.fromJson(Map<String, dynamic> jsonSerialization) {
    return Restaurant(
      id: jsonSerialization['id'] as int?,
      restName: jsonSerialization['restName'] as String,
      logoThumb: jsonSerialization['logoThumb'] as String?,
      estimatedDeliveryTime:
          (jsonSerialization['estimatedDeliveryTime'] as num?)?.toDouble(),
      cuisine: jsonSerialization['cuisine'] as String?,
    );
  }

  static final t = RestaurantTable();

  static const db = RestaurantRepository._();

  @override
  int? id;

  String restName;

  String? logoThumb;

  double estimatedDeliveryTime;

  String? cuisine;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Restaurant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Restaurant copyWith({
    int? id,
    String? restName,
    String? logoThumb,
    double? estimatedDeliveryTime,
    String? cuisine,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Restaurant',
      if (id != null) 'id': id,
      'restName': restName,
      if (logoThumb != null) 'logoThumb': logoThumb,
      'estimatedDeliveryTime': estimatedDeliveryTime,
      if (cuisine != null) 'cuisine': cuisine,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Restaurant',
      if (id != null) 'id': id,
      'restName': restName,
      if (logoThumb != null) 'logoThumb': logoThumb,
      'estimatedDeliveryTime': estimatedDeliveryTime,
      if (cuisine != null) 'cuisine': cuisine,
    };
  }

  static RestaurantInclude include() {
    return RestaurantInclude._();
  }

  static RestaurantIncludeList includeList({
    _i1.WhereExpressionBuilder<RestaurantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RestaurantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RestaurantTable>? orderByList,
    RestaurantInclude? include,
  }) {
    return RestaurantIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Restaurant.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Restaurant.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RestaurantImpl extends Restaurant {
  _RestaurantImpl({
    int? id,
    required String restName,
    String? logoThumb,
    double? estimatedDeliveryTime,
    String? cuisine,
  }) : super._(
         id: id,
         restName: restName,
         logoThumb: logoThumb,
         estimatedDeliveryTime: estimatedDeliveryTime,
         cuisine: cuisine,
       );

  /// Returns a shallow copy of this [Restaurant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Restaurant copyWith({
    Object? id = _Undefined,
    String? restName,
    Object? logoThumb = _Undefined,
    double? estimatedDeliveryTime,
    Object? cuisine = _Undefined,
  }) {
    return Restaurant(
      id: id is int? ? id : this.id,
      restName: restName ?? this.restName,
      logoThumb: logoThumb is String? ? logoThumb : this.logoThumb,
      estimatedDeliveryTime:
          estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      cuisine: cuisine is String? ? cuisine : this.cuisine,
    );
  }
}

class RestaurantUpdateTable extends _i1.UpdateTable<RestaurantTable> {
  RestaurantUpdateTable(super.table);

  _i1.ColumnValue<String, String> restName(String value) => _i1.ColumnValue(
    table.restName,
    value,
  );

  _i1.ColumnValue<String, String> logoThumb(String? value) => _i1.ColumnValue(
    table.logoThumb,
    value,
  );

  _i1.ColumnValue<double, double> estimatedDeliveryTime(double value) =>
      _i1.ColumnValue(
        table.estimatedDeliveryTime,
        value,
      );

  _i1.ColumnValue<String, String> cuisine(String? value) => _i1.ColumnValue(
    table.cuisine,
    value,
  );
}

class RestaurantTable extends _i1.Table<int?> {
  RestaurantTable({super.tableRelation}) : super(tableName: 'restaurant') {
    updateTable = RestaurantUpdateTable(this);
    restName = _i1.ColumnString(
      'restName',
      this,
    );
    logoThumb = _i1.ColumnString(
      'logoThumb',
      this,
    );
    estimatedDeliveryTime = _i1.ColumnDouble(
      'estimatedDeliveryTime',
      this,
      hasDefault: true,
    );
    cuisine = _i1.ColumnString(
      'cuisine',
      this,
    );
  }

  late final RestaurantUpdateTable updateTable;

  late final _i1.ColumnString restName;

  late final _i1.ColumnString logoThumb;

  late final _i1.ColumnDouble estimatedDeliveryTime;

  late final _i1.ColumnString cuisine;

  @override
  List<_i1.Column> get columns => [
    id,
    restName,
    logoThumb,
    estimatedDeliveryTime,
    cuisine,
  ];
}

class RestaurantInclude extends _i1.IncludeObject {
  RestaurantInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Restaurant.t;
}

class RestaurantIncludeList extends _i1.IncludeList {
  RestaurantIncludeList._({
    _i1.WhereExpressionBuilder<RestaurantTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Restaurant.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Restaurant.t;
}

class RestaurantRepository {
  const RestaurantRepository._();

  /// Returns a list of [Restaurant]s matching the given query parameters.
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
  Future<List<Restaurant>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RestaurantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RestaurantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RestaurantTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Restaurant>(
      where: where?.call(Restaurant.t),
      orderBy: orderBy?.call(Restaurant.t),
      orderByList: orderByList?.call(Restaurant.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Restaurant] matching the given query parameters.
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
  Future<Restaurant?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RestaurantTable>? where,
    int? offset,
    _i1.OrderByBuilder<RestaurantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RestaurantTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Restaurant>(
      where: where?.call(Restaurant.t),
      orderBy: orderBy?.call(Restaurant.t),
      orderByList: orderByList?.call(Restaurant.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Restaurant] by its [id] or null if no such row exists.
  Future<Restaurant?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Restaurant>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Restaurant]s in the list and returns the inserted rows.
  ///
  /// The returned [Restaurant]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Restaurant>> insert(
    _i1.Session session,
    List<Restaurant> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Restaurant>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Restaurant] and returns the inserted row.
  ///
  /// The returned [Restaurant] will have its `id` field set.
  Future<Restaurant> insertRow(
    _i1.Session session,
    Restaurant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Restaurant>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Restaurant]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Restaurant>> update(
    _i1.Session session,
    List<Restaurant> rows, {
    _i1.ColumnSelections<RestaurantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Restaurant>(
      rows,
      columns: columns?.call(Restaurant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Restaurant]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Restaurant> updateRow(
    _i1.Session session,
    Restaurant row, {
    _i1.ColumnSelections<RestaurantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Restaurant>(
      row,
      columns: columns?.call(Restaurant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Restaurant] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Restaurant?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<RestaurantUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Restaurant>(
      id,
      columnValues: columnValues(Restaurant.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Restaurant]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Restaurant>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<RestaurantUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<RestaurantTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RestaurantTable>? orderBy,
    _i1.OrderByListBuilder<RestaurantTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Restaurant>(
      columnValues: columnValues(Restaurant.t.updateTable),
      where: where(Restaurant.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Restaurant.t),
      orderByList: orderByList?.call(Restaurant.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Restaurant]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Restaurant>> delete(
    _i1.Session session,
    List<Restaurant> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Restaurant>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Restaurant].
  Future<Restaurant> deleteRow(
    _i1.Session session,
    Restaurant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Restaurant>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Restaurant>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RestaurantTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Restaurant>(
      where: where(Restaurant.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RestaurantTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Restaurant>(
      where: where?.call(Restaurant.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Restaurant] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RestaurantTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Restaurant>(
      where: where(Restaurant.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
