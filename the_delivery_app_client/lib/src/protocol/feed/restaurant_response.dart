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
import 'package:the_delivery_app_client/src/protocol/protocol.dart' as _i2;

abstract class RestaurantResponse implements _i1.SerializableModel {
  RestaurantResponse._({
    required this.id,
    required this.name,
    this.iconUrl,
    required this.estimatedDeliveryTime,
    this.cuisine,
  });

  factory RestaurantResponse({
    required int id,
    required String name,
    String? iconUrl,
    required double estimatedDeliveryTime,
    List<String>? cuisine,
  }) = _RestaurantResponseImpl;

  factory RestaurantResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return RestaurantResponse(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      iconUrl: jsonSerialization['iconUrl'] as String?,
      estimatedDeliveryTime: (jsonSerialization['estimatedDeliveryTime'] as num)
          .toDouble(),
      cuisine: jsonSerialization['cuisine'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['cuisine'],
            ),
    );
  }

  int id;

  String name;

  String? iconUrl;

  double estimatedDeliveryTime;

  List<String>? cuisine;

  /// Returns a shallow copy of this [RestaurantResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RestaurantResponse copyWith({
    int? id,
    String? name,
    String? iconUrl,
    double? estimatedDeliveryTime,
    List<String>? cuisine,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RestaurantResponse',
      'id': id,
      'name': name,
      if (iconUrl != null) 'iconUrl': iconUrl,
      'estimatedDeliveryTime': estimatedDeliveryTime,
      if (cuisine != null) 'cuisine': cuisine?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RestaurantResponseImpl extends RestaurantResponse {
  _RestaurantResponseImpl({
    required int id,
    required String name,
    String? iconUrl,
    required double estimatedDeliveryTime,
    List<String>? cuisine,
  }) : super._(
         id: id,
         name: name,
         iconUrl: iconUrl,
         estimatedDeliveryTime: estimatedDeliveryTime,
         cuisine: cuisine,
       );

  /// Returns a shallow copy of this [RestaurantResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RestaurantResponse copyWith({
    int? id,
    String? name,
    Object? iconUrl = _Undefined,
    double? estimatedDeliveryTime,
    Object? cuisine = _Undefined,
  }) {
    return RestaurantResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      iconUrl: iconUrl is String? ? iconUrl : this.iconUrl,
      estimatedDeliveryTime:
          estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      cuisine: cuisine is List<String>?
          ? cuisine
          : this.cuisine?.map((e0) => e0).toList(),
    );
  }
}
