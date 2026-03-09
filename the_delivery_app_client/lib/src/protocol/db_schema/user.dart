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

abstract class User implements _i1.SerializableModel {
  User._({
    this.id,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.email,
    required this.passwordHash,
  });

  factory User({
    int? id,
    required String fname,
    required String lname,
    required String phone,
    required String email,
    required String passwordHash,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      fname: jsonSerialization['fname'] as String,
      lname: jsonSerialization['lname'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String fname;

  String lname;

  String phone;

  String email;

  String passwordHash;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    String? fname,
    String? lname,
    String? phone,
    String? email,
    String? passwordHash,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id,
      'fname': fname,
      'lname': lname,
      'phone': phone,
      'email': email,
      'passwordHash': passwordHash,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required String fname,
    required String lname,
    required String phone,
    required String email,
    required String passwordHash,
  }) : super._(
         id: id,
         fname: fname,
         lname: lname,
         phone: phone,
         email: email,
         passwordHash: passwordHash,
       );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    String? fname,
    String? lname,
    String? phone,
    String? email,
    String? passwordHash,
  }) {
    return User(
      id: id is int? ? id : this.id,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
    );
  }
}
