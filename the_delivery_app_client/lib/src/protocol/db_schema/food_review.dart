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

abstract class FoodReview implements _i1.SerializableModel {
  FoodReview._({
    this.id,
    required this.userId,
    required this.foodId,
    required this.rating,
    this.comment,
  });

  factory FoodReview({
    int? id,
    required int userId,
    required int foodId,
    required double rating,
    String? comment,
  }) = _FoodReviewImpl;

  factory FoodReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodReview(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      foodId: jsonSerialization['foodId'] as int,
      rating: (jsonSerialization['rating'] as num).toDouble(),
      comment: jsonSerialization['comment'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int foodId;

  double rating;

  String? comment;

  /// Returns a shallow copy of this [FoodReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodReview copyWith({
    int? id,
    int? userId,
    int? foodId,
    double? rating,
    String? comment,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodReview',
      if (id != null) 'id': id,
      'userId': userId,
      'foodId': foodId,
      'rating': rating,
      if (comment != null) 'comment': comment,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodReviewImpl extends FoodReview {
  _FoodReviewImpl({
    int? id,
    required int userId,
    required int foodId,
    required double rating,
    String? comment,
  }) : super._(
         id: id,
         userId: userId,
         foodId: foodId,
         rating: rating,
         comment: comment,
       );

  /// Returns a shallow copy of this [FoodReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodReview copyWith({
    Object? id = _Undefined,
    int? userId,
    int? foodId,
    double? rating,
    Object? comment = _Undefined,
  }) {
    return FoodReview(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      foodId: foodId ?? this.foodId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
    );
  }
}
