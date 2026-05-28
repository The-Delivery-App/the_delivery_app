import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/view_models/special_deal_view_model.dart';
import 'package:the_delivery_app_flutter/repositories/interfaces/i_special_deal_repository.dart';
import 'package:the_delivery_app_flutter/models/food.dart';
import 'package:the_delivery_app_flutter/models/location.dart';
import 'package:the_delivery_app_flutter/models/restaurant.dart';
import 'package:the_delivery_app_flutter/models/food_unit_type.dart';

class FakeSpecialDealRepository implements ISpecialDealRepository {
  final List<Food> deals;
  final bool throwOnGet;

  FakeSpecialDealRepository({this.deals = const [], this.throwOnGet = false});

  @override
  Future<List<Food>> getSpecialDeals(Location location) async {
    if (throwOnGet) throw Exception('no deals');
    return deals;
  }
}

void main() {
  group('SpecialDealViewModel TC-051..TC-054', () {
    test('loads deals and updates state', () async {
      final resto = const Restaurant(id: 'r1', name: 'Resto');
      final food = Food(
        id: 'd1',
        name: 'Deal Pizza',
        price: 3.0,
        rating: 4.0,
        tags: const [],
        imageUrl: '',
        restaurantImageUrl: '',
        restaurant: resto,
        recentOrders: 0,
        deliveryTime: const Duration(minutes: 10),
        unitType: FoodUnitType.pcs,
        size: 1,
        calories: 50,
        isDiscounted: true,
      );
      final repo = FakeSpecialDealRepository(deals: [food]);
      final vm = SpecialDealViewModel(repository: repo);

      await vm.loadDeals();

      final state = vm.getState();
      expect(state.isLoading, isFalse);
      expect(state.deals, isNotEmpty);
      expect(state.deals.first.name, equals('Deal Pizza'));
      // TC-053: discounted price is mapped into Food.price correctly
      expect(state.deals.first.price, equals(3.0));
    });

    test('handles repository errors gracefully', () async {
      final repo = FakeSpecialDealRepository(throwOnGet: true);
      final vm = SpecialDealViewModel(repository: repo);

      await vm.loadDeals();

      final state = vm.getState();
      expect(state.isLoading, isFalse);
      expect(state.deals, isEmpty);
    });
  });
}
