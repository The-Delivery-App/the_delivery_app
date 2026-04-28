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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../db_schema/order_status.dart' as _i2;

abstract class Order implements _i1.SerializableModel {
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
        (jsonSerialization['currentStatus'] as String),
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      estimatedDeliveryTime: jsonSerialization['estimatedDeliveryTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['estimatedDeliveryTime'],
            ),
      actualDeliveryTime: jsonSerialization['actualDeliveryTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['actualDeliveryTime'],
            ),
      isSplit: jsonSerialization['isSplit'] as bool,
      deliveryInstructions:
          jsonSerialization['deliveryInstructions'] as String?,
      courierLatitude: (jsonSerialization['courierLatitude'] as num?)
          ?.toDouble(),
      courierLongitude: (jsonSerialization['courierLongitude'] as num?)
          ?.toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
      '__className__': 'Order',
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
      courierLatitude: courierLatitude is double?
          ? courierLatitude
          : this.courierLatitude,
      courierLongitude: courierLongitude is double?
          ? courierLongitude
          : this.courierLongitude,
    );
  }
}
