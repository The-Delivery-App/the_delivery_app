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

abstract class FoodTag implements _i1.SerializableModel {
  FoodTag._({
    this.id,
    required this.tagId,
    required this.foodId,
  });

  factory FoodTag({
    int? id,
    required int tagId,
    required int foodId,
  }) = _FoodTagImpl;

  factory FoodTag.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodTag(
      id: jsonSerialization['id'] as int?,
      tagId: jsonSerialization['tagId'] as int,
      foodId: jsonSerialization['foodId'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int tagId;

  int foodId;

  /// Returns a shallow copy of this [FoodTag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodTag copyWith({
    int? id,
    int? tagId,
    int? foodId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodTag',
      if (id != null) 'id': id,
      'tagId': tagId,
      'foodId': foodId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodTagImpl extends FoodTag {
  _FoodTagImpl({
    int? id,
    required int tagId,
    required int foodId,
  }) : super._(
         id: id,
         tagId: tagId,
         foodId: foodId,
       );

  /// Returns a shallow copy of this [FoodTag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodTag copyWith({
    Object? id = _Undefined,
    int? tagId,
    int? foodId,
  }) {
    return FoodTag(
      id: id is int? ? id : this.id,
      tagId: tagId ?? this.tagId,
      foodId: foodId ?? this.foodId,
    );
  }
}
