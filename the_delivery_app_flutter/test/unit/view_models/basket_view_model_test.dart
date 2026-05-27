import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/view_models/basket_view_model.dart';
import 'package:the_delivery_app_flutter/models/food.dart';
import 'package:the_delivery_app_flutter/models/restaurant.dart';
import 'package:the_delivery_app_flutter/models/food_unit_type.dart';
import 'package:the_delivery_app_flutter/models/basket.dart';
import 'package:the_delivery_app_flutter/repositories/interfaces/i_basket_repository.dart';

class FakeBasketRepository implements IBasketRepository {
  Basket basket;
  Basket? lastUpdatedBasket;
  bool throwOnGet;

  FakeBasketRepository({Basket? basket, this.throwOnGet = false}) : basket = basket ?? const Basket(items: []);

  @override
  Future<Basket> getBasket() async {
    if (throwOnGet) throw Exception('malformed');
    return basket;
  }

  @override
  Future<void> updateBasket(Basket basket) async {
    lastUpdatedBasket = basket;
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
    isDiscounted: false);

void main() {
  group('BasketViewModel', () {
    test('addItem adds item, notifies, and updates repository', () {
      final repo = FakeBasketRepository();
      final vm = BasketViewModel(repository: repo);
      var notified = 0;
      vm.addListener(() => notified++);

      final f = makeFood('f1');
      vm.addItem(f);

      final state = vm.getState();
      expect(state.basket.items.length, 1);
      expect(state.basket.items.first.id, 'f1');
      expect(notified, 1);
      expect(repo.lastUpdatedBasket, isNotNull);
      expect(repo.lastUpdatedBasket!.items.length, 1);
    });

    test('removeItem removes item if present and updates repo', () async {
      final f1 = makeFood('f1');
      final f2 = makeFood('f2');
      final repo = FakeBasketRepository(basket: Basket(items: [f1, f2]));
      final vm = BasketViewModel(repository: repo);
      var notified = 0;
      vm.addListener(() => notified++);

      await vm.loadBasket();
      vm.removeItem(f1);

      final state = vm.getState();
      expect(state.basket.items.length, 1);
      expect(state.basket.items.first.id, 'f2');
      expect(notified, 2); // one for load, one for remove
      expect(repo.lastUpdatedBasket, isNotNull);
      expect(repo.lastUpdatedBasket!.items.length, 1);
    });

    test('removeItem on non-existent item leaves basket unchanged', () async {
      final f1 = makeFood('f1');
      final repo = FakeBasketRepository(basket: Basket(items: []));
      final vm = BasketViewModel(repository: repo);
      await vm.loadBasket();
      vm.removeItem(f1);
      final state = vm.getState();
      expect(state.basket.items, isEmpty);
      expect(repo.lastUpdatedBasket, isNotNull);
    });

    test('clearBasket empties basket and updates repo', () async {
      final f1 = makeFood('f1');
      final repo = FakeBasketRepository(basket: Basket(items: [f1]));
      final vm = BasketViewModel(repository: repo);
      var notified = 0;
      vm.addListener(() => notified++);

      await vm.loadBasket();
      vm.clearBasket();

      final state = vm.getState();
      expect(state.basket.items, isEmpty);
      expect(notified, 2); // load + clear
      expect(repo.lastUpdatedBasket, isNotNull);
      expect(repo.lastUpdatedBasket!.items, isEmpty);
    });

    test('loadBasket sets state from repository and notifies', () async {
      final f1 = makeFood('f1');
      final repo = FakeBasketRepository(basket: Basket(items: [f1]));
      final vm = BasketViewModel(repository: repo);
      var notified = 0;
      vm.addListener(() => notified++);

      await vm.loadBasket();

      final state = vm.getState();
      expect(state.basket.items.length, 1);
      expect(notified, 1);
    });

    test('loadBasket handles repository error and returns empty basket', () async {
      final repo = FakeBasketRepository(throwOnGet: true);
      final vm = BasketViewModel(repository: repo);
      var notified = 0;
      vm.addListener(() => notified++);

      await vm.loadBasket();

      final state = vm.getState();
      expect(state.basket.items, isEmpty);
      expect(notified, 1);
    });
  });
}
