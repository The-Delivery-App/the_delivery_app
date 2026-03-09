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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class FoodItemResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FoodItemResponse._({
    this.id,
    required this.name,
    this.iconUrl,
    required this.price,
    required this.rating,
    required this.estimatedOrdersAmount,
    required this.estimatedDeliveryTime,
    this.distanceKm,
    required this.restaurantName,
    this.restaurantIconUrl,
  });

  factory FoodItemResponse({
    int? id,
    required String name,
    String? iconUrl,
    required double price,
    required double rating,
    required int estimatedOrdersAmount,
    required double estimatedDeliveryTime,
    double? distanceKm,
    required String restaurantName,
    String? restaurantIconUrl,
  }) = _FoodItemResponseImpl;

  factory FoodItemResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodItemResponse(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      iconUrl: jsonSerialization['iconUrl'] as String?,
      price: (jsonSerialization['price'] as num).toDouble(),
      rating: (jsonSerialization['rating'] as num).toDouble(),
      estimatedOrdersAmount: jsonSerialization['estimatedOrdersAmount'] as int,
      estimatedDeliveryTime: (jsonSerialization['estimatedDeliveryTime'] as num)
          .toDouble(),
      distanceKm: (jsonSerialization['distanceKm'] as num?)?.toDouble(),
      restaurantName: jsonSerialization['restaurantName'] as String,
      restaurantIconUrl: jsonSerialization['restaurantIconUrl'] as String?,
    );
  }

  int? id;

  String name;

  String? iconUrl;

  double price;

  double rating;

  int estimatedOrdersAmount;

  double estimatedDeliveryTime;

  double? distanceKm;

  String restaurantName;

  String? restaurantIconUrl;

  /// Returns a shallow copy of this [FoodItemResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodItemResponse copyWith({
    int? id,
    String? name,
    String? iconUrl,
    double? price,
    double? rating,
    int? estimatedOrdersAmount,
    double? estimatedDeliveryTime,
    double? distanceKm,
    String? restaurantName,
    String? restaurantIconUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodItemResponse',
      if (id != null) 'id': id,
      'name': name,
      if (iconUrl != null) 'iconUrl': iconUrl,
      'price': price,
      'rating': rating,
      'estimatedOrdersAmount': estimatedOrdersAmount,
      'estimatedDeliveryTime': estimatedDeliveryTime,
      if (distanceKm != null) 'distanceKm': distanceKm,
      'restaurantName': restaurantName,
      if (restaurantIconUrl != null) 'restaurantIconUrl': restaurantIconUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FoodItemResponse',
      if (id != null) 'id': id,
      'name': name,
      if (iconUrl != null) 'iconUrl': iconUrl,
      'price': price,
      'rating': rating,
      'estimatedOrdersAmount': estimatedOrdersAmount,
      'estimatedDeliveryTime': estimatedDeliveryTime,
      if (distanceKm != null) 'distanceKm': distanceKm,
      'restaurantName': restaurantName,
      if (restaurantIconUrl != null) 'restaurantIconUrl': restaurantIconUrl,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodItemResponseImpl extends FoodItemResponse {
  _FoodItemResponseImpl({
    int? id,
    required String name,
    String? iconUrl,
    required double price,
    required double rating,
    required int estimatedOrdersAmount,
    required double estimatedDeliveryTime,
    double? distanceKm,
    required String restaurantName,
    String? restaurantIconUrl,
  }) : super._(
         id: id,
         name: name,
         iconUrl: iconUrl,
         price: price,
         rating: rating,
         estimatedOrdersAmount: estimatedOrdersAmount,
         estimatedDeliveryTime: estimatedDeliveryTime,
         distanceKm: distanceKm,
         restaurantName: restaurantName,
         restaurantIconUrl: restaurantIconUrl,
       );

  /// Returns a shallow copy of this [FoodItemResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodItemResponse copyWith({
    Object? id = _Undefined,
    String? name,
    Object? iconUrl = _Undefined,
    double? price,
    double? rating,
    int? estimatedOrdersAmount,
    double? estimatedDeliveryTime,
    Object? distanceKm = _Undefined,
    String? restaurantName,
    Object? restaurantIconUrl = _Undefined,
  }) {
    return FoodItemResponse(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      iconUrl: iconUrl is String? ? iconUrl : this.iconUrl,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      estimatedOrdersAmount:
          estimatedOrdersAmount ?? this.estimatedOrdersAmount,
      estimatedDeliveryTime:
          estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      distanceKm: distanceKm is double? ? distanceKm : this.distanceKm,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantIconUrl: restaurantIconUrl is String?
          ? restaurantIconUrl
          : this.restaurantIconUrl,
    );
  }
}
