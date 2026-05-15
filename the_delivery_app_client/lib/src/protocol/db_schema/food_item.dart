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

abstract class FoodItem implements _i1.SerializableModel {
  FoodItem._({
    this.id,
    required this.restId,
    required this.foodName,
    required this.foodPrice,
    required this.foodRating,
    this.foodThumbnail,
    this.description,
    this.nutritionCals,
    int? estimatedOrders,
    required this.createdAt,
  }) : estimatedOrders = estimatedOrders ?? 0;

  factory FoodItem({
    int? id,
    required int restId,
    required String foodName,
    required double foodPrice,
    required double foodRating,
    String? foodThumbnail,
    String? description,
    int? nutritionCals,
    int? estimatedOrders,
    required DateTime createdAt,
  }) = _FoodItemImpl;

  factory FoodItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodItem(
      id: jsonSerialization['id'] as int?,
      restId: jsonSerialization['restId'] as int,
      foodName: jsonSerialization['foodName'] as String,
      foodPrice: (jsonSerialization['foodPrice'] as num).toDouble(),
      foodRating: (jsonSerialization['foodRating'] as num).toDouble(),
      foodThumbnail: jsonSerialization['foodThumbnail'] as String?,
      description: jsonSerialization['description'] as String?,
      nutritionCals: jsonSerialization['nutritionCals'] as int?,
      estimatedOrders: jsonSerialization['estimatedOrders'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int restId;

  String foodName;

  double foodPrice;

  double foodRating;

  String? foodThumbnail;

  String? description;

  int? nutritionCals;

  int estimatedOrders;

  DateTime createdAt;

  /// Returns a shallow copy of this [FoodItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodItem copyWith({
    int? id,
    int? restId,
    String? foodName,
    double? foodPrice,
    double? foodRating,
    String? foodThumbnail,
    String? description,
    int? nutritionCals,
    int? estimatedOrders,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodItem',
      if (id != null) 'id': id,
      'restId': restId,
      'foodName': foodName,
      'foodPrice': foodPrice,
      'foodRating': foodRating,
      if (foodThumbnail != null) 'foodThumbnail': foodThumbnail,
      if (description != null) 'description': description,
      if (nutritionCals != null) 'nutritionCals': nutritionCals,
      'estimatedOrders': estimatedOrders,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodItemImpl extends FoodItem {
  _FoodItemImpl({
    int? id,
    required int restId,
    required String foodName,
    required double foodPrice,
    required double foodRating,
    String? foodThumbnail,
    String? description,
    int? nutritionCals,
    int? estimatedOrders,
    required DateTime createdAt,
  }) : super._(
         id: id,
         restId: restId,
         foodName: foodName,
         foodPrice: foodPrice,
         foodRating: foodRating,
         foodThumbnail: foodThumbnail,
         description: description,
         nutritionCals: nutritionCals,
         estimatedOrders: estimatedOrders,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FoodItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodItem copyWith({
    Object? id = _Undefined,
    int? restId,
    String? foodName,
    double? foodPrice,
    double? foodRating,
    Object? foodThumbnail = _Undefined,
    Object? description = _Undefined,
    Object? nutritionCals = _Undefined,
    int? estimatedOrders,
    DateTime? createdAt,
  }) {
    return FoodItem(
      id: id is int? ? id : this.id,
      restId: restId ?? this.restId,
      foodName: foodName ?? this.foodName,
      foodPrice: foodPrice ?? this.foodPrice,
      foodRating: foodRating ?? this.foodRating,
      foodThumbnail: foodThumbnail is String?
          ? foodThumbnail
          : this.foodThumbnail,
      description: description is String? ? description : this.description,
      nutritionCals: nutritionCals is int? ? nutritionCals : this.nutritionCals,
      estimatedOrders: estimatedOrders ?? this.estimatedOrders,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
