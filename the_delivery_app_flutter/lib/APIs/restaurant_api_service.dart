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
  Future<List<Food>> loadMenu(String restaurantId, String restaurantName) async {
    final id = int.tryParse(restaurantId);
    if (id == null) return [];

    final raw = await _client.restaurantController.getMenu(id);
    final decoded = jsonDecode(raw);

    List<dynamic> items;
    if (decoded is List) {
      items = decoded;
    } else if (decoded is Map) {
      // Server returns {"success":true, "menu":{"All Items":[...]}}
      final menu = decoded['menu'];
      if (menu is Map && menu.isNotEmpty) {
        items = menu.values.first is List ? menu.values.first as List : [];
      } else {
        final data = decoded['data'] ?? decoded['items'] ?? decoded['foodItems'];
        items = data is List ? data : [];
      }
    } else {
      return [];
    }

    return items.whereType<Map<String, dynamic>>().map((map) {
      final rawImage = (map['foodThumbnail'] as String?) ?? (map['thumbnail'] as String?) ?? '';
      return Food(
        id: (map['id'] as int?)?.toString() ?? '',
        name: (map['foodName'] as String?) ?? (map['name'] as String?) ?? '',
        price: (map['foodPrice'] as num? ?? map['price'] as num? ?? 0).toDouble(),
        rating: (map['foodRating'] as num? ?? map['rating'] as num? ?? 0).toDouble(),
        tags: [],
        imageUrl: _normaliseImagePath(rawImage),
        restaurantImageUrl: '',
        restaurant: app.Restaurant(
          id: (map['restId'] as int? ?? id).toString(),
          name: restaurantName,
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

  static String _normaliseImagePath(String path) {
    if (path.startsWith('http')) return path;
    const prefix = '../the_delivery_app_flutter/';
    if (path.startsWith(prefix)) return path.substring(prefix.length);
    return path;
  }

  @override
  Future<List<app.Restaurant>> getRestaurantList() async {
    final raw = await _client.restaurantController.getFeatured(10);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    if (decoded['success'] != true) return [];
    final list = decoded['restaurants'] as List<dynamic>? ?? [];
    return list.whereType<Map<String, dynamic>>().map((r) {
      return app.Restaurant(
        id: (r['id'] as int?)?.toString() ?? '',
        name: (r['name'] as String?) ?? '',
        latitude: (r['latitude'] as num?)?.toDouble(),
        longitude: (r['longitude'] as num?)?.toDouble(),
      );
    }).toList();
  }
}
