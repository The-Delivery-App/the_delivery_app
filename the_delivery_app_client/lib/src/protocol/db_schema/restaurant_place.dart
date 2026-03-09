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

abstract class RestaurantPlace implements _i1.SerializableModel {
  RestaurantPlace._({
    this.id,
    required this.restId,
    this.name,
    required this.city,
    required this.country,
    required this.postcode,
    required this.addressLine1,
    this.addressLine2,
    required this.latitude,
    required this.longitude,
  });

  factory RestaurantPlace({
    int? id,
    required int restId,
    String? name,
    required String city,
    required String country,
    required String postcode,
    required String addressLine1,
    String? addressLine2,
    required double latitude,
    required double longitude,
  }) = _RestaurantPlaceImpl;

  factory RestaurantPlace.fromJson(Map<String, dynamic> jsonSerialization) {
    return RestaurantPlace(
      id: jsonSerialization['id'] as int?,
      restId: jsonSerialization['restId'] as int,
      name: jsonSerialization['name'] as String?,
      city: jsonSerialization['city'] as String,
      country: jsonSerialization['country'] as String,
      postcode: jsonSerialization['postcode'] as String,
      addressLine1: jsonSerialization['addressLine1'] as String,
      addressLine2: jsonSerialization['addressLine2'] as String?,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int restId;

  String? name;

  String city;

  String country;

  String postcode;

  String addressLine1;

  String? addressLine2;

  double latitude;

  double longitude;

  /// Returns a shallow copy of this [RestaurantPlace]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RestaurantPlace copyWith({
    int? id,
    int? restId,
    String? name,
    String? city,
    String? country,
    String? postcode,
    String? addressLine1,
    String? addressLine2,
    double? latitude,
    double? longitude,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RestaurantPlace',
      if (id != null) 'id': id,
      'restId': restId,
      if (name != null) 'name': name,
      'city': city,
      'country': country,
      'postcode': postcode,
      'addressLine1': addressLine1,
      if (addressLine2 != null) 'addressLine2': addressLine2,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RestaurantPlaceImpl extends RestaurantPlace {
  _RestaurantPlaceImpl({
    int? id,
    required int restId,
    String? name,
    required String city,
    required String country,
    required String postcode,
    required String addressLine1,
    String? addressLine2,
    required double latitude,
    required double longitude,
  }) : super._(
         id: id,
         restId: restId,
         name: name,
         city: city,
         country: country,
         postcode: postcode,
         addressLine1: addressLine1,
         addressLine2: addressLine2,
         latitude: latitude,
         longitude: longitude,
       );

  /// Returns a shallow copy of this [RestaurantPlace]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RestaurantPlace copyWith({
    Object? id = _Undefined,
    int? restId,
    Object? name = _Undefined,
    String? city,
    String? country,
    String? postcode,
    String? addressLine1,
    Object? addressLine2 = _Undefined,
    double? latitude,
    double? longitude,
  }) {
    return RestaurantPlace(
      id: id is int? ? id : this.id,
      restId: restId ?? this.restId,
      name: name is String? ? name : this.name,
      city: city ?? this.city,
      country: country ?? this.country,
      postcode: postcode ?? this.postcode,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 is String? ? addressLine2 : this.addressLine2,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
