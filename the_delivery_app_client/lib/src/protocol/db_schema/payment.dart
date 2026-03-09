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

abstract class Payment implements _i1.SerializableModel {
  Payment._({
    this.id,
    required this.userId,
    required this.orderId,
    required this.amount,
    required this.createdAt,
    required this.transactionTime,
  });

  factory Payment({
    int? id,
    required int userId,
    required int orderId,
    required double amount,
    required DateTime createdAt,
    required DateTime transactionTime,
  }) = _PaymentImpl;

  factory Payment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      orderId: jsonSerialization['orderId'] as int,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      transactionTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['transactionTime'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int orderId;

  double amount;

  DateTime createdAt;

  DateTime transactionTime;

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Payment copyWith({
    int? id,
    int? userId,
    int? orderId,
    double? amount,
    DateTime? createdAt,
    DateTime? transactionTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      'userId': userId,
      'orderId': orderId,
      'amount': amount,
      'createdAt': createdAt.toJson(),
      'transactionTime': transactionTime.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentImpl extends Payment {
  _PaymentImpl({
    int? id,
    required int userId,
    required int orderId,
    required double amount,
    required DateTime createdAt,
    required DateTime transactionTime,
  }) : super._(
         id: id,
         userId: userId,
         orderId: orderId,
         amount: amount,
         createdAt: createdAt,
         transactionTime: transactionTime,
       );

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Payment copyWith({
    Object? id = _Undefined,
    int? userId,
    int? orderId,
    double? amount,
    DateTime? createdAt,
    DateTime? transactionTime,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      orderId: orderId ?? this.orderId,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      transactionTime: transactionTime ?? this.transactionTime,
    );
  }
}
