import 'dart:convert';

import 'package:the_delivery_app_client/the_delivery_app_client.dart';

import '../models/food.dart';
import '../models/food_unit_type.dart';
import '../models/restaurant.dart' as app;
import 'i_restaurant_api_service.dart';

class RestaurantAPIService implements IRestaurantAPIService {
  final Client _client;

  RestaurantAPIService({required Client client}) : _client = client;

  @override
  Future<List<Food>> loadMenu(String restaurantId) async {
    final id = int.tryParse(restaurantId);
    if (id == null) return [];

    final raw = await _client.restaurantController.getMenu(id);
    final decoded = jsonDecode(raw);

    List<dynamic> items;
    if (decoded is List) {
      items = decoded;
    } else if (decoded is Map) {
      final data = decoded['data'] ?? decoded['items'] ?? decoded['foodItems'];
      items = data is List ? data : [];
    } else {
      return [];
    }

    return items.whereType<Map<String, dynamic>>().map((map) {
      return Food(
        id: (map['id'] as int?)?.toString() ?? '',
        name: (map['foodName'] as String?) ?? '',
        price: (map['foodPrice'] as num? ?? 0).toDouble(),
        rating: (map['foodRating'] as num? ?? 0).toDouble(),
        tags: [],
        imageUrl: (map['foodThumbnail'] as String?) ?? '',
        restaurantImageUrl: '',
        restaurant: app.Restaurant(
          id: (map['restId'] as int? ?? id).toString(),
          name: '',
        ),
        recentOrders: (map['estimatedOrders'] as int?) ?? 0,
        deliveryTime: const Duration(minutes: 30),
        unitType: FoodUnitType.pcs,
        size: 1,
        calories: (map['nutritionCals'] as int?) ?? 0,
        isDiscounted: false,
      );
    }).toList();
  }

  @override
  Future<List<app.Restaurant>> getRestaurantList() async {
    return [];
  }
}
