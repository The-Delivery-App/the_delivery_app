import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/view_models/basket_view_model.dart';
import 'package:the_delivery_app_flutter/models/food.dart';
import 'package:the_delivery_app_flutter/models/restaurant.dart';
import 'package:the_delivery_app_flutter/models/food_unit_type.dart';
import 'package:the_delivery_app_flutter/models/basket.dart';
import 'package:the_delivery_app_flutter/repositories/interfaces/i_basket_repository.dart';
import 'package:the_delivery_app_flutter/screens/basket_view.dart';

class FakeBasketRepository implements IBasketRepository {
  Basket basket;
  Basket? lastUpdatedBasket;
  bool throwOnGet;

  FakeBasketRepository({Basket? basket, this.throwOnGet = false})
    : basket = basket ?? const Basket(items: []);

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
  isDiscounted: false,
);

void main() {
  group('BasketViewModel', () {
    test('TC-001 addItem adds item, notifies, and updates repository', () {
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

    test('TC-002 addItem — null food rejects null at runtime', () {
      final repo = FakeBasketRepository();
      final vm = BasketViewModel(repository: repo);

      // Dart null-safety prevents null Food at compile-time; dynamic simulates a bad caller.
      expect(() => (vm as dynamic).addItem(null), throwsA(isA<TypeError>()));
      expect(vm.getState().basket.items, isEmpty);
      expect(repo.lastUpdatedBasket, isNull);
    });

    test(
      'TC-003 removeItem removes item if present and updates repo',
      () async {
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
      },
    );

    test(
      'TC-004 removeItem on non-existent item leaves basket unchanged',
      () async {
        final f1 = makeFood('f1');
        final repo = FakeBasketRepository(basket: Basket(items: []));
        final vm = BasketViewModel(repository: repo);
        await vm.loadBasket();

        expect(() => vm.removeItem(f1), returnsNormally);

        final state = vm.getState();
        expect(state.basket.items, isEmpty);
        expect(repo.lastUpdatedBasket, isNotNull);
      },
    );

    test('TC-005 clearBasket empties basket and updates repo', () async {
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

    test(
      'loadBasket sets state from repository and notifies (additional)',
      () async {
        final f1 = makeFood('f1');
        final repo = FakeBasketRepository(basket: Basket(items: [f1]));
        final vm = BasketViewModel(repository: repo);
        var notified = 0;
        vm.addListener(() => notified++);

        await vm.loadBasket();

        final state = vm.getState();
        expect(state.basket.items.length, 1);
        expect(notified, 1);
      },
    );

    test(
      'TC-006 loadBasket handles repository error and returns empty basket',
      () async {
        final repo = FakeBasketRepository(throwOnGet: true);
        final vm = BasketViewModel(repository: repo);
        var notified = 0;
        vm.addListener(() => notified++);

        await vm.loadBasket();

        final state = vm.getState();
        expect(state.basket.items, isEmpty);
        expect(notified, 1);
      },
    );

    testWidgets(
      'TC-007 View basket shows price breakdown and multi-restaurant banner',
      (WidgetTester tester) async {
        // Two items from different restaurants to trigger multi-restaurant banner
        final f1 = makeFood(
          'f1',
        );
        final f2 = makeFood(
          'f2',
        );
        // adjust restaurants on the food objects so they are different
        final f1r = Food(
          id: f1.id,
          name: f1.name,
          price: f1.price,
          rating: f1.rating,
          tags: f1.tags,
          imageUrl: f1.imageUrl,
          restaurantImageUrl: f1.restaurantImageUrl,
          restaurant: Restaurant(id: 'r1', name: 'R1'),
          recentOrders: f1.recentOrders,
          deliveryTime: f1.deliveryTime,
          unitType: f1.unitType,
          size: f1.size,
          calories: f1.calories,
          isDiscounted: f1.isDiscounted,
        );
        final f2r = Food(
          id: f2.id,
          name: f2.name,
          price: f2.price,
          rating: f2.rating,
          tags: f2.tags,
          imageUrl: f2.imageUrl,
          restaurantImageUrl: f2.restaurantImageUrl,
          restaurant: Restaurant(id: 'r2', name: 'R2'),
          recentOrders: f2.recentOrders,
          deliveryTime: f2.deliveryTime,
          unitType: f2.unitType,
          size: f2.size,
          calories: f2.calories,
          isDiscounted: f2.isDiscounted,
        );

        final repo = FakeBasketRepository(basket: Basket(items: [f1r, f2r]));
        final vm = BasketViewModel(repository: repo);

        // ensure the view model loads the repository data before rendering
        await vm.loadBasket();

        await tester.pumpWidget(MaterialApp(home: BasketView(viewModel: vm)));
        await tester.pumpAndSettle();

        // Price breakdown header and rows
        expect(find.text('Price Breakdown'), findsOneWidget);
        expect(find.text('Subtotal'), findsOneWidget);
        expect(find.text('Delivery fee'), findsOneWidget);
        expect(find.text('Service fee'), findsOneWidget);
        expect(find.text('Total'), findsOneWidget);

        // Multi-restaurant banner text
        expect(
          find.text('Items from multiple restaurants — all in one order!'),
          findsOneWidget,
        );
      },
    );
  });
}
