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

abstract class FoodReview
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FoodReview._({
    this.id,
    required this.userId,
    required this.foodId,
    required this.rating,
    this.comment,
  });

  factory FoodReview({
    int? id,
    required int userId,
    required int foodId,
    required double rating,
    String? comment,
  }) = _FoodReviewImpl;

  factory FoodReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodReview(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      foodId: jsonSerialization['foodId'] as int,
      rating: (jsonSerialization['rating'] as num).toDouble(),
      comment: jsonSerialization['comment'] as String?,
    );
  }

  static final t = FoodReviewTable();

  static const db = FoodReviewRepository._();

  @override
  int? id;

  int userId;

  int foodId;

  double rating;

  String? comment;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FoodReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodReview copyWith({
    int? id,
    int? userId,
    int? foodId,
    double? rating,
    String? comment,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodReview',
      if (id != null) 'id': id,
      'userId': userId,
      'foodId': foodId,
      'rating': rating,
      if (comment != null) 'comment': comment,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FoodReview',
      if (id != null) 'id': id,
      'userId': userId,
      'foodId': foodId,
      'rating': rating,
      if (comment != null) 'comment': comment,
    };
  }

  static FoodReviewInclude include() {
    return FoodReviewInclude._();
  }

  static FoodReviewIncludeList includeList({
    _i1.WhereExpressionBuilder<FoodReviewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodReviewTable>? orderByList,
    FoodReviewInclude? include,
  }) {
    return FoodReviewIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodReview.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FoodReview.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodReviewImpl extends FoodReview {
  _FoodReviewImpl({
    int? id,
    required int userId,
    required int foodId,
    required double rating,
    String? comment,
  }) : super._(
         id: id,
         userId: userId,
         foodId: foodId,
         rating: rating,
         comment: comment,
       );

  /// Returns a shallow copy of this [FoodReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodReview copyWith({
    Object? id = _Undefined,
    int? userId,
    int? foodId,
    double? rating,
    Object? comment = _Undefined,
  }) {
    return FoodReview(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      foodId: foodId ?? this.foodId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
    );
  }
}

class FoodReviewUpdateTable extends _i1.UpdateTable<FoodReviewTable> {
  FoodReviewUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> foodId(int value) => _i1.ColumnValue(
    table.foodId,
    value,
  );

  _i1.ColumnValue<double, double> rating(double value) => _i1.ColumnValue(
    table.rating,
    value,
  );

  _i1.ColumnValue<String, String> comment(String? value) => _i1.ColumnValue(
    table.comment,
    value,
  );
}

class FoodReviewTable extends _i1.Table<int?> {
  FoodReviewTable({super.tableRelation}) : super(tableName: 'food_review') {
    updateTable = FoodReviewUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    foodId = _i1.ColumnInt(
      'foodId',
      this,
    );
    rating = _i1.ColumnDouble(
      'rating',
      this,
    );
    comment = _i1.ColumnString(
      'comment',
      this,
    );
  }

  late final FoodReviewUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt foodId;

  late final _i1.ColumnDouble rating;

  late final _i1.ColumnString comment;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    foodId,
    rating,
    comment,
  ];
}

class FoodReviewInclude extends _i1.IncludeObject {
  FoodReviewInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FoodReview.t;
}

class FoodReviewIncludeList extends _i1.IncludeList {
  FoodReviewIncludeList._({
    _i1.WhereExpressionBuilder<FoodReviewTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FoodReview.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FoodReview.t;
}

class FoodReviewRepository {
  const FoodReviewRepository._();

  /// Returns a list of [FoodReview]s matching the given query parameters.
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
  Future<List<FoodReview>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodReviewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodReviewTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FoodReview>(
      where: where?.call(FoodReview.t),
      orderBy: orderBy?.call(FoodReview.t),
      orderByList: orderByList?.call(FoodReview.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FoodReview] matching the given query parameters.
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
  Future<FoodReview?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodReviewTable>? where,
    int? offset,
    _i1.OrderByBuilder<FoodReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodReviewTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FoodReview>(
      where: where?.call(FoodReview.t),
      orderBy: orderBy?.call(FoodReview.t),
      orderByList: orderByList?.call(FoodReview.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FoodReview] by its [id] or null if no such row exists.
  Future<FoodReview?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FoodReview>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FoodReview]s in the list and returns the inserted rows.
  ///
  /// The returned [FoodReview]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FoodReview>> insert(
    _i1.Session session,
    List<FoodReview> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FoodReview>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FoodReview] and returns the inserted row.
  ///
  /// The returned [FoodReview] will have its `id` field set.
  Future<FoodReview> insertRow(
    _i1.Session session,
    FoodReview row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FoodReview>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FoodReview]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FoodReview>> update(
    _i1.Session session,
    List<FoodReview> rows, {
    _i1.ColumnSelections<FoodReviewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FoodReview>(
      rows,
      columns: columns?.call(FoodReview.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodReview]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FoodReview> updateRow(
    _i1.Session session,
    FoodReview row, {
    _i1.ColumnSelections<FoodReviewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FoodReview>(
      row,
      columns: columns?.call(FoodReview.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodReview] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FoodReview?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FoodReviewUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FoodReview>(
      id,
      columnValues: columnValues(FoodReview.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FoodReview]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FoodReview>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FoodReviewUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FoodReviewTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodReviewTable>? orderBy,
    _i1.OrderByListBuilder<FoodReviewTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FoodReview>(
      columnValues: columnValues(FoodReview.t.updateTable),
      where: where(FoodReview.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodReview.t),
      orderByList: orderByList?.call(FoodReview.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FoodReview]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FoodReview>> delete(
    _i1.Session session,
    List<FoodReview> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FoodReview>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FoodReview].
  Future<FoodReview> deleteRow(
    _i1.Session session,
    FoodReview row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FoodReview>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FoodReview>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FoodReviewTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FoodReview>(
      where: where(FoodReview.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodReviewTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FoodReview>(
      where: where?.call(FoodReview.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FoodReview] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FoodReviewTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FoodReview>(
      where: where(FoodReview.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
