import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/repositories/food_repository.dart';
import 'package:the_delivery_app_flutter/APIs/i_food_api_service.dart';
import 'package:the_delivery_app_flutter/dtos/feed_portion_dto.dart';
import 'package:the_delivery_app_flutter/dtos/price_tier_info_dto.dart';
import 'package:the_delivery_app_flutter/dtos/food_dto.dart';
import 'package:the_delivery_app_flutter/models/device_profile.dart';
import 'package:the_delivery_app_flutter/models/location.dart';

class FakeApiService implements IFoodApiService {
  final List<String> ids;

  FakeApiService(this.ids);

  @override
  Future<FeedPortionDTO> fetchFeedPortion({
    required String sessionId,
    required location,
    filter,
  }) async {
    return FeedPortionDTO(foodIds: ids, portionToken: 't');
  }

  @override
  Future<List<FoodDTO>> fetchFoodChunk({required List<String> foodIds}) async {
    return foodIds
        .map(
          (id) => FoodDTO(
            foodId: id,
            name: 'Food $id',
            price: 1.0,
            rating: 4.0,
            tags: const [],
            foodThumbnail: '',
            restaurantThumbnail: '',
            restaurantId: 'r',
            restaurantName: 'R',
            recentOrders: 0,
            deliveryTimeMinutes: 20,
            unitType: 'pcs',
            size: 1,
            calories: 100,
            isDiscounted: false,
          ),
        )
        .toList();
  }

  @override
  Future<List<FoodDTO>> search({
    required String query,
    required location,
  }) async => const [];

  @override
  Future<PriceTierInfoDTO> fetchPriceTierInfo({required location}) async =>
      throw UnimplementedError();
}

void main() {
  group('FoodRepository chunk size', () {
    List<String> makeIds(int n) => List.generate(n, (i) => 'id$i');

    test('TC-036 chunk size high bandwidth 10 Mbps => 40', () async {
      final ids = makeIds(100);
      final api = FakeApiService(ids);
      final repo = FoodRepository(apiService: api, sessionId: 's');

      await repo.initializeFeed(
        location: Location(0, 0),
        device: DeviceProfile(
          screenResolutionX: 100,
          screenResolutionY: 200,
          dpi: 1.0,
          dataTransferRateMbps: 10.0,
        ),
      );
      final chunk = await repo.loadNextChunk();
      expect(chunk.length, 40);
    });

    test('TC-037 chunk size mid bandwidth 5 Mbps => 30', () async {
      final ids = makeIds(100);
      final api = FakeApiService(ids);
      final repo = FoodRepository(apiService: api, sessionId: 's');

      await repo.initializeFeed(
        location: Location(0, 0),
        device: DeviceProfile(
          screenResolutionX: 100,
          screenResolutionY: 200,
          dpi: 1.0,
          dataTransferRateMbps: 5.0,
        ),
      );
      final chunk = await repo.loadNextChunk();
      expect(chunk.length, 30);
    });

    test('TC-038 chunk size low bandwidth 4.9 Mbps => 20', () async {
      final ids = makeIds(100);
      final api = FakeApiService(ids);
      final repo = FoodRepository(apiService: api, sessionId: 's');

      await repo.initializeFeed(
        location: Location(0, 0),
        device: DeviceProfile(
          screenResolutionX: 100,
          screenResolutionY: 200,
          dpi: 1.0,
          dataTransferRateMbps: 4.9,
        ),
      );
      final chunk = await repo.loadNextChunk();
      expect(chunk.length, 20);
    });
  });
}
