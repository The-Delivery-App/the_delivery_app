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

abstract class SplitPaymentParticipant implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int orderId;

  int userId;

  int? paymentId;

  double amountDue;

  bool hasPaid;

  DateTime? paidAt;

  DateTime invitedAt;

  DateTime? reminderSentAt;

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
