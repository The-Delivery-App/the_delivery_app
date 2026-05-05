import '../../models/basket.dart';
import '../../models/order.dart';
import '../../models/order_status.dart';

abstract class IOrderRepository {
  Future<Order> placeOrder(Basket basket);
  Future<OrderStatus> trackOrder(String orderId);
}
