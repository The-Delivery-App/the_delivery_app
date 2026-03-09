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

abstract class FoodDeal implements _i1.SerializableModel {
  FoodDeal._({
    this.id,
    required this.specialDealId,
    required this.foodId,
    required this.itemQty,
  });

  factory FoodDeal({
    int? id,
    required int specialDealId,
    required int foodId,
    required int itemQty,
  }) = _FoodDealImpl;

  factory FoodDeal.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodDeal(
      id: jsonSerialization['id'] as int?,
      specialDealId: jsonSerialization['specialDealId'] as int,
      foodId: jsonSerialization['foodId'] as int,
      itemQty: jsonSerialization['itemQty'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int specialDealId;

  int foodId;

  int itemQty;

  /// Returns a shallow copy of this [FoodDeal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodDeal copyWith({
    int? id,
    int? specialDealId,
    int? foodId,
    int? itemQty,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodDeal',
      if (id != null) 'id': id,
      'specialDealId': specialDealId,
      'foodId': foodId,
      'itemQty': itemQty,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodDealImpl extends FoodDeal {
  _FoodDealImpl({
    int? id,
    required int specialDealId,
    required int foodId,
    required int itemQty,
  }) : super._(
         id: id,
         specialDealId: specialDealId,
         foodId: foodId,
         itemQty: itemQty,
       );

  /// Returns a shallow copy of this [FoodDeal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodDeal copyWith({
    Object? id = _Undefined,
    int? specialDealId,
    int? foodId,
    int? itemQty,
  }) {
    return FoodDeal(
      id: id is int? ? id : this.id,
      specialDealId: specialDealId ?? this.specialDealId,
      foodId: foodId ?? this.foodId,
      itemQty: itemQty ?? this.itemQty,
    );
  }
}
