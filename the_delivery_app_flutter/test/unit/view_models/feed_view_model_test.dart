import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/models/device_profile.dart';
import 'package:the_delivery_app_flutter/models/food.dart';
import 'package:the_delivery_app_flutter/models/food_filters.dart';
import 'package:the_delivery_app_flutter/models/food_sort_rule.dart';
import 'package:the_delivery_app_flutter/models/food_unit_type.dart';
import 'package:the_delivery_app_flutter/models/location.dart';
import 'package:the_delivery_app_flutter/models/restaurant.dart';
import 'package:the_delivery_app_flutter/repositories/i_feed_repository.dart';
import 'package:the_delivery_app_flutter/view_models/feed_view_model.dart';

class FakeFoodRepository implements IFoodRepository {
  bool throwOnInitialize;
  bool throwOnLoad;
  List<Food> nextChunk;
  bool initializeCalled = false;
  int loadNextChunkCalls = 0;

  FakeFoodRepository({
    this.throwOnInitialize = false,
    this.throwOnLoad = false,
    List<Food>? nextChunk,
  }) : nextChunk = nextChunk ?? const [];

  @override
  Future<void> initializeFeed({
    required Location location,
    required DeviceProfile device,
    FoodFilter? filter,
    FoodSortRule? sortRule,
  }) async {
    initializeCalled = true;
    if (throwOnInitialize) throw Exception('init failed');
  }

  @override
  Future<List<Food>> loadNextChunk() async {
    loadNextChunkCalls += 1;
    if (throwOnLoad) throw Exception('load failed');
    return nextChunk;
  }

  @override
  void clear() {}

  @override
  List<Food> getCurrentFeed() => nextChunk;

  @override
  Future<void> prefetchNextChunk() async {}

  @override
  Future<List<Food>> search({
    required String query,
    required Location location,
  }) async => const [];
}

Food makeFood(String id) => Food(
  id: id,
  name: 'Food $id',
  price: 6.5,
  rating: 4.2,
  tags: const ['test'],
  imageUrl: '',
  restaurantImageUrl: '',
  restaurant: const Restaurant(id: 'r1', name: 'Test Restaurant'),
  recentOrders: 1,
  deliveryTime: const Duration(minutes: 25),
  unitType: FoodUnitType.pcs,
  size: 1,
  calories: 250,
  isDiscounted: false,
);

void main() {
  group('FeedViewModel', () {
    test('TC-031 loadFeed success populates items and stops loading', () async {
      final repo = FakeFoodRepository(
        nextChunk: [makeFood('f1'), makeFood('f2')],
      );
      final vm = FeedViewModel(repository: repo);
      var notifyCount = 0;
      vm.addListener(() => notifyCount++);

      await vm.loadFeed();

      final state = vm.getState();
      expect(repo.initializeCalled, isTrue);
      expect(repo.loadNextChunkCalls, 1);
      expect(state.feedItems, isNotEmpty);
      expect(state.feedItems.length, 2);
      expect(state.isLoading, isFalse);
      expect(state.errorMessage, isNull);
      expect(notifyCount, 2); // start loading + finished
    });

    test('TC-032 loadFeed failure sets error and keeps feed empty', () async {
      final repo = FakeFoodRepository(throwOnInitialize: true);
      final vm = FeedViewModel(repository: repo);
      var notifyCount = 0;
      vm.addListener(() => notifyCount++);

      await vm.loadFeed();

      final state = vm.getState();
      expect(repo.initializeCalled, isTrue);
      expect(repo.loadNextChunkCalls, 0);
      expect(state.feedItems, isEmpty);
      expect(state.isLoading, isFalse);
      expect(state.errorMessage, isNotNull);
      expect(notifyCount, 2); // start loading + failure state
    });
  });
}
