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

enum OrderStatus implements _i1.SerializableModel {
  placed,
  confirmed,
  assigned,
  restaurant,
  customer,
  delivered;

  static OrderStatus fromJson(String name) {
    switch (name) {
      case 'placed':
        return OrderStatus.placed;
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'assigned':
        return OrderStatus.assigned;
      case 'restaurant':
        return OrderStatus.restaurant;
      case 'customer':
        return OrderStatus.customer;
      case 'delivered':
        return OrderStatus.delivered;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "OrderStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
