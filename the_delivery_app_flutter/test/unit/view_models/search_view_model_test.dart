import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/models/device_profile.dart';
import 'package:the_delivery_app_flutter/models/food.dart';
import 'package:the_delivery_app_flutter/models/food_filters.dart';
import 'package:the_delivery_app_flutter/models/food_sort_rule.dart';
import 'package:the_delivery_app_flutter/models/food_unit_type.dart';
import 'package:the_delivery_app_flutter/models/location.dart';
import 'package:the_delivery_app_flutter/models/restaurant.dart';
import 'package:the_delivery_app_flutter/repositories/i_feed_repository.dart';
import 'package:the_delivery_app_flutter/view_models/search_view_model.dart';

class FakeSearchRepository implements IFoodRepository {
  int searchCallCount = 0;
  String? lastQuery;
  Location? lastLocation;
  List<Food> searchResults;
  Completer<List<Food>>? searchCompleter;

  FakeSearchRepository({List<Food>? searchResults, this.searchCompleter})
    : searchResults = searchResults ?? const [];

  @override
  Future<List<Food>> search({
    required String query,
    required Location location,
  }) async {
    searchCallCount += 1;
    lastQuery = query;
    lastLocation = location;

    if (searchCompleter != null) {
      return searchCompleter!.future;
    }
    return searchResults;
  }

  @override
  void clear() {}

  @override
  List<Food> getCurrentFeed() => const [];

  @override
  Future<void> initializeFeed({
    required Location location,
    required DeviceProfile device,
    FoodFilter? filter,
    FoodSortRule? sortRule,
  }) async {}

  @override
  Future<List<Food>> loadNextChunk() async => const [];

  @override
  Future<void> prefetchNextChunk() async {}
}

Food makeFood(String id, {String name = 'Pizza Margherita'}) => Food(
  id: id,
  name: name,
  price: 10.0,
  rating: 4.3,
  tags: const ['pizza', 'italian'],
  imageUrl: '',
  restaurantImageUrl: '',
  restaurant: const Restaurant(id: 'r1', name: 'Pizza Place'),
  recentOrders: 5,
  deliveryTime: const Duration(minutes: 20),
  unitType: FoodUnitType.pcs,
  size: 1,
  calories: 500,
  isDiscounted: false,
);

void main() {
  group('SearchViewModel', () {
    test('TC-045 query length 3 triggers backend search', () async {
      final completer = Completer<List<Food>>();
      final repo = FakeSearchRepository(searchCompleter: completer);
      final vm = SearchViewModel(repository: repo);
      vm.loadItems([makeFood('l1')]);

      vm.search('piz');

      final loadingState = vm.getState();
      expect(repo.searchCallCount, 1);
      expect(repo.lastQuery, 'piz');
      expect(loadingState.isLoading, isTrue);

      completer.complete([makeFood('b1', name: 'Pizzeria Special')]);
      await Future<void>.delayed(Duration.zero);

      final finalState = vm.getState();
      expect(finalState.isLoading, isFalse);
      expect(finalState.results, isNotEmpty);
    });

    test('TC-046 query length 2 does not call backend', () {
      final repo = FakeSearchRepository();
      final vm = SearchViewModel(repository: repo);
      vm.loadItems([makeFood('l1')]);

      vm.search('pi');

      final state = vm.getState();
      expect(repo.searchCallCount, 0);
      expect(state.isLoading, isFalse);
      expect(state.results, isNotEmpty);
    });

    test('TC-047 empty query clears results and skips backend', () {
      final repo = FakeSearchRepository();
      final vm = SearchViewModel(repository: repo);
      vm.loadItems([makeFood('l1')]);
      vm.search('piz');

      vm.search('');

      final state = vm.getState();
      expect(state.query, '');
      expect(state.results, isEmpty);
      expect(state.isLoading, isFalse);
      expect(
        repo.searchCallCount,
        1,
      ); // called only by the previous non-empty query
    });
  });
}
