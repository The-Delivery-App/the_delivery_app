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

abstract class BasketFood implements _i1.SerializableModel {
  BasketFood._({
    this.id,
    required this.basketId,
    required this.foodId,
    required this.qty,
  });

  factory BasketFood({
    int? id,
    required int basketId,
    required int foodId,
    required int qty,
  }) = _BasketFoodImpl;

  factory BasketFood.fromJson(Map<String, dynamic> jsonSerialization) {
    return BasketFood(
      id: jsonSerialization['id'] as int?,
      basketId: jsonSerialization['basketId'] as int,
      foodId: jsonSerialization['foodId'] as int,
      qty: jsonSerialization['qty'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int basketId;

  int foodId;

  int qty;

  /// Returns a shallow copy of this [BasketFood]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BasketFood copyWith({
    int? id,
    int? basketId,
    int? foodId,
    int? qty,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BasketFood',
      if (id != null) 'id': id,
      'basketId': basketId,
      'foodId': foodId,
      'qty': qty,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BasketFoodImpl extends BasketFood {
  _BasketFoodImpl({
    int? id,
    required int basketId,
    required int foodId,
    required int qty,
  }) : super._(
         id: id,
         basketId: basketId,
         foodId: foodId,
         qty: qty,
       );

  /// Returns a shallow copy of this [BasketFood]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BasketFood copyWith({
    Object? id = _Undefined,
    int? basketId,
    int? foodId,
    int? qty,
  }) {
    return BasketFood(
      id: id is int? ? id : this.id,
      basketId: basketId ?? this.basketId,
      foodId: foodId ?? this.foodId,
      qty: qty ?? this.qty,
    );
  }
}
