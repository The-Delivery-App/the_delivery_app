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

abstract class UserFavourite implements _i1.SerializableModel {
  UserFavourite._({
    this.id,
    required this.userId,
    this.restaurantId,
    this.foodItemId,
    required this.createdAt,
  });

  factory UserFavourite({
    int? id,
    required int userId,
    int? restaurantId,
    int? foodItemId,
    required DateTime createdAt,
  }) = _UserFavouriteImpl;

  factory UserFavourite.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserFavourite(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      restaurantId: jsonSerialization['restaurantId'] as int?,
      foodItemId: jsonSerialization['foodItemId'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int? restaurantId;

  int? foodItemId;

  DateTime createdAt;

  /// Returns a shallow copy of this [UserFavourite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserFavourite copyWith({
    int? id,
    int? userId,
    int? restaurantId,
    int? foodItemId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserFavourite',
      if (id != null) 'id': id,
      'userId': userId,
      if (restaurantId != null) 'restaurantId': restaurantId,
      if (foodItemId != null) 'foodItemId': foodItemId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserFavouriteImpl extends UserFavourite {
  _UserFavouriteImpl({
    int? id,
    required int userId,
    int? restaurantId,
    int? foodItemId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         restaurantId: restaurantId,
         foodItemId: foodItemId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserFavourite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserFavourite copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? restaurantId = _Undefined,
    Object? foodItemId = _Undefined,
    DateTime? createdAt,
  }) {
    return UserFavourite(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      restaurantId: restaurantId is int? ? restaurantId : this.restaurantId,
      foodItemId: foodItemId is int? ? foodItemId : this.foodItemId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
