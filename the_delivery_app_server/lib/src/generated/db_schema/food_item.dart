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

abstract class FoodItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FoodItem._({
    this.id,
    required this.restId,
    required this.foodName,
    required this.foodPrice,
    required this.foodRating,
    this.foodThumbnail,
    this.description,
    this.nutritionCals,
    int? estimatedOrders,
    required this.createdAt,
  }) : estimatedOrders = estimatedOrders ?? 0;

  factory FoodItem({
    int? id,
    required int restId,
    required String foodName,
    required double foodPrice,
    required double foodRating,
    String? foodThumbnail,
    String? description,
    int? nutritionCals,
    int? estimatedOrders,
    required DateTime createdAt,
  }) = _FoodItemImpl;

  factory FoodItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodItem(
      id: jsonSerialization['id'] as int?,
      restId: jsonSerialization['restId'] as int,
      foodName: jsonSerialization['foodName'] as String,
      foodPrice: (jsonSerialization['foodPrice'] as num).toDouble(),
      foodRating: (jsonSerialization['foodRating'] as num).toDouble(),
      foodThumbnail: jsonSerialization['foodThumbnail'] as String?,
      description: jsonSerialization['description'] as String?,
      nutritionCals: jsonSerialization['nutritionCals'] as int?,
      estimatedOrders: jsonSerialization['estimatedOrders'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = FoodItemTable();

  static const db = FoodItemRepository._();

  @override
  int? id;

  int restId;

  String foodName;

  double foodPrice;

  double foodRating;

  String? foodThumbnail;

  String? description;

  int? nutritionCals;

  int estimatedOrders;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FoodItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodItem copyWith({
    int? id,
    int? restId,
    String? foodName,
    double? foodPrice,
    double? foodRating,
    String? foodThumbnail,
    String? description,
    int? nutritionCals,
    int? estimatedOrders,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodItem',
      if (id != null) 'id': id,
      'restId': restId,
      'foodName': foodName,
      'foodPrice': foodPrice,
      'foodRating': foodRating,
      if (foodThumbnail != null) 'foodThumbnail': foodThumbnail,
      if (description != null) 'description': description,
      if (nutritionCals != null) 'nutritionCals': nutritionCals,
      'estimatedOrders': estimatedOrders,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FoodItem',
      if (id != null) 'id': id,
      'restId': restId,
      'foodName': foodName,
      'foodPrice': foodPrice,
      'foodRating': foodRating,
      if (foodThumbnail != null) 'foodThumbnail': foodThumbnail,
      if (description != null) 'description': description,
      if (nutritionCals != null) 'nutritionCals': nutritionCals,
      'estimatedOrders': estimatedOrders,
      'createdAt': createdAt.toJson(),
    };
  }

  static FoodItemInclude include() {
    return FoodItemInclude._();
  }

  static FoodItemIncludeList includeList({
    _i1.WhereExpressionBuilder<FoodItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodItemTable>? orderByList,
    FoodItemInclude? include,
  }) {
    return FoodItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FoodItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodItemImpl extends FoodItem {
  _FoodItemImpl({
    int? id,
    required int restId,
    required String foodName,
    required double foodPrice,
    required double foodRating,
    String? foodThumbnail,
    String? description,
    int? nutritionCals,
    int? estimatedOrders,
    required DateTime createdAt,
  }) : super._(
         id: id,
         restId: restId,
         foodName: foodName,
         foodPrice: foodPrice,
         foodRating: foodRating,
         foodThumbnail: foodThumbnail,
         description: description,
         nutritionCals: nutritionCals,
         estimatedOrders: estimatedOrders,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FoodItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodItem copyWith({
    Object? id = _Undefined,
    int? restId,
    String? foodName,
    double? foodPrice,
    double? foodRating,
    Object? foodThumbnail = _Undefined,
    Object? description = _Undefined,
    Object? nutritionCals = _Undefined,
    int? estimatedOrders,
    DateTime? createdAt,
  }) {
    return FoodItem(
      id: id is int? ? id : this.id,
      restId: restId ?? this.restId,
      foodName: foodName ?? this.foodName,
      foodPrice: foodPrice ?? this.foodPrice,
      foodRating: foodRating ?? this.foodRating,
      foodThumbnail: foodThumbnail is String?
          ? foodThumbnail
          : this.foodThumbnail,
      description: description is String? ? description : this.description,
      nutritionCals: nutritionCals is int? ? nutritionCals : this.nutritionCals,
      estimatedOrders: estimatedOrders ?? this.estimatedOrders,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FoodItemUpdateTable extends _i1.UpdateTable<FoodItemTable> {
  FoodItemUpdateTable(super.table);

  _i1.ColumnValue<int, int> restId(int value) => _i1.ColumnValue(
    table.restId,
    value,
  );

  _i1.ColumnValue<String, String> foodName(String value) => _i1.ColumnValue(
    table.foodName,
    value,
  );

  _i1.ColumnValue<double, double> foodPrice(double value) => _i1.ColumnValue(
    table.foodPrice,
    value,
  );

  _i1.ColumnValue<double, double> foodRating(double value) => _i1.ColumnValue(
    table.foodRating,
    value,
  );

  _i1.ColumnValue<String, String> foodThumbnail(String? value) =>
      _i1.ColumnValue(
        table.foodThumbnail,
        value,
      );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<int, int> nutritionCals(int? value) => _i1.ColumnValue(
    table.nutritionCals,
    value,
  );

  _i1.ColumnValue<int, int> estimatedOrders(int value) => _i1.ColumnValue(
    table.estimatedOrders,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class FoodItemTable extends _i1.Table<int?> {
  FoodItemTable({super.tableRelation}) : super(tableName: 'food_item') {
    updateTable = FoodItemUpdateTable(this);
    restId = _i1.ColumnInt(
      'restId',
      this,
    );
    foodName = _i1.ColumnString(
      'foodName',
      this,
    );
    foodPrice = _i1.ColumnDouble(
      'foodPrice',
      this,
    );
    foodRating = _i1.ColumnDouble(
      'foodRating',
      this,
    );
    foodThumbnail = _i1.ColumnString(
      'foodThumbnail',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    nutritionCals = _i1.ColumnInt(
      'nutritionCals',
      this,
    );
    estimatedOrders = _i1.ColumnInt(
      'estimatedOrders',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final FoodItemUpdateTable updateTable;

  late final _i1.ColumnInt restId;

  late final _i1.ColumnString foodName;

  late final _i1.ColumnDouble foodPrice;

  late final _i1.ColumnDouble foodRating;

  late final _i1.ColumnString foodThumbnail;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt nutritionCals;

  late final _i1.ColumnInt estimatedOrders;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    restId,
    foodName,
    foodPrice,
    foodRating,
    foodThumbnail,
    description,
    nutritionCals,
    estimatedOrders,
    createdAt,
  ];
}

class FoodItemInclude extends _i1.IncludeObject {
  FoodItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FoodItem.t;
}

class FoodItemIncludeList extends _i1.IncludeList {
  FoodItemIncludeList._({
    _i1.WhereExpressionBuilder<FoodItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FoodItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FoodItem.t;
}

class FoodItemRepository {
  const FoodItemRepository._();

  /// Returns a list of [FoodItem]s matching the given query parameters.
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
  Future<List<FoodItem>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodItemTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FoodItem>(
      where: where?.call(FoodItem.t),
      orderBy: orderBy?.call(FoodItem.t),
      orderByList: orderByList?.call(FoodItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FoodItem] matching the given query parameters.
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
  Future<FoodItem?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<FoodItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodItemTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FoodItem>(
      where: where?.call(FoodItem.t),
      orderBy: orderBy?.call(FoodItem.t),
      orderByList: orderByList?.call(FoodItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FoodItem] by its [id] or null if no such row exists.
  Future<FoodItem?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FoodItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FoodItem]s in the list and returns the inserted rows.
  ///
  /// The returned [FoodItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FoodItem>> insert(
    _i1.Session session,
    List<FoodItem> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FoodItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FoodItem] and returns the inserted row.
  ///
  /// The returned [FoodItem] will have its `id` field set.
  Future<FoodItem> insertRow(
    _i1.Session session,
    FoodItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FoodItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FoodItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FoodItem>> update(
    _i1.Session session,
    List<FoodItem> rows, {
    _i1.ColumnSelections<FoodItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FoodItem>(
      rows,
      columns: columns?.call(FoodItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FoodItem> updateRow(
    _i1.Session session,
    FoodItem row, {
    _i1.ColumnSelections<FoodItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FoodItem>(
      row,
      columns: columns?.call(FoodItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FoodItem?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FoodItemUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FoodItem>(
      id,
      columnValues: columnValues(FoodItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FoodItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FoodItem>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FoodItemUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FoodItemTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodItemTable>? orderBy,
    _i1.OrderByListBuilder<FoodItemTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FoodItem>(
      columnValues: columnValues(FoodItem.t.updateTable),
      where: where(FoodItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodItem.t),
      orderByList: orderByList?.call(FoodItem.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FoodItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FoodItem>> delete(
    _i1.Session session,
    List<FoodItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FoodItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FoodItem].
  Future<FoodItem> deleteRow(
    _i1.Session session,
    FoodItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FoodItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FoodItem>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FoodItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FoodItem>(
      where: where(FoodItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FoodItem>(
      where: where?.call(FoodItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FoodItem] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FoodItemTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FoodItem>(
      where: where(FoodItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
