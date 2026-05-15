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

abstract class Basket implements _i1.SerializableModel {
  Basket._({
    this.id,
    required this.userId,
    required this.lastUpdated,
  });

  factory Basket({
    int? id,
    required int userId,
    required DateTime lastUpdated,
  }) = _BasketImpl;

  factory Basket.fromJson(Map<String, dynamic> jsonSerialization) {
    return Basket(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      lastUpdated: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastUpdated'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  DateTime lastUpdated;

  /// Returns a shallow copy of this [Basket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Basket copyWith({
    int? id,
    int? userId,
    DateTime? lastUpdated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Basket',
      if (id != null) 'id': id,
      'userId': userId,
      'lastUpdated': lastUpdated.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BasketImpl extends Basket {
  _BasketImpl({
    int? id,
    required int userId,
    required DateTime lastUpdated,
  }) : super._(
         id: id,
         userId: userId,
         lastUpdated: lastUpdated,
       );

  /// Returns a shallow copy of this [Basket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Basket copyWith({
    Object? id = _Undefined,
    int? userId,
    DateTime? lastUpdated,
  }) {
    return Basket(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
