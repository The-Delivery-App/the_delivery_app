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
import '../feed/food_item_response.dart' as _i2;
import '../feed/restaurant_response.dart' as _i3;
import 'package:the_delivery_app_server/src/generated/protocol.dart' as _i4;

abstract class FeedChunkResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FeedChunkResponse._({
    required this.success,
    required this.foodItems,
    required this.restaurants,
    required this.totalItemsAvailable,
    required this.fetchedCount,
    this.errorMessage,
    this.errorCode,
  });

  factory FeedChunkResponse({
    required bool success,
    required List<_i2.FoodItemResponse> foodItems,
    required List<_i3.RestaurantResponse> restaurants,
    required int totalItemsAvailable,
    required int fetchedCount,
    String? errorMessage,
    String? errorCode,
  }) = _FeedChunkResponseImpl;

  factory FeedChunkResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedChunkResponse(
      success: _i1.BoolJsonExtension.fromJson(jsonSerialization['success']),
      foodItems: _i4.Protocol().deserialize<List<_i2.FoodItemResponse>>(
        jsonSerialization['foodItems'],
      ),
      restaurants: _i4.Protocol().deserialize<List<_i3.RestaurantResponse>>(
        jsonSerialization['restaurants'],
      ),
      totalItemsAvailable: jsonSerialization['totalItemsAvailable'] as int,
      fetchedCount: jsonSerialization['fetchedCount'] as int,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      errorCode: jsonSerialization['errorCode'] as String?,
    );
  }

  bool success;

  List<_i2.FoodItemResponse> foodItems;

  List<_i3.RestaurantResponse> restaurants;

  int totalItemsAvailable;

  int fetchedCount;

  String? errorMessage;

  String? errorCode;

  /// Returns a shallow copy of this [FeedChunkResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeedChunkResponse copyWith({
    bool? success,
    List<_i2.FoodItemResponse>? foodItems,
    List<_i3.RestaurantResponse>? restaurants,
    int? totalItemsAvailable,
    int? fetchedCount,
    String? errorMessage,
    String? errorCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedChunkResponse',
      'success': success,
      'foodItems': foodItems.toJson(valueToJson: (v) => v.toJson()),
      'restaurants': restaurants.toJson(valueToJson: (v) => v.toJson()),
      'totalItemsAvailable': totalItemsAvailable,
      'fetchedCount': fetchedCount,
      if (errorMessage != null) 'errorMessage': errorMessage,
      if (errorCode != null) 'errorCode': errorCode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedChunkResponse',
      'success': success,
      'foodItems': foodItems.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'restaurants': restaurants.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'totalItemsAvailable': totalItemsAvailable,
      'fetchedCount': fetchedCount,
      if (errorMessage != null) 'errorMessage': errorMessage,
      if (errorCode != null) 'errorCode': errorCode,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeedChunkResponseImpl extends FeedChunkResponse {
  _FeedChunkResponseImpl({
    required bool success,
    required List<_i2.FoodItemResponse> foodItems,
    required List<_i3.RestaurantResponse> restaurants,
    required int totalItemsAvailable,
    required int fetchedCount,
    String? errorMessage,
    String? errorCode,
  }) : super._(
         success: success,
         foodItems: foodItems,
         restaurants: restaurants,
         totalItemsAvailable: totalItemsAvailable,
         fetchedCount: fetchedCount,
         errorMessage: errorMessage,
         errorCode: errorCode,
       );

  /// Returns a shallow copy of this [FeedChunkResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeedChunkResponse copyWith({
    bool? success,
    List<_i2.FoodItemResponse>? foodItems,
    List<_i3.RestaurantResponse>? restaurants,
    int? totalItemsAvailable,
    int? fetchedCount,
    Object? errorMessage = _Undefined,
    Object? errorCode = _Undefined,
  }) {
    return FeedChunkResponse(
      success: success ?? this.success,
      foodItems:
          foodItems ?? this.foodItems.map((e0) => e0.copyWith()).toList(),
      restaurants:
          restaurants ?? this.restaurants.map((e0) => e0.copyWith()).toList(),
      totalItemsAvailable: totalItemsAvailable ?? this.totalItemsAvailable,
      fetchedCount: fetchedCount ?? this.fetchedCount,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      errorCode: errorCode is String? ? errorCode : this.errorCode,
    );
  }
}
