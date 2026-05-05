import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart' hide Order;
import '../../generated/protocol.dart' as protocol;
import '../../business/services/order_service.dart';
import '../../business/models/order_models.dart';
import 'dart:convert';

class OrderControllerEndpoint extends Endpoint {

  Future<String> hello(Session session) async {
    return 'Order controller working';
  }

  Future<String> getOrder(Session session, int orderId) async {
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
      final address = await Address.db.findById(session, order.deliveryAddressId);

      return jsonEncode({
        'success': true,
        'order': {
          'id': order.id,
          'status': order.currentStatus.name,
          'subtotal': order.subtotal,
          'deliveryFee': order.deliveryFee,
          'serviceFee': order.serviceFee,
          'discount': order.discount,
          'totalAmount': order.totalAmount,
          'isSplit': order.isSplit,
          'deliveryInstructions': order.deliveryInstructions,
          'estimatedDeliveryTime': order.estimatedDeliveryTime?.toIso8601String(),
          'actualDeliveryTime': order.actualDeliveryTime?.toIso8601String(),
          'createdAt': order.createdAt.toIso8601String(),
          'restaurant': restaurant != null ? {
            'id': restaurant.id,
            'name': restaurant.restName,
            'logoUrl': restaurant.logoThumb,
          } : null,
          'deliveryAddress': address != null ? {
            'id': address.id,
            'addressLine1': address.addressLine1,
            'addressLine2': address.addressLine2,
            'city': address.city,
            'postcode': address.postcode,
          } : null,
          'items': items.map((i) => {
            'name': i.foodItemName,
            'description': i.foodItemDescription,
            'quantity': i.quantity,
            'unitPrice': i.unitPrice,
            'lineTotal': i.unitPrice * i.quantity,
            'specialInstructions': i.specialInstructions,
          }).toList(),
        },
      });
    } catch (e) {
      session.log('Error in getOrder: $e', level: LogLevel.error);
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> getOrderDetails(Session session, String requestJson) async {
    try {
      final data = jsonDecode(requestJson) as Map<String, dynamic>;
      final orderId = data['orderId'] as int;
      final userId = data['userId'] as int;

      final service = OrderService(session);
      final details = await service.getOrderDetails(orderId, userId);

      if (details == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Order not found or access denied',
          'errorCode': 'NOT_FOUND',
        });
      }

      return jsonEncode({
        'success': true,
        'order': {
          'id': details.order.id,
          'status': details.order.currentStatus.name,
          'subtotal': details.order.subtotal,
          'deliveryFee': details.order.deliveryFee,
          'serviceFee': details.order.serviceFee,
          'discount': details.order.discount,
          'totalAmount': details.order.totalAmount,
          'isSplit': details.order.isSplit,
          'estimatedDeliveryTime': details.order.estimatedDeliveryTime?.toIso8601String(),
          'actualDeliveryTime': details.order.actualDeliveryTime?.toIso8601String(),
          'createdAt': details.order.createdAt.toIso8601String(),
        },
        'items': details.items.map((i) => {
          'name': i.foodItemName,
          'quantity': i.quantity,
          'unitPrice': i.unitPrice,
          'lineTotal': i.unitPrice * i.quantity,
          'specialInstructions': i.specialInstructions,
        }).toList(),
        'statusHistory': details.statusHistory.map((h) => {
          'status': h.status.name,
          'time': h.time.toIso8601String(),
        }).toList(),
        'payment': details.payment != null ? {
          'id': details.payment!.id,
          'amount': details.payment!.amount,
          'currency': details.payment!.currency,
          'paymentMethod': details.payment!.paymentMethod,
          'status': details.payment!.status,
          'transactionId': details.payment!.transactionId,
          'processedAt': details.payment!.processedAt?.toIso8601String(),
        } : null,
        'splitParticipants': details.splitParticipants?.map((p) => {
          'userId': p.userId,
          'amountDue': p.amountDue,
          'hasPaid': p.hasPaid,
          'paidAt': p.paidAt?.toIso8601String(),
        }).toList(),
      });
    } catch (e) {
      session.log('Error in getOrderDetails: $e', level: LogLevel.error);
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> createOrder(Session session, String requestJson) async {
    try {
      final data = jsonDecode(requestJson) as Map<String, dynamic>;

      final userId = data['userId'] as int?;
      final restaurantId = data['restaurantId'] as int?;
      final deliveryAddressId = data['deliveryAddressId'] as int?;
      final idempotencyKey = data['idempotencyKey'] as String?;
      final items = data['items'] as List<dynamic>?;

      if (userId == null || restaurantId == null || deliveryAddressId == null ||
          idempotencyKey == null || items == null || items.isEmpty) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Missing required fields: userId, restaurantId, '
              'deliveryAddressId, idempotencyKey, items',
          'errorCode': 'INVALID_REQUEST',
        });
      }

      final basketItems = items.map((item) {
        return BasketItemInput(
          foodItemId: item['foodItemId'] as int,
          quantity: item['quantity'] as int,
          specialInstructions: item['specialInstructions'] as String?,
        );
      }).toList();

      final splitParticipantIds = (data['splitParticipantIds'] as List<dynamic>?)
          ?.map((id) => id as int)
          .toList();

      final service = OrderService(session);
      final result = await service.createOrder(
        userId: userId,
        idempotencyKey: idempotencyKey,
        basketItems: basketItems,
        restaurantId: restaurantId,
        deliveryAddressId: deliveryAddressId,
        couponCode: data['couponCode'] as String?,
        isSplit: data['isSplit'] as bool? ?? false,
        splitParticipantIds: splitParticipantIds,
        deliveryInstructions: data['deliveryInstructions'] as String?,
      );

      if (!result.success) {
        return jsonEncode({
          'success': false,
          'errorMessage': result.errorMessage,
          'errorCode': 'ORDER_FAILED',
        });
      }

      return jsonEncode({
        'success': true,
        'message': 'Order created successfully',
        'orderId': result.order!.id,
        'totalAmount': result.order!.totalAmount,
        'estimatedDeliveryTime': result.order!.estimatedDeliveryTime?.toIso8601String(),
      });
    } catch (e) {
      session.log('Error in createOrder: $e', level: LogLevel.error);
      return jsonEncode({
        'success': false,
        'errorMessage': 'Internal server error',
        'errorCode': 'INTERNAL_ERROR',
      });
    }
  }

  Future<String> processPayment(Session session, String requestJson) async {
    try {
      final data = jsonDecode(requestJson) as Map<String, dynamic>;
      final orderId = data['orderId'] as int?;
      final userId = data['userId'] as int?;
      final paymentToken = data['paymentToken'] as String?;
      final paymentMethod = data['paymentMethod'] as String? ?? 'card';

      if (orderId == null || userId == null || paymentToken == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Missing required fields: orderId, userId, paymentToken',
          'errorCode': 'INVALID_REQUEST',
        });
      }

      final service = OrderService(session);
      final result = await service.processPayment(
        orderId: orderId,
        userId: userId,
        paymentToken: paymentToken,
        paymentMethod: paymentMethod,
      );

      if (!result.success) {
        return jsonEncode({
          'success': false,
          'errorMessage': result.errorMessage,
          'errorCode': 'PAYMENT_FAILED',
        });
      }

      return jsonEncode({
        'success': true,
        'message': 'Payment successful',
        'transactionId': result.transactionId,
        'amountCharged': result.amount,
      });
    } catch (e) {
      session.log('Error in processPayment: $e', level: LogLevel.error);
      return jsonEncode({
        'success': false,
        'errorMessage': 'Payment processing error',
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
      if (limit <= 0 || limit > 100) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Limit must be between 1 and 100',
          'errorCode': 'INVALID_LIMIT',
        });
      }

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
        final firstItem = await OrderItem.db.findFirstRow(
          session,
          where: (t) => t.orderId.equals(order.id!),
        );

        ordersData.add({
          'id': order.id,
          'restaurantName': restaurant?.restName ?? 'Unknown Restaurant',
          'restaurantLogo': restaurant?.logoThumb,
          'status': order.currentStatus.name,
          'totalAmount': order.totalAmount,
          'previewItem': firstItem?.foodItemName,
          'createdAt': order.createdAt.toIso8601String(),
          'estimatedDeliveryTime': order.estimatedDeliveryTime?.toIso8601String(),
        });
      }

      return jsonEncode({
        'success': true,
        'orders': ordersData,
        'hasMore': orders.length == limit,
        'total': ordersData.length,
      });
    } catch (e) {
      session.log('Error in getHistory: $e', level: LogLevel.error);
      return jsonEncode({
        'success': false,
        'errorMessage': 'Error fetching order history',
        'errorCode': 'INTERNAL_ERROR',
      });
    }
  }

  Future<String> getTrackingInfo(Session session, String requestJson) async {
    try {
      final data = jsonDecode(requestJson) as Map<String, dynamic>;
      final orderId = data['orderId'] as int?;
      final userId = data['userId'] as int?;

      if (orderId == null || userId == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Missing orderId or userId',
          'errorCode': 'INVALID_REQUEST',
        });
      }

      final service = OrderService(session);
      final tracking = await service.getCourierTracking(orderId, userId);

      if (tracking == null) {
        return jsonEncode({
          'success': true,
          'tracking': null,
          'message': 'No courier assigned yet',
        });
      }

      return jsonEncode({
        'success': true,
        'tracking': tracking.toJson(),
      });
    } catch (e) {
      session.log('Error in getTrackingInfo: $e', level: LogLevel.error);
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> updateCourierLocation(Session session, String requestJson) async {
    try {
      final data = jsonDecode(requestJson) as Map<String, dynamic>;
      final orderId = data['orderId'] as int;
      final latitude = (data['latitude'] as num).toDouble();
      final longitude = (data['longitude'] as num).toDouble();

      if (latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Invalid coordinates',
          'errorCode': 'INVALID_COORDINATES',
        });
      }

      final service = OrderService(session);
      final updated = await service.updateCourierLocation(orderId, latitude, longitude);

      return jsonEncode({
        'success': updated,
        'message': updated ? 'Location updated' : 'Order not found',
      });
    } catch (e) {
      session.log('Error in updateCourierLocation: $e', level: LogLevel.error);
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }
}