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
    required this.orderId,
    required this.userId,
    required this.amount,
    String? currency,
    required this.paymentMethod,
    this.transactionId,
    required this.providerName,
    this.providerMetadata,
    required this.status,
    required this.createdAt,
    this.processedAt,
    this.refundedAmount,
    this.refundedAt,
    this.refundReason,
  }) : currency = currency ?? 'GBP';

  factory Payment({
    int? id,
    required int orderId,
    required int userId,
    required double amount,
    String? currency,
    required String paymentMethod,
    String? transactionId,
    required String providerName,
    String? providerMetadata,
    required String status,
    required DateTime createdAt,
    DateTime? processedAt,
    double? refundedAmount,
    DateTime? refundedAt,
    String? refundReason,
  }) = _PaymentImpl;

  factory Payment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payment(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      userId: jsonSerialization['userId'] as int,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String?,
      paymentMethod: jsonSerialization['paymentMethod'] as String,
      transactionId: jsonSerialization['transactionId'] as String?,
      providerName: jsonSerialization['providerName'] as String,
      providerMetadata: jsonSerialization['providerMetadata'] as String?,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      processedAt: jsonSerialization['processedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['processedAt'],
            ),
      refundedAmount: (jsonSerialization['refundedAmount'] as num?)?.toDouble(),
      refundedAt: jsonSerialization['refundedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['refundedAt']),
      refundReason: jsonSerialization['refundReason'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int orderId;

  int userId;

  double amount;

  String currency;

  String paymentMethod;

  String? transactionId;

  String providerName;

  String? providerMetadata;

  String status;

  DateTime createdAt;

  DateTime? processedAt;

  double? refundedAmount;

  DateTime? refundedAt;

  String? refundReason;

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Payment copyWith({
    int? id,
    int? orderId,
    int? userId,
    double? amount,
    String? currency,
    String? paymentMethod,
    String? transactionId,
    String? providerName,
    String? providerMetadata,
    String? status,
    DateTime? createdAt,
    DateTime? processedAt,
    double? refundedAmount,
    DateTime? refundedAt,
    String? refundReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      'orderId': orderId,
      'userId': userId,
      'amount': amount,
      'currency': currency,
      'paymentMethod': paymentMethod,
      if (transactionId != null) 'transactionId': transactionId,
      'providerName': providerName,
      if (providerMetadata != null) 'providerMetadata': providerMetadata,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (processedAt != null) 'processedAt': processedAt?.toJson(),
      if (refundedAmount != null) 'refundedAmount': refundedAmount,
      if (refundedAt != null) 'refundedAt': refundedAt?.toJson(),
      if (refundReason != null) 'refundReason': refundReason,
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
    required int orderId,
    required int userId,
    required double amount,
    String? currency,
    required String paymentMethod,
    String? transactionId,
    required String providerName,
    String? providerMetadata,
    required String status,
    required DateTime createdAt,
    DateTime? processedAt,
    double? refundedAmount,
    DateTime? refundedAt,
    String? refundReason,
  }) : super._(
         id: id,
         orderId: orderId,
         userId: userId,
         amount: amount,
         currency: currency,
         paymentMethod: paymentMethod,
         transactionId: transactionId,
         providerName: providerName,
         providerMetadata: providerMetadata,
         status: status,
         createdAt: createdAt,
         processedAt: processedAt,
         refundedAmount: refundedAmount,
         refundedAt: refundedAt,
         refundReason: refundReason,
       );

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Payment copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? userId,
    double? amount,
    String? currency,
    String? paymentMethod,
    Object? transactionId = _Undefined,
    String? providerName,
    Object? providerMetadata = _Undefined,
    String? status,
    DateTime? createdAt,
    Object? processedAt = _Undefined,
    Object? refundedAmount = _Undefined,
    Object? refundedAt = _Undefined,
    Object? refundReason = _Undefined,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionId: transactionId is String?
          ? transactionId
          : this.transactionId,
      providerName: providerName ?? this.providerName,
      providerMetadata: providerMetadata is String?
          ? providerMetadata
          : this.providerMetadata,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      processedAt: processedAt is DateTime? ? processedAt : this.processedAt,
      refundedAmount: refundedAmount is double?
          ? refundedAmount
          : this.refundedAmount,
      refundedAt: refundedAt is DateTime? ? refundedAt : this.refundedAt,
      refundReason: refundReason is String? ? refundReason : this.refundReason,
    );
  }
}
