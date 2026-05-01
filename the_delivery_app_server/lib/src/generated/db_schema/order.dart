/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../db_schema/order_status.dart' as _i2;

abstract class Order implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Order._({
    this.id,
    required this.userId,
    required this.restaurantId,
    required this.deliveryAddressId,
    this.courierId,
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.discount,
    required this.totalAmount,
    required this.idempotencyKey,
    required this.currentStatus,
    required this.createdAt,
    this.updatedAt,
    this.estimatedDeliveryTime,
    this.actualDeliveryTime,
    required this.isSplit,
    this.deliveryInstructions,
    this.courierLatitude,
    this.courierLongitude,
  });

  factory Order({
    int? id,
    required int userId,
    required int restaurantId,
    required int deliveryAddressId,
    int? courierId,
    required double subtotal,
    required double deliveryFee,
    required double serviceFee,
    required double discount,
    required double totalAmount,
    required String idempotencyKey,
    required _i2.OrderStatus currentStatus,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? estimatedDeliveryTime,
    DateTime? actualDeliveryTime,
    required bool isSplit,
    String? deliveryInstructions,
    double? courierLatitude,
    double? courierLongitude,
  }) = _OrderImpl;

  factory Order.fromJson(Map<String, dynamic> jsonSerialization) {
    return Order(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      restaurantId: jsonSerialization['restaurantId'] as int,
      deliveryAddressId: jsonSerialization['deliveryAddressId'] as int,
      courierId: jsonSerialization['courierId'] as int?,
      subtotal: (jsonSerialization['subtotal'] as num).toDouble(),
      deliveryFee: (jsonSerialization['deliveryFee'] as num).toDouble(),
      serviceFee: (jsonSerialization['serviceFee'] as num).toDouble(),
      discount: (jsonSerialization['discount'] as num).toDouble(),
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
      idempotencyKey: jsonSerialization['idempotencyKey'] as String,
      currentStatus: _i2.OrderStatus.fromJson(
          (jsonSerialization['currentStatus'] as String)),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      estimatedDeliveryTime: jsonSerialization['estimatedDeliveryTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['estimatedDeliveryTime']),
      actualDeliveryTime: jsonSerialization['actualDeliveryTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['actualDeliveryTime']),
      isSplit: jsonSerialization['isSplit'] as bool,
      deliveryInstructions:
          jsonSerialization['deliveryInstructions'] as String?,
      courierLatitude:
          (jsonSerialization['courierLatitude'] as num?)?.toDouble(),
      courierLongitude:
          (jsonSerialization['courierLongitude'] as num?)?.toDouble(),
    );
  }

  static final t = OrderTable();

  static const db = OrderRepository._();

  @override
  int? id;

  int userId;

  int restaurantId;

  int deliveryAddressId;

  int? courierId;

  double subtotal;

  double deliveryFee;

  double serviceFee;

  double discount;

  double totalAmount;

  String idempotencyKey;

  _i2.OrderStatus currentStatus;

  DateTime createdAt;

  DateTime? updatedAt;

  DateTime? estimatedDeliveryTime;

  DateTime? actualDeliveryTime;

  bool isSplit;

  String? deliveryInstructions;

  double? courierLatitude;

  double? courierLongitude;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Order]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Order copyWith({
    int? id,
    int? userId,
    int? restaurantId,
    int? deliveryAddressId,
    int? courierId,
    double? subtotal,
    double? deliveryFee,
    double? serviceFee,
    double? discount,
    double? totalAmount,
    String? idempotencyKey,
    _i2.OrderStatus? currentStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? estimatedDeliveryTime,
    DateTime? actualDeliveryTime,
    bool? isSplit,
    String? deliveryInstructions,
    double? courierLatitude,
    double? courierLongitude,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'restaurantId': restaurantId,
      'deliveryAddressId': deliveryAddressId,
      if (courierId != null) 'courierId': courierId,
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'serviceFee': serviceFee,
      'discount': discount,
      'totalAmount': totalAmount,
      'idempotencyKey': idempotencyKey,
      'currentStatus': currentStatus.toJson(),
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (estimatedDeliveryTime != null)
        'estimatedDeliveryTime': estimatedDeliveryTime?.toJson(),
      if (actualDeliveryTime != null)
        'actualDeliveryTime': actualDeliveryTime?.toJson(),
      'isSplit': isSplit,
      if (deliveryInstructions != null)
        'deliveryInstructions': deliveryInstructions,
      if (courierLatitude != null) 'courierLatitude': courierLatitude,
      if (courierLongitude != null) 'courierLongitude': courierLongitude,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'restaurantId': restaurantId,
      'deliveryAddressId': deliveryAddressId,
      if (courierId != null) 'courierId': courierId,
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'serviceFee': serviceFee,
      'discount': discount,
      'totalAmount': totalAmount,
      'idempotencyKey': idempotencyKey,
      'currentStatus': currentStatus.toJson(),
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (estimatedDeliveryTime != null)
        'estimatedDeliveryTime': estimatedDeliveryTime?.toJson(),
      if (actualDeliveryTime != null)
        'actualDeliveryTime': actualDeliveryTime?.toJson(),
      'isSplit': isSplit,
      if (deliveryInstructions != null)
        'deliveryInstructions': deliveryInstructions,
      if (courierLatitude != null) 'courierLatitude': courierLatitude,
      if (courierLongitude != null) 'courierLongitude': courierLongitude,
    };
  }

  static OrderInclude include() {
    return OrderInclude._();
  }

  static OrderIncludeList includeList({
    _i1.WhereExpressionBuilder<OrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderTable>? orderByList,
    OrderInclude? include,
  }) {
    return OrderIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Order.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Order.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderImpl extends Order {
  _OrderImpl({
    int? id,
    required int userId,
    required int restaurantId,
    required int deliveryAddressId,
    int? courierId,
    required double subtotal,
    required double deliveryFee,
    required double serviceFee,
    required double discount,
    required double totalAmount,
    required String idempotencyKey,
    required _i2.OrderStatus currentStatus,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? estimatedDeliveryTime,
    DateTime? actualDeliveryTime,
    required bool isSplit,
    String? deliveryInstructions,
    double? courierLatitude,
    double? courierLongitude,
  }) : super._(
          id: id,
          userId: userId,
          restaurantId: restaurantId,
          deliveryAddressId: deliveryAddressId,
          courierId: courierId,
          subtotal: subtotal,
          deliveryFee: deliveryFee,
          serviceFee: serviceFee,
          discount: discount,
          totalAmount: totalAmount,
          idempotencyKey: idempotencyKey,
          currentStatus: currentStatus,
          createdAt: createdAt,
          updatedAt: updatedAt,
          estimatedDeliveryTime: estimatedDeliveryTime,
          actualDeliveryTime: actualDeliveryTime,
          isSplit: isSplit,
          deliveryInstructions: deliveryInstructions,
          courierLatitude: courierLatitude,
          courierLongitude: courierLongitude,
        );

  /// Returns a shallow copy of this [Order]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Order copyWith({
    Object? id = _Undefined,
    int? userId,
    int? restaurantId,
    int? deliveryAddressId,
    Object? courierId = _Undefined,
    double? subtotal,
    double? deliveryFee,
    double? serviceFee,
    double? discount,
    double? totalAmount,
    String? idempotencyKey,
    _i2.OrderStatus? currentStatus,
    DateTime? createdAt,
    Object? updatedAt = _Undefined,
    Object? estimatedDeliveryTime = _Undefined,
    Object? actualDeliveryTime = _Undefined,
    bool? isSplit,
    Object? deliveryInstructions = _Undefined,
    Object? courierLatitude = _Undefined,
    Object? courierLongitude = _Undefined,
  }) {
    return Order(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      restaurantId: restaurantId ?? this.restaurantId,
      deliveryAddressId: deliveryAddressId ?? this.deliveryAddressId,
      courierId: courierId is int? ? courierId : this.courierId,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      serviceFee: serviceFee ?? this.serviceFee,
      discount: discount ?? this.discount,
      totalAmount: totalAmount ?? this.totalAmount,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      currentStatus: currentStatus ?? this.currentStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      estimatedDeliveryTime: estimatedDeliveryTime is DateTime?
          ? estimatedDeliveryTime
          : this.estimatedDeliveryTime,
      actualDeliveryTime: actualDeliveryTime is DateTime?
          ? actualDeliveryTime
          : this.actualDeliveryTime,
      isSplit: isSplit ?? this.isSplit,
      deliveryInstructions: deliveryInstructions is String?
          ? deliveryInstructions
          : this.deliveryInstructions,
      courierLatitude:
          courierLatitude is double? ? courierLatitude : this.courierLatitude,
      courierLongitude: courierLongitude is double?
          ? courierLongitude
          : this.courierLongitude,
    );
  }
}

class OrderTable extends _i1.Table<int?> {
  OrderTable({super.tableRelation}) : super(tableName: 'order') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    restaurantId = _i1.ColumnInt(
      'restaurantId',
      this,
    );
    deliveryAddressId = _i1.ColumnInt(
      'deliveryAddressId',
      this,
    );
    courierId = _i1.ColumnInt(
      'courierId',
      this,
    );
    subtotal = _i1.ColumnDouble(
      'subtotal',
      this,
    );
    deliveryFee = _i1.ColumnDouble(
      'deliveryFee',
      this,
    );
    serviceFee = _i1.ColumnDouble(
      'serviceFee',
      this,
    );
    discount = _i1.ColumnDouble(
      'discount',
      this,
    );
    totalAmount = _i1.ColumnDouble(
      'totalAmount',
      this,
    );
    idempotencyKey = _i1.ColumnString(
      'idempotencyKey',
      this,
    );
    currentStatus = _i1.ColumnEnum(
      'currentStatus',
      this,
      _i1.EnumSerialization.byName,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
    estimatedDeliveryTime = _i1.ColumnDateTime(
      'estimatedDeliveryTime',
      this,
    );
    actualDeliveryTime = _i1.ColumnDateTime(
      'actualDeliveryTime',
      this,
    );
    isSplit = _i1.ColumnBool(
      'isSplit',
      this,
    );
    deliveryInstructions = _i1.ColumnString(
      'deliveryInstructions',
      this,
    );
    courierLatitude = _i1.ColumnDouble(
      'courierLatitude',
      this,
    );
    courierLongitude = _i1.ColumnDouble(
      'courierLongitude',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt restaurantId;

  late final _i1.ColumnInt deliveryAddressId;

  late final _i1.ColumnInt courierId;

  late final _i1.ColumnDouble subtotal;

  late final _i1.ColumnDouble deliveryFee;

  late final _i1.ColumnDouble serviceFee;

  late final _i1.ColumnDouble discount;

  late final _i1.ColumnDouble totalAmount;

  late final _i1.ColumnString idempotencyKey;

  late final _i1.ColumnEnum<_i2.OrderStatus> currentStatus;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime estimatedDeliveryTime;

  late final _i1.ColumnDateTime actualDeliveryTime;

  late final _i1.ColumnBool isSplit;

  late final _i1.ColumnString deliveryInstructions;

  late final _i1.ColumnDouble courierLatitude;

  late final _i1.ColumnDouble courierLongitude;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        restaurantId,
        deliveryAddressId,
        courierId,
        subtotal,
        deliveryFee,
        serviceFee,
        discount,
        totalAmount,
        idempotencyKey,
        currentStatus,
        createdAt,
        updatedAt,
        estimatedDeliveryTime,
        actualDeliveryTime,
        isSplit,
        deliveryInstructions,
        courierLatitude,
        courierLongitude,
      ];
}

class OrderInclude extends _i1.IncludeObject {
  OrderInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Order.t;
}

class OrderIncludeList extends _i1.IncludeList {
  OrderIncludeList._({
    _i1.WhereExpressionBuilder<OrderTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Order.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Order.t;
}

class OrderRepository {
  const OrderRepository._();

  /// Returns a list of [Order]s matching the given query parameters.
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
  Future<List<Order>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Order>(
      where: where?.call(Order.t),
      orderBy: orderBy?.call(Order.t),
      orderByList: orderByList?.call(Order.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Order] matching the given query parameters.
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
  Future<Order?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Order>(
      where: where?.call(Order.t),
      orderBy: orderBy?.call(Order.t),
      orderByList: orderByList?.call(Order.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Order] by its [id] or null if no such row exists.
  Future<Order?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Order>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Order]s in the list and returns the inserted rows.
  ///
  /// The returned [Order]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Order>> insert(
    _i1.Session session,
    List<Order> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Order>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Order] and returns the inserted row.
  ///
  /// The returned [Order] will have its `id` field set.
  Future<Order> insertRow(
    _i1.Session session,
    Order row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Order>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Order]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Order>> update(
    _i1.Session session,
    List<Order> rows, {
    _i1.ColumnSelections<OrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Order>(
      rows,
      columns: columns?.call(Order.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Order]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Order> updateRow(
    _i1.Session session,
    Order row, {
    _i1.ColumnSelections<OrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Order>(
      row,
      columns: columns?.call(Order.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Order]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Order>> delete(
    _i1.Session session,
    List<Order> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Order>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Order].
  Future<Order> deleteRow(
    _i1.Session session,
    Order row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Order>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Order>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OrderTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Order>(
      where: where(Order.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Order>(
      where: where?.call(Order.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
