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

abstract class Restaurant implements _i1.SerializableModel {
  Restaurant._({
    this.id,
    required this.restName,
    this.logoThumb,
    double? estimatedDeliveryTime,
    this.cuisine,
  }) : estimatedDeliveryTime = estimatedDeliveryTime ?? 30.0;

  factory Restaurant({
    int? id,
    required String restName,
    String? logoThumb,
    double? estimatedDeliveryTime,
    String? cuisine,
  }) = _RestaurantImpl;

  factory Restaurant.fromJson(Map<String, dynamic> jsonSerialization) {
    return Restaurant(
      id: jsonSerialization['id'] as int?,
      restName: jsonSerialization['restName'] as String,
      logoThumb: jsonSerialization['logoThumb'] as String?,
      estimatedDeliveryTime:
          (jsonSerialization['estimatedDeliveryTime'] as num?)?.toDouble(),
      cuisine: jsonSerialization['cuisine'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String restName;

  String? logoThumb;

  double estimatedDeliveryTime;

  String? cuisine;

  /// Returns a shallow copy of this [Restaurant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Restaurant copyWith({
    int? id,
    String? restName,
    String? logoThumb,
    double? estimatedDeliveryTime,
    String? cuisine,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Restaurant',
      if (id != null) 'id': id,
      'restName': restName,
      if (logoThumb != null) 'logoThumb': logoThumb,
      'estimatedDeliveryTime': estimatedDeliveryTime,
      if (cuisine != null) 'cuisine': cuisine,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RestaurantImpl extends Restaurant {
  _RestaurantImpl({
    int? id,
    required String restName,
    String? logoThumb,
    double? estimatedDeliveryTime,
    String? cuisine,
  }) : super._(
         id: id,
         restName: restName,
         logoThumb: logoThumb,
         estimatedDeliveryTime: estimatedDeliveryTime,
         cuisine: cuisine,
       );

  /// Returns a shallow copy of this [Restaurant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Restaurant copyWith({
    Object? id = _Undefined,
    String? restName,
    Object? logoThumb = _Undefined,
    double? estimatedDeliveryTime,
    Object? cuisine = _Undefined,
  }) {
    return Restaurant(
      id: id is int? ? id : this.id,
      restName: restName ?? this.restName,
      logoThumb: logoThumb is String? ? logoThumb : this.logoThumb,
      estimatedDeliveryTime:
          estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      cuisine: cuisine is String? ? cuisine : this.cuisine,
    );
  }
}
