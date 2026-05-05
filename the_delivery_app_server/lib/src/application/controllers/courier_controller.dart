import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';
import 'dart:convert';

class CourierController extends Endpoint {

  Future<String> assignCourier(Session session, String requestJson) async {
    try {
      final data = jsonDecode(requestJson) as Map<String, dynamic>;
      final orderId = data['orderId'] as int;
      final courierId = data['courierId'] as int;

      final order = await Order.db.findById(session, orderId);
      if (order == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Order not found',
          'errorCode': 'NOT_FOUND',
        });
      }

      final courier = await Courier.db.findById(session, courierId);
      if (courier == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Courier not found',
          'errorCode': 'NOT_FOUND',
        });
      }

      if (order.currentStatus != OrderStatus.confirmed) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Can only assign courier to confirmed orders. '
              'Current status: ${order.currentStatus.name}',
          'errorCode': 'INVALID_STATUS',
        });
      }

      order.courierId = courierId;
      order.currentStatus = OrderStatus.assigned;
      order.updatedAt = DateTime.now();
      await Order.db.updateRow(session, order);

      await OrderStatusHistory.db.insertRow(
        session,
        OrderStatusHistory(
          orderId: orderId,
          status: OrderStatus.assigned,
          time: DateTime.now(),
        ),
      );

      return jsonEncode({
        'success': true,
        'message': 'Courier assigned successfully',
        'orderId': orderId,
        'courierId': courierId,
        'courierName': '${courier.fname} ${courier.lname}',
      });
    } catch (e) {
      session.log('Error in assignCourier: $e', level: LogLevel.error);
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> updateDeliveryStatus(Session session, String requestJson) async {
    try {
      final data = jsonDecode(requestJson) as Map<String, dynamic>;
      final orderId = data['orderId'] as int;
      final newStatusStr = data['newStatus'] as String;

      final order = await Order.db.findById(session, orderId);
      if (order == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Order not found',
          'errorCode': 'NOT_FOUND',
        });
      }

      OrderStatus? newStatus;
      try {
        newStatus = OrderStatus.values.byName(newStatusStr);
      } catch (_) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Invalid status: $newStatusStr. '
              'Valid values: ${OrderStatus.values.map((s) => s.name).join(', ')}',
          'errorCode': 'INVALID_STATUS',
        });
      }

      order.currentStatus = newStatus;
      order.updatedAt = DateTime.now();

      if (newStatus == OrderStatus.delivered) {
        order.actualDeliveryTime = DateTime.now();
      }

      await Order.db.updateRow(session, order);

      await OrderStatusHistory.db.insertRow(
        session,
        OrderStatusHistory(
          orderId: orderId,
          status: newStatus,
          time: DateTime.now(),
        ),
      );

      return jsonEncode({
        'success': true,
        'message': 'Order status updated to ${newStatus.name}',
        'orderId': orderId,
        'newStatus': newStatus.name,
        'actualDeliveryTime': order.actualDeliveryTime?.toIso8601String(),
      });
    } catch (e) {
      session.log('Error in updateDeliveryStatus: $e', level: LogLevel.error);
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> getAvailableCouriers(Session session) async {
    try {
      final couriers = await Courier.db.find(session);

      return jsonEncode({
        'success': true,
        'couriers': couriers.map((c) => {
          'id': c.id,
          'name': '${c.fname} ${c.lname}',
          'phone': c.phone,
          'vehicle': c.carName,
          'plateNumber': c.plateNum,
        }).toList(),
        'total': couriers.length,
      });
    } catch (e) {
      session.log('Error in getAvailableCouriers: $e', level: LogLevel.error);
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }
}