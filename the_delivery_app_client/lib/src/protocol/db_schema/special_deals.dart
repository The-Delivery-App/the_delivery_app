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

abstract class SpecialDeals implements _i1.SerializableModel {
  SpecialDeals._({
    this.id,
    required this.placeId,
    this.thumbnail,
    required this.description,
    required this.discountAmount,
  });

  factory SpecialDeals({
    int? id,
    required int placeId,
    String? thumbnail,
    required String description,
    required double discountAmount,
  }) = _SpecialDealsImpl;

  factory SpecialDeals.fromJson(Map<String, dynamic> jsonSerialization) {
    return SpecialDeals(
      id: jsonSerialization['id'] as int?,
      placeId: jsonSerialization['placeId'] as int,
      thumbnail: jsonSerialization['thumbnail'] as String?,
      description: jsonSerialization['description'] as String,
      discountAmount: (jsonSerialization['discountAmount'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int placeId;

  String? thumbnail;

  String description;

  double discountAmount;

  /// Returns a shallow copy of this [SpecialDeals]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpecialDeals copyWith({
    int? id,
    int? placeId,
    String? thumbnail,
    String? description,
    double? discountAmount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SpecialDeals',
      if (id != null) 'id': id,
      'placeId': placeId,
      if (thumbnail != null) 'thumbnail': thumbnail,
      'description': description,
      'discountAmount': discountAmount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpecialDealsImpl extends SpecialDeals {
  _SpecialDealsImpl({
    int? id,
    required int placeId,
    String? thumbnail,
    required String description,
    required double discountAmount,
  }) : super._(
         id: id,
         placeId: placeId,
         thumbnail: thumbnail,
         description: description,
         discountAmount: discountAmount,
       );

  /// Returns a shallow copy of this [SpecialDeals]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpecialDeals copyWith({
    Object? id = _Undefined,
    int? placeId,
    Object? thumbnail = _Undefined,
    String? description,
    double? discountAmount,
  }) {
    return SpecialDeals(
      id: id is int? ? id : this.id,
      placeId: placeId ?? this.placeId,
      thumbnail: thumbnail is String? ? thumbnail : this.thumbnail,
      description: description ?? this.description,
      discountAmount: discountAmount ?? this.discountAmount,
    );
  }
}
