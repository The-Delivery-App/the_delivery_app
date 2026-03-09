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

abstract class Address implements _i1.SerializableModel {
  Address._({
    this.id,
    required this.userId,
    required this.isDefault,
    required this.country,
    required this.city,
    required this.postcode,
    required this.addressLine1,
    this.addressLine2,
  });

  factory Address({
    int? id,
    required int userId,
    required bool isDefault,
    required String country,
    required String city,
    required String postcode,
    required String addressLine1,
    String? addressLine2,
  }) = _AddressImpl;

  factory Address.fromJson(Map<String, dynamic> jsonSerialization) {
    return Address(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      isDefault: _i1.BoolJsonExtension.fromJson(jsonSerialization['isDefault']),
      country: jsonSerialization['country'] as String,
      city: jsonSerialization['city'] as String,
      postcode: jsonSerialization['postcode'] as String,
      addressLine1: jsonSerialization['addressLine1'] as String,
      addressLine2: jsonSerialization['addressLine2'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  bool isDefault;

  String country;

  String city;

  String postcode;

  String addressLine1;

  String? addressLine2;

  /// Returns a shallow copy of this [Address]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Address copyWith({
    int? id,
    int? userId,
    bool? isDefault,
    String? country,
    String? city,
    String? postcode,
    String? addressLine1,
    String? addressLine2,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Address',
      if (id != null) 'id': id,
      'userId': userId,
      'isDefault': isDefault,
      'country': country,
      'city': city,
      'postcode': postcode,
      'addressLine1': addressLine1,
      if (addressLine2 != null) 'addressLine2': addressLine2,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AddressImpl extends Address {
  _AddressImpl({
    int? id,
    required int userId,
    required bool isDefault,
    required String country,
    required String city,
    required String postcode,
    required String addressLine1,
    String? addressLine2,
  }) : super._(
         id: id,
         userId: userId,
         isDefault: isDefault,
         country: country,
         city: city,
         postcode: postcode,
         addressLine1: addressLine1,
         addressLine2: addressLine2,
       );

  /// Returns a shallow copy of this [Address]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Address copyWith({
    Object? id = _Undefined,
    int? userId,
    bool? isDefault,
    String? country,
    String? city,
    String? postcode,
    String? addressLine1,
    Object? addressLine2 = _Undefined,
  }) {
    return Address(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      isDefault: isDefault ?? this.isDefault,
      country: country ?? this.country,
      city: city ?? this.city,
      postcode: postcode ?? this.postcode,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 is String? ? addressLine2 : this.addressLine2,
    );
  }
}
