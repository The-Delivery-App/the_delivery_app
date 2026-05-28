import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/view_models/restaurant_view_model.dart';
import 'package:the_delivery_app_flutter/repositories/interfaces/i_restaurant_repository.dart';
import 'package:the_delivery_app_flutter/models/food.dart';
import 'package:the_delivery_app_flutter/models/restaurant.dart';
import 'package:the_delivery_app_flutter/models/food_unit_type.dart';

class FakeRestaurantRepository implements IRestaurantRepository {
  final List<Food> items;
  final bool throwOnLoad;

  FakeRestaurantRepository({this.items = const [], this.throwOnLoad = false});

  @override
  Future<List<Food>> loadMenu(
    String restaurantId,
    String restaurantName,
  ) async {
    if (throwOnLoad) throw Exception('load failed');
    return items;
  }

  @override
  Future<List<Restaurant>> getRestaurantList() async {
    // Not used in these tests
    return [];
  }
}

void main() {
  group('RestaurantViewModel TC-048..TC-050', () {
    test('loads menu items and updates state', () async {
      final resto = const Restaurant(id: 'r1', name: 'Resto');
      final food = Food(
        id: 'f1',
        name: 'Pizza',
        price: 5.0,
        rating: 4.5,
        tags: const [],
        imageUrl: '',
        restaurantImageUrl: '',
        restaurant: resto,
        recentOrders: 0,
        deliveryTime: const Duration(minutes: 20),
        unitType: FoodUnitType.pcs,
        size: 1,
        calories: 100,
        isDiscounted: false,
      );
      final repo = FakeRestaurantRepository(items: [food]);
      final vm = RestaurantViewModel(repository: repo);

      await vm.loadMenu('r1', 'Resto');

      final state = vm.getState();
      expect(state.isLoading, isFalse);
      expect(state.menuItems, isNotEmpty);
      expect(state.menuItems.first.name, equals('Pizza'));
    });

    test('handles repository errors', () async {
      final repo = FakeRestaurantRepository(throwOnLoad: true);
      final vm = RestaurantViewModel(repository: repo);

      await vm.loadMenu('r1', 'Resto');

      final state = vm.getState();
      expect(state.isLoading, isFalse);
      expect(state.menuItems, isEmpty);
      expect(state.errorMessage, isNotNull);
    });
  });
}
