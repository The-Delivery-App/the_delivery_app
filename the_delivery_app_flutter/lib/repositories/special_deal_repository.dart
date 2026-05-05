import 'dart:convert';

import 'package:the_delivery_app_client/the_delivery_app_client.dart';

import '../models/food.dart';
import '../models/food_unit_type.dart';
import '../models/location.dart';
import '../models/restaurant.dart' as app;
import 'interfaces/i_special_deal_repository.dart';

class SpecialDealRepository implements ISpecialDealRepository {
  final Client _client;

  SpecialDealRepository({required Client client}) : _client = client;

  @override
  Future<List<Food>> getSpecialDeals(Location location) async {
    final raw = await _client.feedController.getSpecialDeals(20, null);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    if (decoded['success'] != true) return [];

    final deals = decoded['deals'] as List<dynamic>? ?? [];
    final foods = <Food>[];

    for (final deal in deals) {
      final restaurantId = (deal['restaurantId'] as int?)?.toString() ?? '';
      final restaurantName = (deal['restaurantName'] as String?) ?? '';
      final items = deal['items'] as List<dynamic>? ?? [];

      for (final item in items) {
        foods.add(Food(
          id: (item['foodId'] as int?)?.toString() ?? '',
          name: (item['foodName'] as String?) ?? '',
          price: (item['discountedPrice'] as num? ?? 0).toDouble(),
          rating: 0,
          tags: const [],
          imageUrl: (item['thumbnail'] as String?) ?? '',
          restaurantImageUrl: '',
          restaurant: app.Restaurant(id: restaurantId, name: restaurantName),
          recentOrders: 0,
          deliveryTime: const Duration(minutes: 30),
          unitType: FoodUnitType.pcs,
          size: 1,
          calories: 0,
          isDiscounted: true,
        ));
      }
    }

    return foods;
  }
}
