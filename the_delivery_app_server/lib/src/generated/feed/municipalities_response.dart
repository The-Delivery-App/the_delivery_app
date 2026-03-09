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
import 'package:the_delivery_app_server/src/generated/protocol.dart' as _i2;

abstract class MunicipalitiesResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  MunicipalitiesResponse._({
    required this.success,
    required this.municipalities,
    required this.message,
  });

  factory MunicipalitiesResponse({
    required bool success,
    required List<String> municipalities,
    required String message,
  }) = _MunicipalitiesResponseImpl;

  factory MunicipalitiesResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MunicipalitiesResponse(
      success: _i1.BoolJsonExtension.fromJson(jsonSerialization['success']),
      municipalities: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['municipalities'],
      ),
      message: jsonSerialization['message'] as String,
    );
  }

  bool success;

  List<String> municipalities;

  String message;

  /// Returns a shallow copy of this [MunicipalitiesResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MunicipalitiesResponse copyWith({
    bool? success,
    List<String>? municipalities,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MunicipalitiesResponse',
      'success': success,
      'municipalities': municipalities.toJson(),
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MunicipalitiesResponse',
      'success': success,
      'municipalities': municipalities.toJson(),
      'message': message,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MunicipalitiesResponseImpl extends MunicipalitiesResponse {
  _MunicipalitiesResponseImpl({
    required bool success,
    required List<String> municipalities,
    required String message,
  }) : super._(
         success: success,
         municipalities: municipalities,
         message: message,
       );

  /// Returns a shallow copy of this [MunicipalitiesResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MunicipalitiesResponse copyWith({
    bool? success,
    List<String>? municipalities,
    String? message,
  }) {
    return MunicipalitiesResponse(
      success: success ?? this.success,
      municipalities:
          municipalities ?? this.municipalities.map((e0) => e0).toList(),
      message: message ?? this.message,
    );
  }
}
