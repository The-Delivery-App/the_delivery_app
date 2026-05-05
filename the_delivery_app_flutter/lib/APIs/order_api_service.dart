import '../models/basket.dart';
import '../models/order.dart';
import '../models/order_status.dart';
import 'i_order_api_service.dart';

class OrderAPIService implements IOrderAPIService {
  @override
  Future<Order> placeOrder(Basket basket) async {
    // No backend connected yet — returns a mock pending order.
    return Order(
      orderId: 'order-1',
      basket: basket,
      status: OrderStatus.pending,
      placedAt: DateTime.now(),
    );
  }

  @override
  Future<OrderStatus> trackOrder(String orderId) async {
    // No backend connected yet — always returns pending.
    return OrderStatus.pending;
  }
}
