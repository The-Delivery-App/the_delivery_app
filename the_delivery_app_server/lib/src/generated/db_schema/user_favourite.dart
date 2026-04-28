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

abstract class UserFavourite
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserFavourite._({
    this.id,
    required this.userId,
    this.restaurantId,
    this.foodItemId,
    required this.createdAt,
  });

  factory UserFavourite({
    int? id,
    required int userId,
    int? restaurantId,
    int? foodItemId,
    required DateTime createdAt,
  }) = _UserFavouriteImpl;

  factory UserFavourite.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserFavourite(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      restaurantId: jsonSerialization['restaurantId'] as int?,
      foodItemId: jsonSerialization['foodItemId'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = UserFavouriteTable();

  static const db = UserFavouriteRepository._();

  @override
  int? id;

  int userId;

  int? restaurantId;

  int? foodItemId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserFavourite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserFavourite copyWith({
    int? id,
    int? userId,
    int? restaurantId,
    int? foodItemId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserFavourite',
      if (id != null) 'id': id,
      'userId': userId,
      if (restaurantId != null) 'restaurantId': restaurantId,
      if (foodItemId != null) 'foodItemId': foodItemId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserFavourite',
      if (id != null) 'id': id,
      'userId': userId,
      if (restaurantId != null) 'restaurantId': restaurantId,
      if (foodItemId != null) 'foodItemId': foodItemId,
      'createdAt': createdAt.toJson(),
    };
  }

  static UserFavouriteInclude include() {
    return UserFavouriteInclude._();
  }

  static UserFavouriteIncludeList includeList({
    _i1.WhereExpressionBuilder<UserFavouriteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserFavouriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserFavouriteTable>? orderByList,
    UserFavouriteInclude? include,
  }) {
    return UserFavouriteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserFavourite.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserFavourite.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserFavouriteImpl extends UserFavourite {
  _UserFavouriteImpl({
    int? id,
    required int userId,
    int? restaurantId,
    int? foodItemId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         restaurantId: restaurantId,
         foodItemId: foodItemId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserFavourite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserFavourite copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? restaurantId = _Undefined,
    Object? foodItemId = _Undefined,
    DateTime? createdAt,
  }) {
    return UserFavourite(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      restaurantId: restaurantId is int? ? restaurantId : this.restaurantId,
      foodItemId: foodItemId is int? ? foodItemId : this.foodItemId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class UserFavouriteUpdateTable extends _i1.UpdateTable<UserFavouriteTable> {
  UserFavouriteUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> restaurantId(int? value) => _i1.ColumnValue(
    table.restaurantId,
    value,
  );

  _i1.ColumnValue<int, int> foodItemId(int? value) => _i1.ColumnValue(
    table.foodItemId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class UserFavouriteTable extends _i1.Table<int?> {
  UserFavouriteTable({super.tableRelation})
    : super(tableName: 'user_favourite') {
    updateTable = UserFavouriteUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    restaurantId = _i1.ColumnInt(
      'restaurantId',
      this,
    );
    foodItemId = _i1.ColumnInt(
      'foodItemId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final UserFavouriteUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt restaurantId;

  late final _i1.ColumnInt foodItemId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    restaurantId,
    foodItemId,
    createdAt,
  ];
}

class UserFavouriteInclude extends _i1.IncludeObject {
  UserFavouriteInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserFavourite.t;
}

class UserFavouriteIncludeList extends _i1.IncludeList {
  UserFavouriteIncludeList._({
    _i1.WhereExpressionBuilder<UserFavouriteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserFavourite.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserFavourite.t;
}

class UserFavouriteRepository {
  const UserFavouriteRepository._();

  /// Returns a list of [UserFavourite]s matching the given query parameters.
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
  Future<List<UserFavourite>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserFavouriteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserFavouriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserFavouriteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserFavourite>(
      where: where?.call(UserFavourite.t),
      orderBy: orderBy?.call(UserFavourite.t),
      orderByList: orderByList?.call(UserFavourite.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserFavourite] matching the given query parameters.
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
  Future<UserFavourite?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserFavouriteTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserFavouriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserFavouriteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserFavourite>(
      where: where?.call(UserFavourite.t),
      orderBy: orderBy?.call(UserFavourite.t),
      orderByList: orderByList?.call(UserFavourite.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserFavourite] by its [id] or null if no such row exists.
  Future<UserFavourite?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserFavourite>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserFavourite]s in the list and returns the inserted rows.
  ///
  /// The returned [UserFavourite]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserFavourite>> insert(
    _i1.Session session,
    List<UserFavourite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserFavourite>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserFavourite] and returns the inserted row.
  ///
  /// The returned [UserFavourite] will have its `id` field set.
  Future<UserFavourite> insertRow(
    _i1.Session session,
    UserFavourite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserFavourite>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserFavourite]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserFavourite>> update(
    _i1.Session session,
    List<UserFavourite> rows, {
    _i1.ColumnSelections<UserFavouriteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserFavourite>(
      rows,
      columns: columns?.call(UserFavourite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserFavourite]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserFavourite> updateRow(
    _i1.Session session,
    UserFavourite row, {
    _i1.ColumnSelections<UserFavouriteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserFavourite>(
      row,
      columns: columns?.call(UserFavourite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserFavourite] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserFavourite?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<UserFavouriteUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserFavourite>(
      id,
      columnValues: columnValues(UserFavourite.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserFavourite]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserFavourite>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<UserFavouriteUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserFavouriteTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserFavouriteTable>? orderBy,
    _i1.OrderByListBuilder<UserFavouriteTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserFavourite>(
      columnValues: columnValues(UserFavourite.t.updateTable),
      where: where(UserFavourite.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserFavourite.t),
      orderByList: orderByList?.call(UserFavourite.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserFavourite]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserFavourite>> delete(
    _i1.Session session,
    List<UserFavourite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserFavourite>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserFavourite].
  Future<UserFavourite> deleteRow(
    _i1.Session session,
    UserFavourite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserFavourite>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserFavourite>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserFavouriteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserFavourite>(
      where: where(UserFavourite.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserFavouriteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserFavourite>(
      where: where?.call(UserFavourite.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
