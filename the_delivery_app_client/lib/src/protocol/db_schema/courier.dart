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

abstract class Courier implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String fname;

  String lname;

  String phone;

  String carName;

  String plateNum;

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
