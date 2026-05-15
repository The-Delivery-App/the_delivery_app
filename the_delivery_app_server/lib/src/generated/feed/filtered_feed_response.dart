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

abstract class FilteredFeedResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FilteredFeedResponse._({
    required this.success,
    required this.itemCount,
    required this.message,
  });

  factory FilteredFeedResponse({
    required bool success,
    required int itemCount,
    required String message,
  }) = _FilteredFeedResponseImpl;

  factory FilteredFeedResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FilteredFeedResponse(
      success: _i1.BoolJsonExtension.fromJson(jsonSerialization['success']),
      itemCount: jsonSerialization['itemCount'] as int,
      message: jsonSerialization['message'] as String,
    );
  }

  bool success;

  int itemCount;

  String message;

  /// Returns a shallow copy of this [FilteredFeedResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FilteredFeedResponse copyWith({
    bool? success,
    int? itemCount,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FilteredFeedResponse',
      'success': success,
      'itemCount': itemCount,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FilteredFeedResponse',
      'success': success,
      'itemCount': itemCount,
      'message': message,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FilteredFeedResponseImpl extends FilteredFeedResponse {
  _FilteredFeedResponseImpl({
    required bool success,
    required int itemCount,
    required String message,
  }) : super._(
         success: success,
         itemCount: itemCount,
         message: message,
       );

  /// Returns a shallow copy of this [FilteredFeedResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FilteredFeedResponse copyWith({
    bool? success,
    int? itemCount,
    String? message,
  }) {
    return FilteredFeedResponse(
      success: success ?? this.success,
      itemCount: itemCount ?? this.itemCount,
      message: message ?? this.message,
    );
  }
}
