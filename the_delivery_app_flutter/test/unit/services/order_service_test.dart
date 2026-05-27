import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/repositories/interfaces/i_order_repository.dart';
import 'package:the_delivery_app_flutter/models/order.dart';
import 'package:the_delivery_app_flutter/models/basket.dart';
import 'package:the_delivery_app_flutter/models/food.dart';
import 'package:the_delivery_app_flutter/models/order_status.dart';
import 'package:the_delivery_app_flutter/models/restaurant.dart';
import 'package:the_delivery_app_flutter/models/food_unit_type.dart';

class FakeOrderRepository implements IOrderRepository {
  Basket? lastPlacedBasket;
  Order? nextOrder;
  OrderStatus? nextStatus;
  bool throwOnPlace = false;

  @override
  Future<Order> placeOrder(Basket basket) async {
    lastPlacedBasket = basket;
    if (throwOnPlace) throw Exception('network');
    return nextOrder ??
        Order(
          orderId: 'fake',
          basket: basket,
          status: OrderStatus.pending,
          placedAt: DateTime.now(),
        );
  }

  @override
  Future<OrderStatus> trackOrder(String orderId) async {
    return nextStatus ?? OrderStatus.pending;
  }
}

class OrderUseCase {
  final IOrderRepository repository;
  OrderUseCase({required this.repository});

  Future<Order> submitOrder(Basket basket) async {
    return await repository.placeOrder(basket);
  }

  Future<OrderStatus> pollStatus(String orderId) async {
    return await repository.trackOrder(orderId);
  }
}

Food makeFood(String id) => Food(
  id: id,
  name: 'Food $id',
  price: 5.0,
  rating: 4.5,
  tags: const [],
  imageUrl: '',
  restaurantImageUrl: '',
  restaurant: const Restaurant(id: 'r', name: 'R'),
  recentOrders: 0,
  deliveryTime: const Duration(minutes: 20),
  unitType: FoodUnitType.pcs,
  size: 1,
  calories: 100,
  isDiscounted: false,
);

void main() {
  group('OrderUseCase with mocked IOrderRepository', () {
    test('TC-008 placeOrder called and result returned', () async {
      final fake = FakeOrderRepository();
      final useCase = OrderUseCase(repository: fake);

      final basket = Basket(items: [makeFood('1')]);
      final expectedOrder = Order(
        orderId: 'order-123',
        basket: basket,
        status: OrderStatus.pending,
        placedAt: DateTime.now(),
      );

      fake.nextOrder = expectedOrder;

      final result = await useCase.submitOrder(basket);

      expect(fake.lastPlacedBasket, equals(basket));
      expect(result.orderId, expectedOrder.orderId);
      expect(result.status, OrderStatus.pending);
    });

    test('TC-009 trackOrder forwards to repository', () async {
      final fake = FakeOrderRepository();
      final useCase = OrderUseCase(repository: fake);

      fake.nextStatus = OrderStatus.delivering;

      final status = await useCase.pollStatus('order-1');

      expect(status, OrderStatus.delivering);
    });

    test('TC-010 repository error is propagated', () async {
      final fake = FakeOrderRepository();
      final useCase = OrderUseCase(repository: fake);

      final emptyBasket = Basket(items: []);
      fake.throwOnPlace = true;

      await expectLater(
        useCase.submitOrder(emptyBasket),
        throwsA(isA<Exception>()),
      );
    });
  });
}
