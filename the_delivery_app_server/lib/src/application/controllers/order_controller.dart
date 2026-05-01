import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart' hide Order;
import '../../generated/protocol.dart' as protocol;
import 'dart:convert';

class OrderController extends Endpoint {

  Future<String> hello(Session session) async {
    return 'Order controller working';
  }

  Future<String> getOrder(
    Session session,
    int orderId,
  ) async {
    try {
      final order = await protocol.Order.db.findById(session, orderId);

      if (order == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Order not found',
          'errorCode': 'NOT_FOUND',
        });
      }

      final items = await OrderItem.db.find(
        session,
        where: (t) => t.orderId.equals(orderId),
      );

      final restaurant = await Restaurant.db.findById(session, order.restaurantId);

      return jsonEncode({
        'success': true,
        'order': {
          'id': order.id,
          'status': order.currentStatus.name,
          'totalAmount': order.totalAmount,
          'restaurant': restaurant?.restName,
          'items': items.map((i) => {
            'name': i.foodItemName,
            'quantity': i.quantity,
            'price': i.unitPrice,
          }).toList(),
        },
      });
    } catch (e) {
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> createOrder(
    Session session,
    String requestJson,
  ) async {
    try {
      final data = jsonDecode(requestJson) as Map<String, dynamic>;
      final userId = data['userId'] as int;
      final restaurantId = data['restaurantId'] as int;
      final deliveryAddressId = data['deliveryAddressId'] as int;
      final idempotencyKey = data['idempotencyKey'] as String;
      final items = data['items'] as List<dynamic>;
      final deliveryInstructions = data['deliveryInstructions'] as String?;

      // Check idempotency
      final existingOrder = await protocol.Order.db.findFirstRow(
        session,
        where: (t) => t.idempotencyKey.equals(idempotencyKey),
      );

      if (existingOrder != null) {
        return jsonEncode({
          'success': true,
          'message': 'Order already exists',
          'orderId': existingOrder.id,
        });
      }

      // Calculate totals
      double subtotal = 0.0;
      final orderItemsData = <Map<String, dynamic>>[];

      for (final item in items) {
        final foodItemId = item['foodItemId'] as int;
        final quantity = item['quantity'] as int;

        final foodItem = await FoodItem.db.findById(session, foodItemId);
        if (foodItem == null) {
          return jsonEncode({
            'success': false,
            'errorMessage': 'Food item $foodItemId not found',
            'errorCode': 'ITEM_NOT_FOUND',
          });
        }

        subtotal += foodItem.foodPrice * quantity;

        orderItemsData.add({
          'foodItemId': foodItemId,
          'quantity': quantity,
          'unitPrice': foodItem.foodPrice,
          'foodItemName': foodItem.foodName,
          'foodItemDescription': foodItem.description,
          'specialInstructions': item['specialInstructions'] as String?,
        });
      }

      // Calculate fees
      final deliveryFee = 2.99;
      final serviceFee = subtotal * 0.10;
      final totalAmount = subtotal + deliveryFee + serviceFee;

      // Create order
      final order = await protocol.Order.db.insertRow(
        session,
        protocol.Order(
          userId: userId,
          restaurantId: restaurantId,
          deliveryAddressId: deliveryAddressId,
          subtotal: subtotal,
          deliveryFee: deliveryFee,
          serviceFee: serviceFee,
          discount: 0.0,
          totalAmount: totalAmount,
          idempotencyKey: idempotencyKey,
          currentStatus: OrderStatus.placed,
          createdAt: DateTime.now(),
          isSplit: false,
          deliveryInstructions: deliveryInstructions,
        ),
      );

      // Create order items
      for (final item in orderItemsData) {
        await OrderItem.db.insertRow(
          session,
          OrderItem(
            orderId: order.id!,
            foodItemId: item['foodItemId'] as int,
            quantity: item['quantity'] as int,
            unitPrice: item['unitPrice'] as double,
            foodItemName: item['foodItemName'] as String,
            foodItemDescription: item['foodItemDescription'] as String?,
            specialInstructions: item['specialInstructions'] as String?,
          ),
        );
      }

      return jsonEncode({
        'success': true,
        'message': 'Order created',
        'orderId': order.id,
        'totalAmount': totalAmount,
      });
    } catch (e) {
      session.log('Error: $e', level: LogLevel.error);
      return jsonEncode({
        'success': false,
        'errorMessage': 'Error: $e',
        'errorCode': 'INTERNAL_ERROR',
      });
    }
  }

  Future<String> getHistory(
    Session session,
    int userId,
    int limit,
    int offset,
  ) async {
    try {
      final orders = await protocol.Order.db.find(
        session,
        where: (t) => t.userId.equals(userId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );

      final ordersData = <Map<String, dynamic>>[];

      for (final order in orders) {
        final restaurant = await Restaurant.db.findById(session, order.restaurantId);

        ordersData.add({
          'id': order.id,
          'restaurantName': restaurant?.restName ?? 'Unknown',
          'status': order.currentStatus.name,
          'totalAmount': order.totalAmount,
          'createdAt': order.createdAt.toIso8601String(),
        });
      }

      return jsonEncode({
        'success': true,
        'orders': ordersData,
        'hasMore': orders.length == limit,
      });
    } catch (e) {
      return jsonEncode({
        'success': false,
        'errorMessage': 'Error: $e',
        'errorCode': 'INTERNAL_ERROR',
      });
    }
  }
}
