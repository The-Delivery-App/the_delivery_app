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

abstract class SplitPaymentParticipant
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SplitPaymentParticipant._({
    this.id,
    required this.orderId,
    required this.userId,
    this.paymentId,
    required this.amountDue,
    bool? hasPaid,
    this.paidAt,
    required this.invitedAt,
    this.reminderSentAt,
  }) : hasPaid = hasPaid ?? false;

  factory SplitPaymentParticipant({
    int? id,
    required int orderId,
    required int userId,
    int? paymentId,
    required double amountDue,
    bool? hasPaid,
    DateTime? paidAt,
    required DateTime invitedAt,
    DateTime? reminderSentAt,
  }) = _SplitPaymentParticipantImpl;

  factory SplitPaymentParticipant.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SplitPaymentParticipant(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      userId: jsonSerialization['userId'] as int,
      paymentId: jsonSerialization['paymentId'] as int?,
      amountDue: (jsonSerialization['amountDue'] as num).toDouble(),
      hasPaid: jsonSerialization['hasPaid'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['hasPaid']),
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      invitedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['invitedAt'],
      ),
      reminderSentAt: jsonSerialization['reminderSentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['reminderSentAt'],
            ),
    );
  }

  static final t = SplitPaymentParticipantTable();

  static const db = SplitPaymentParticipantRepository._();

  @override
  int? id;

  int orderId;

  int userId;

  int? paymentId;

  double amountDue;

  bool hasPaid;

  DateTime? paidAt;

  DateTime invitedAt;

  DateTime? reminderSentAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SplitPaymentParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SplitPaymentParticipant copyWith({
    int? id,
    int? orderId,
    int? userId,
    int? paymentId,
    double? amountDue,
    bool? hasPaid,
    DateTime? paidAt,
    DateTime? invitedAt,
    DateTime? reminderSentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SplitPaymentParticipant',
      if (id != null) 'id': id,
      'orderId': orderId,
      'userId': userId,
      if (paymentId != null) 'paymentId': paymentId,
      'amountDue': amountDue,
      'hasPaid': hasPaid,
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      'invitedAt': invitedAt.toJson(),
      if (reminderSentAt != null) 'reminderSentAt': reminderSentAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SplitPaymentParticipant',
      if (id != null) 'id': id,
      'orderId': orderId,
      'userId': userId,
      if (paymentId != null) 'paymentId': paymentId,
      'amountDue': amountDue,
      'hasPaid': hasPaid,
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      'invitedAt': invitedAt.toJson(),
      if (reminderSentAt != null) 'reminderSentAt': reminderSentAt?.toJson(),
    };
  }

  static SplitPaymentParticipantInclude include() {
    return SplitPaymentParticipantInclude._();
  }

  static SplitPaymentParticipantIncludeList includeList({
    _i1.WhereExpressionBuilder<SplitPaymentParticipantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SplitPaymentParticipantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SplitPaymentParticipantTable>? orderByList,
    SplitPaymentParticipantInclude? include,
  }) {
    return SplitPaymentParticipantIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SplitPaymentParticipant.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SplitPaymentParticipant.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SplitPaymentParticipantImpl extends SplitPaymentParticipant {
  _SplitPaymentParticipantImpl({
    int? id,
    required int orderId,
    required int userId,
    int? paymentId,
    required double amountDue,
    bool? hasPaid,
    DateTime? paidAt,
    required DateTime invitedAt,
    DateTime? reminderSentAt,
  }) : super._(
         id: id,
         orderId: orderId,
         userId: userId,
         paymentId: paymentId,
         amountDue: amountDue,
         hasPaid: hasPaid,
         paidAt: paidAt,
         invitedAt: invitedAt,
         reminderSentAt: reminderSentAt,
       );

  /// Returns a shallow copy of this [SplitPaymentParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SplitPaymentParticipant copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? userId,
    Object? paymentId = _Undefined,
    double? amountDue,
    bool? hasPaid,
    Object? paidAt = _Undefined,
    DateTime? invitedAt,
    Object? reminderSentAt = _Undefined,
  }) {
    return SplitPaymentParticipant(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      paymentId: paymentId is int? ? paymentId : this.paymentId,
      amountDue: amountDue ?? this.amountDue,
      hasPaid: hasPaid ?? this.hasPaid,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
      invitedAt: invitedAt ?? this.invitedAt,
      reminderSentAt: reminderSentAt is DateTime?
          ? reminderSentAt
          : this.reminderSentAt,
    );
  }
}

class SplitPaymentParticipantUpdateTable
    extends _i1.UpdateTable<SplitPaymentParticipantTable> {
  SplitPaymentParticipantUpdateTable(super.table);

  _i1.ColumnValue<int, int> orderId(int value) => _i1.ColumnValue(
    table.orderId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> paymentId(int? value) => _i1.ColumnValue(
    table.paymentId,
    value,
  );

  _i1.ColumnValue<double, double> amountDue(double value) => _i1.ColumnValue(
    table.amountDue,
    value,
  );

  _i1.ColumnValue<bool, bool> hasPaid(bool value) => _i1.ColumnValue(
    table.hasPaid,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> paidAt(DateTime? value) =>
      _i1.ColumnValue(
        table.paidAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> invitedAt(DateTime value) =>
      _i1.ColumnValue(
        table.invitedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> reminderSentAt(DateTime? value) =>
      _i1.ColumnValue(
        table.reminderSentAt,
        value,
      );
}

class SplitPaymentParticipantTable extends _i1.Table<int?> {
  SplitPaymentParticipantTable({super.tableRelation})
    : super(tableName: 'split_payment_participant') {
    updateTable = SplitPaymentParticipantUpdateTable(this);
    orderId = _i1.ColumnInt(
      'orderId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    paymentId = _i1.ColumnInt(
      'paymentId',
      this,
    );
    amountDue = _i1.ColumnDouble(
      'amountDue',
      this,
    );
    hasPaid = _i1.ColumnBool(
      'hasPaid',
      this,
      hasDefault: true,
    );
    paidAt = _i1.ColumnDateTime(
      'paidAt',
      this,
    );
    invitedAt = _i1.ColumnDateTime(
      'invitedAt',
      this,
    );
    reminderSentAt = _i1.ColumnDateTime(
      'reminderSentAt',
      this,
    );
  }

  late final SplitPaymentParticipantUpdateTable updateTable;

  late final _i1.ColumnInt orderId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt paymentId;

  late final _i1.ColumnDouble amountDue;

  late final _i1.ColumnBool hasPaid;

  late final _i1.ColumnDateTime paidAt;

  late final _i1.ColumnDateTime invitedAt;

  late final _i1.ColumnDateTime reminderSentAt;

  @override
  List<_i1.Column> get columns => [
    id,
    orderId,
    userId,
    paymentId,
    amountDue,
    hasPaid,
    paidAt,
    invitedAt,
    reminderSentAt,
  ];
}

class SplitPaymentParticipantInclude extends _i1.IncludeObject {
  SplitPaymentParticipantInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SplitPaymentParticipant.t;
}

class SplitPaymentParticipantIncludeList extends _i1.IncludeList {
  SplitPaymentParticipantIncludeList._({
    _i1.WhereExpressionBuilder<SplitPaymentParticipantTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SplitPaymentParticipant.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SplitPaymentParticipant.t;
}

class SplitPaymentParticipantRepository {
  const SplitPaymentParticipantRepository._();

  /// Returns a list of [SplitPaymentParticipant]s matching the given query parameters.
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
  Future<List<SplitPaymentParticipant>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SplitPaymentParticipantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SplitPaymentParticipantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SplitPaymentParticipantTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SplitPaymentParticipant>(
      where: where?.call(SplitPaymentParticipant.t),
      orderBy: orderBy?.call(SplitPaymentParticipant.t),
      orderByList: orderByList?.call(SplitPaymentParticipant.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SplitPaymentParticipant] matching the given query parameters.
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
  Future<SplitPaymentParticipant?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SplitPaymentParticipantTable>? where,
    int? offset,
    _i1.OrderByBuilder<SplitPaymentParticipantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SplitPaymentParticipantTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SplitPaymentParticipant>(
      where: where?.call(SplitPaymentParticipant.t),
      orderBy: orderBy?.call(SplitPaymentParticipant.t),
      orderByList: orderByList?.call(SplitPaymentParticipant.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SplitPaymentParticipant] by its [id] or null if no such row exists.
  Future<SplitPaymentParticipant?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SplitPaymentParticipant>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SplitPaymentParticipant]s in the list and returns the inserted rows.
  ///
  /// The returned [SplitPaymentParticipant]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SplitPaymentParticipant>> insert(
    _i1.DatabaseSession session,
    List<SplitPaymentParticipant> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SplitPaymentParticipant>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SplitPaymentParticipant] and returns the inserted row.
  ///
  /// The returned [SplitPaymentParticipant] will have its `id` field set.
  Future<SplitPaymentParticipant> insertRow(
    _i1.DatabaseSession session,
    SplitPaymentParticipant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SplitPaymentParticipant>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SplitPaymentParticipant]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SplitPaymentParticipant>> update(
    _i1.DatabaseSession session,
    List<SplitPaymentParticipant> rows, {
    _i1.ColumnSelections<SplitPaymentParticipantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SplitPaymentParticipant>(
      rows,
      columns: columns?.call(SplitPaymentParticipant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SplitPaymentParticipant]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SplitPaymentParticipant> updateRow(
    _i1.DatabaseSession session,
    SplitPaymentParticipant row, {
    _i1.ColumnSelections<SplitPaymentParticipantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SplitPaymentParticipant>(
      row,
      columns: columns?.call(SplitPaymentParticipant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SplitPaymentParticipant] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SplitPaymentParticipant?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SplitPaymentParticipantUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SplitPaymentParticipant>(
      id,
      columnValues: columnValues(SplitPaymentParticipant.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SplitPaymentParticipant]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SplitPaymentParticipant>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SplitPaymentParticipantUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SplitPaymentParticipantTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SplitPaymentParticipantTable>? orderBy,
    _i1.OrderByListBuilder<SplitPaymentParticipantTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SplitPaymentParticipant>(
      columnValues: columnValues(SplitPaymentParticipant.t.updateTable),
      where: where(SplitPaymentParticipant.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SplitPaymentParticipant.t),
      orderByList: orderByList?.call(SplitPaymentParticipant.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SplitPaymentParticipant]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SplitPaymentParticipant>> delete(
    _i1.DatabaseSession session,
    List<SplitPaymentParticipant> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SplitPaymentParticipant>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SplitPaymentParticipant].
  Future<SplitPaymentParticipant> deleteRow(
    _i1.DatabaseSession session,
    SplitPaymentParticipant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SplitPaymentParticipant>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SplitPaymentParticipant>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SplitPaymentParticipantTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SplitPaymentParticipant>(
      where: where(SplitPaymentParticipant.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SplitPaymentParticipantTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SplitPaymentParticipant>(
      where: where?.call(SplitPaymentParticipant.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SplitPaymentParticipant] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SplitPaymentParticipantTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SplitPaymentParticipant>(
      where: where(SplitPaymentParticipant.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
