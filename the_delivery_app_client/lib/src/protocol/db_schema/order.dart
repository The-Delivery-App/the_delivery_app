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
    this.courierId,
    required this.userId,
    required this.time,
    required this.isSplit,
    required this.currentStatus,
  });

  factory Order({
    int? id,
    int? courierId,
    required int userId,
    required DateTime time,
    required bool isSplit,
    required _i2.OrderStatus currentStatus,
  }) = _OrderImpl;

  factory Order.fromJson(Map<String, dynamic> jsonSerialization) {
    return Order(
      id: jsonSerialization['id'] as int?,
      courierId: jsonSerialization['courierId'] as int?,
      userId: jsonSerialization['userId'] as int,
      time: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['time']),
      isSplit: _i1.BoolJsonExtension.fromJson(jsonSerialization['isSplit']),
      currentStatus: _i2.OrderStatus.fromJson(
        (jsonSerialization['currentStatus'] as String),
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? courierId;

  int userId;

  DateTime time;

  bool isSplit;

  _i2.OrderStatus currentStatus;

  /// Returns a shallow copy of this [Order]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Order copyWith({
    int? id,
    int? courierId,
    int? userId,
    DateTime? time,
    bool? isSplit,
    _i2.OrderStatus? currentStatus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Order',
      if (id != null) 'id': id,
      if (courierId != null) 'courierId': courierId,
      'userId': userId,
      'time': time.toJson(),
      'isSplit': isSplit,
      'currentStatus': currentStatus.toJson(),
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
    int? courierId,
    required int userId,
    required DateTime time,
    required bool isSplit,
    required _i2.OrderStatus currentStatus,
  }) : super._(
         id: id,
         courierId: courierId,
         userId: userId,
         time: time,
         isSplit: isSplit,
         currentStatus: currentStatus,
       );

  /// Returns a shallow copy of this [Order]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Order copyWith({
    Object? id = _Undefined,
    Object? courierId = _Undefined,
    int? userId,
    DateTime? time,
    bool? isSplit,
    _i2.OrderStatus? currentStatus,
  }) {
    return Order(
      id: id is int? ? id : this.id,
      courierId: courierId is int? ? courierId : this.courierId,
      userId: userId ?? this.userId,
      time: time ?? this.time,
      isSplit: isSplit ?? this.isSplit,
      currentStatus: currentStatus ?? this.currentStatus,
    );
  }
}
