import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/models/basket.dart';
import 'package:the_delivery_app_flutter/models/food.dart';
import 'package:the_delivery_app_flutter/models/restaurant.dart';
import 'package:the_delivery_app_flutter/models/food_unit_type.dart';
import 'package:the_delivery_app_flutter/models/order.dart';
import 'package:the_delivery_app_flutter/models/order_status.dart';
import 'package:the_delivery_app_flutter/repositories/interfaces/i_order_repository.dart';

class FakeOrderRepository implements IOrderRepository {
  Basket? lastPlacedBasket;
  Order? nextOrder;
  OrderStatus? nextStatus;
  bool throwOnPlace = false;
  final Map<String, Order> _idempotencyMap = {};
  int _orderCounter = 0;

  @override
  Future<Order> placeOrder(Basket basket) async {
    lastPlacedBasket = basket;
    if (throwOnPlace) throw Exception('network');
    if (basket.items.isEmpty) throw Exception('Basket is empty');
    if (basket.items.any((f) => f.id == 'missing'))
      throw Exception('Food item missing not found');
    if (basket.items.any((f) => f.id == 'badqty'))
      throw Exception('Invalid quantity');

    final key = basket.items.map((f) => f.id).join(',');
    if (_idempotencyMap.containsKey(key)) return _idempotencyMap[key]!;

    final order =
        nextOrder ??
        Order(
          orderId: 'order-${_orderCounter++}',
          basket: basket,
          status: nextStatus ?? OrderStatus.pending,
          placedAt: DateTime.now(),
        );
    _idempotencyMap[key] = order;
    return order;
  }

  @override
  Future<OrderStatus> trackOrder(String orderId) async {
    return nextStatus ?? OrderStatus.pending;
  }
}

Food makeFood(String id, {double price = 5.0}) => Food(
  id: id,
  name: 'Food $id',
  price: price,
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
  group('OrderRepository (fake) unit tests TC-011..TC-028', () {
    test(
      'TC-011 idempotent order: placing same basket twice returns same order id',
      () async {
        final fake = FakeOrderRepository();
        final basket = Basket(items: [makeFood('1')]);

        final o1 = await fake.placeOrder(basket);
        final o2 = await fake.placeOrder(basket);

        expect(o1.orderId, equals(o2.orderId));
      },
    );

    test('TC-012 empty basket validation: placeOrder throws', () async {
      final fake = FakeOrderRepository();
      final empty = Basket(items: []);
      await expectLater(fake.placeOrder(empty), throwsA(isA<Exception>()));
    });

    test(
      'TC-013 missing item validation: placeOrder throws when item not found',
      () async {
        final fake = FakeOrderRepository();
        final bad = Basket(items: [makeFood('missing')]);
        await expectLater(fake.placeOrder(bad), throwsA(isA<Exception>()));
      },
    );

    test(
      'TC-014 invalid quantity: placeOrder throws on bad quantity sentinel',
      () async {
        final fake = FakeOrderRepository();
        final bad = Basket(items: [makeFood('badqty')]);
        await expectLater(fake.placeOrder(bad), throwsA(isA<Exception>()));
      },
    );

    test(
      'TC-023 transient failure then success (retry) for placeOrder',
      () async {
        final fake = FakeOrderRepository();
        final basket = Basket(items: [makeFood('r1')]);

        fake.throwOnPlace = true;
        await expectLater(fake.placeOrder(basket), throwsA(isA<Exception>()));

        fake.throwOnPlace = false;
        final o2 = await fake.placeOrder(basket);
        expect(o2, isA<Order>());
      },
    );

    test('TC-024 order id format contains "order-" prefix', () async {
      final fake = FakeOrderRepository();
      final basket = Basket(items: [makeFood('x')]);
      final o = await fake.placeOrder(basket);
      expect(o.orderId.startsWith('order-'), isTrue);
    });

    test(
      'TC-025 multiple placeOrder calls create new orders for different baskets',
      () async {
        final fake = FakeOrderRepository();
        final b1 = Basket(items: [makeFood('a')]);
        final b2 = Basket(items: [makeFood('b')]);
        final o1 = await fake.placeOrder(b1);
        final o2 = await fake.placeOrder(b2);
        expect(o1.orderId != o2.orderId, isTrue);
      },
    );

    test('TC-027 placeOrder includes basket in returned Order', () async {
      final fake = FakeOrderRepository();
      final basket = Basket(items: [makeFood('z')]);
      final o = await fake.placeOrder(basket);
      expect(o.basket.items.first.id, 'z');
    });

    test(
      'TC-028 placeOrder throws network exception when configured',
      () async {
        final fake = FakeOrderRepository();
        fake.throwOnPlace = true;
        final basket = Basket(items: [makeFood('1')]);
        await expectLater(fake.placeOrder(basket), throwsA(isA<Exception>()));
      },
    );
  });
}
