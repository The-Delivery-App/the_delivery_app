import 'dart:convert';

import 'package:the_delivery_app_client/the_delivery_app_client.dart';

import '../dtos/feed_portion_dto.dart';
import '../dtos/food_dto.dart';
import '../dtos/price_tier_info_dto.dart';
import '../models/food_filters.dart';
import '../models/location.dart';
import 'i_food_api_service.dart';

class FeedAPIService implements IFoodApiService {
  final Client _client;

  // Items fetched from the last getFeedChunk call, keyed by synthetic string ID.
  final Map<String, _CachedItem> _cache = {};

  FeedAPIService({required Client client}) : _client = client;

  @override
  Future<FeedPortionDTO> fetchFeedPortion({
    required String sessionId,
    required Location location,
    FoodFilter? filter,
  }) async {
    _cache.clear();
    final response = await _client.feedController.getFeedChunk(
      390, 844, 2, 10.0,
      location.latitude, location.longitude,
      100, 0,
      null,
    );
    for (var i = 0; i < response.foodItems.length; i++) {
      _cache[i.toString()] = _CachedItem(response.foodItems[i]);
    }
    return FeedPortionDTO(
      foodIds: List.generate(response.foodItems.length, (i) => i.toString()),
      portionToken: '',
    );
  }

  @override
  Future<List<FoodDTO>> fetchFoodChunk({required List<String> foodIds}) async {
    return foodIds
        .where((id) => _cache.containsKey(id))
        .map((id) => _cache[id]!.toFoodDTO())
        .toList();
  }

  @override
  Future<List<FoodDTO>> search({
    required String query,
    required Location location,
  }) async {
    final raw = await _client.feedController.search(query, 20, null);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    if (decoded['success'] != true) return [];
    final items = decoded['foodItems'] as List<dynamic>? ?? [];
    return items.whereType<Map<String, dynamic>>().map((f) {
      return FoodDTO(
        foodId: (f['id'] as int?)?.toString() ?? '',
        name: (f['name'] as String?) ?? '',
        price: (f['price'] as num? ?? 0).toDouble(),
        rating: (f['rating'] as num? ?? 0).toDouble(),
        tags: const [],
        foodThumbnail: (f['thumbnail'] as String?) ?? '',
        restaurantThumbnail: '',
        restaurantId: (f['restaurantId'] as int?)?.toString() ?? '',
        restaurantName: (f['restaurantName'] as String?) ?? '',
        recentOrders: 0,
        deliveryTimeMinutes: 30,
        unitType: 'pcs',
        size: 1,
        calories: 0,
        isDiscounted: false,
      );
    }).toList();
  }

  @override
  Future<PriceTierInfoDTO> fetchPriceTierInfo({
    required Location location,
  }) async {
    return const PriceTierInfoDTO(q1: 0, median: 0, q3: 0);
  }
}

class _CachedItem {
  final dynamic _item;
  _CachedItem(this._item);

  FoodDTO toFoodDTO() {
    return FoodDTO(
      foodId: _item.id?.toString() ?? '',
      name: _item.name as String,
      price: (_item.price as num).toDouble(),
      rating: (_item.rating as num).toDouble(),
      tags: const [],
      foodThumbnail: (_item.iconUrl as String?) ?? '',
      restaurantThumbnail: (_item.restaurantIconUrl as String?) ?? '',
      restaurantId: '',
      restaurantName: _item.restaurantName as String,
      recentOrders: _item.estimatedOrdersAmount as int,
      deliveryTimeMinutes: (_item.estimatedDeliveryTime as num).round(),
      unitType: 'pcs',
      size: 1,
      calories: 0,
      isDiscounted: false,
    );
  }
}
