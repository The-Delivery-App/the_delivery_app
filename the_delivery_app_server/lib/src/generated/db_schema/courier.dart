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

abstract class Courier
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Courier._({
    this.id,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.carName,
    required this.plateNum,
  });

  factory Courier({
    int? id,
    required String fname,
    required String lname,
    required String phone,
    required String carName,
    required String plateNum,
  }) = _CourierImpl;

  factory Courier.fromJson(Map<String, dynamic> jsonSerialization) {
    return Courier(
      id: jsonSerialization['id'] as int?,
      fname: jsonSerialization['fname'] as String,
      lname: jsonSerialization['lname'] as String,
      phone: jsonSerialization['phone'] as String,
      carName: jsonSerialization['carName'] as String,
      plateNum: jsonSerialization['plateNum'] as String,
    );
  }

  static final t = CourierTable();

  static const db = CourierRepository._();

  @override
  int? id;

  String fname;

  String lname;

  String phone;

  String carName;

  String plateNum;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Courier]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Courier copyWith({
    int? id,
    String? fname,
    String? lname,
    String? phone,
    String? carName,
    String? plateNum,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Courier',
      if (id != null) 'id': id,
      'fname': fname,
      'lname': lname,
      'phone': phone,
      'carName': carName,
      'plateNum': plateNum,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Courier',
      if (id != null) 'id': id,
      'fname': fname,
      'lname': lname,
      'phone': phone,
      'carName': carName,
      'plateNum': plateNum,
    };
  }

  static CourierInclude include() {
    return CourierInclude._();
  }

  static CourierIncludeList includeList({
    _i1.WhereExpressionBuilder<CourierTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourierTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourierTable>? orderByList,
    CourierInclude? include,
  }) {
    return CourierIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Courier.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Courier.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourierImpl extends Courier {
  _CourierImpl({
    int? id,
    required String fname,
    required String lname,
    required String phone,
    required String carName,
    required String plateNum,
  }) : super._(
         id: id,
         fname: fname,
         lname: lname,
         phone: phone,
         carName: carName,
         plateNum: plateNum,
       );

  /// Returns a shallow copy of this [Courier]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Courier copyWith({
    Object? id = _Undefined,
    String? fname,
    String? lname,
    String? phone,
    String? carName,
    String? plateNum,
  }) {
    return Courier(
      id: id is int? ? id : this.id,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      phone: phone ?? this.phone,
      carName: carName ?? this.carName,
      plateNum: plateNum ?? this.plateNum,
    );
  }
}

class CourierUpdateTable extends _i1.UpdateTable<CourierTable> {
  CourierUpdateTable(super.table);

  _i1.ColumnValue<String, String> fname(String value) => _i1.ColumnValue(
    table.fname,
    value,
  );

  _i1.ColumnValue<String, String> lname(String value) => _i1.ColumnValue(
    table.lname,
    value,
  );

  _i1.ColumnValue<String, String> phone(String value) => _i1.ColumnValue(
    table.phone,
    value,
  );

  _i1.ColumnValue<String, String> carName(String value) => _i1.ColumnValue(
    table.carName,
    value,
  );

  _i1.ColumnValue<String, String> plateNum(String value) => _i1.ColumnValue(
    table.plateNum,
    value,
  );
}

class CourierTable extends _i1.Table<int?> {
  CourierTable({super.tableRelation}) : super(tableName: 'courier') {
    updateTable = CourierUpdateTable(this);
    fname = _i1.ColumnString(
      'fname',
      this,
    );
    lname = _i1.ColumnString(
      'lname',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    carName = _i1.ColumnString(
      'carName',
      this,
    );
    plateNum = _i1.ColumnString(
      'plateNum',
      this,
    );
  }

  late final CourierUpdateTable updateTable;

  late final _i1.ColumnString fname;

  late final _i1.ColumnString lname;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString carName;

  late final _i1.ColumnString plateNum;

  @override
  List<_i1.Column> get columns => [
    id,
    fname,
    lname,
    phone,
    carName,
    plateNum,
  ];
}

class CourierInclude extends _i1.IncludeObject {
  CourierInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Courier.t;
}

class CourierIncludeList extends _i1.IncludeList {
  CourierIncludeList._({
    _i1.WhereExpressionBuilder<CourierTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Courier.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Courier.t;
}

class CourierRepository {
  const CourierRepository._();

  /// Returns a list of [Courier]s matching the given query parameters.
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
  Future<List<Courier>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CourierTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourierTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourierTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Courier>(
      where: where?.call(Courier.t),
      orderBy: orderBy?.call(Courier.t),
      orderByList: orderByList?.call(Courier.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Courier] matching the given query parameters.
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
  Future<Courier?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CourierTable>? where,
    int? offset,
    _i1.OrderByBuilder<CourierTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourierTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Courier>(
      where: where?.call(Courier.t),
      orderBy: orderBy?.call(Courier.t),
      orderByList: orderByList?.call(Courier.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Courier] by its [id] or null if no such row exists.
  Future<Courier?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Courier>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Courier]s in the list and returns the inserted rows.
  ///
  /// The returned [Courier]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Courier>> insert(
    _i1.Session session,
    List<Courier> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Courier>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Courier] and returns the inserted row.
  ///
  /// The returned [Courier] will have its `id` field set.
  Future<Courier> insertRow(
    _i1.Session session,
    Courier row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Courier>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Courier]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Courier>> update(
    _i1.Session session,
    List<Courier> rows, {
    _i1.ColumnSelections<CourierTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Courier>(
      rows,
      columns: columns?.call(Courier.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Courier]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Courier> updateRow(
    _i1.Session session,
    Courier row, {
    _i1.ColumnSelections<CourierTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Courier>(
      row,
      columns: columns?.call(Courier.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Courier] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Courier?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CourierUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Courier>(
      id,
      columnValues: columnValues(Courier.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Courier]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Courier>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CourierUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CourierTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourierTable>? orderBy,
    _i1.OrderByListBuilder<CourierTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Courier>(
      columnValues: columnValues(Courier.t.updateTable),
      where: where(Courier.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Courier.t),
      orderByList: orderByList?.call(Courier.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Courier]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Courier>> delete(
    _i1.Session session,
    List<Courier> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Courier>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Courier].
  Future<Courier> deleteRow(
    _i1.Session session,
    Courier row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Courier>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Courier>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CourierTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Courier>(
      where: where(Courier.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CourierTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Courier>(
      where: where?.call(Courier.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Courier] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CourierTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Courier>(
      where: where(Courier.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
