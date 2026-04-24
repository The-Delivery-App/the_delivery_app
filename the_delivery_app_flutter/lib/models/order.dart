import 'basket.dart';
import 'order_status.dart';

class Order {
  final String orderId;
  final Basket basket;
  final OrderStatus status;
  final DateTime placedAt;

  const Order({
    required this.orderId,
    required this.basket,
    required this.status,
    required this.placedAt,
  });
}
