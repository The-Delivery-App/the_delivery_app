/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class OrderItem implements _i1.SerializableModel {
  OrderItem._({
    this.id,
    required this.orderId,
    required this.foodItemId,
    required this.quantity,
    required this.unitPrice,
    this.specialInstructions,
    required this.foodItemName,
    this.foodItemDescription,
  });

  factory OrderItem({
    int? id,
    required int orderId,
    required int foodItemId,
    required int quantity,
    required double unitPrice,
    String? specialInstructions,
    required String foodItemName,
    String? foodItemDescription,
  }) = _OrderItemImpl;

  factory OrderItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderItem(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      foodItemId: jsonSerialization['foodItemId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      unitPrice: (jsonSerialization['unitPrice'] as num).toDouble(),
      specialInstructions: jsonSerialization['specialInstructions'] as String?,
      foodItemName: jsonSerialization['foodItemName'] as String,
      foodItemDescription: jsonSerialization['foodItemDescription'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int orderId;

  int foodItemId;

  int quantity;

  double unitPrice;

  String? specialInstructions;

  String foodItemName;

  String? foodItemDescription;

  /// Returns a shallow copy of this [OrderItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderItem copyWith({
    int? id,
    int? orderId,
    int? foodItemId,
    int? quantity,
    double? unitPrice,
    String? specialInstructions,
    String? foodItemName,
    String? foodItemDescription,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'orderId': orderId,
      'foodItemId': foodItemId,
      'quantity': quantity,
      'unitPrice': unitPrice,
      if (specialInstructions != null)
        'specialInstructions': specialInstructions,
      'foodItemName': foodItemName,
      if (foodItemDescription != null)
        'foodItemDescription': foodItemDescription,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderItemImpl extends OrderItem {
  _OrderItemImpl({
    int? id,
    required int orderId,
    required int foodItemId,
    required int quantity,
    required double unitPrice,
    String? specialInstructions,
    required String foodItemName,
    String? foodItemDescription,
  }) : super._(
          id: id,
          orderId: orderId,
          foodItemId: foodItemId,
          quantity: quantity,
          unitPrice: unitPrice,
          specialInstructions: specialInstructions,
          foodItemName: foodItemName,
          foodItemDescription: foodItemDescription,
        );

  /// Returns a shallow copy of this [OrderItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderItem copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? foodItemId,
    int? quantity,
    double? unitPrice,
    Object? specialInstructions = _Undefined,
    String? foodItemName,
    Object? foodItemDescription = _Undefined,
  }) {
    return OrderItem(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      foodItemId: foodItemId ?? this.foodItemId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      specialInstructions: specialInstructions is String?
          ? specialInstructions
          : this.specialInstructions,
      foodItemName: foodItemName ?? this.foodItemName,
      foodItemDescription: foodItemDescription is String?
          ? foodItemDescription
          : this.foodItemDescription,
    );
  }
}
