cat > lib/src/data_access/daos/food_dao.dart << 'EOF'
import 'package:serverpod/serverpod.dart';
import '../../business/models/food.dart';
import '../../business/models/location.dart';
import '../../business/models/restaurant.dart';

// ignore: uri_does_not_exist
import 'package:the_delivery_app_server/src/generated/food_item.dart' as gen_food;
// ignore: uri_does_not_exist
import 'package:the_delivery_app_server/src/generated/restaurant.dart' as gen_rest;
// ignore: uri_does_not_exist
import 'package:the_delivery_app_server/src/generated/restaurant_place.dart' as gen_place;

class FoodDAO {
  final Session _session;

  FoodDAO(this._session);

  Future<List<Food>> getFoodByMunicipality(
    String municipality, {
    int limit = 200,
    int offset = 0,
    Map<String, dynamic>? filters,
  }) async {
    final places = await gen_place.RestaurantPlace.db.find(
      _session,
      where: (t) => t.city.equals(municipality),
    );

    if (places.isEmpty) return [];

    final restaurantIds = places.map((p) => p.restId).toSet();

    final items = await gen_food.FoodItem.db.find(
      _session,
      where: (t) {
        Expression expr = t.restId.inSet(restaurantIds);

        if (filters?['minRating'] != null) {
          final minRating = (filters!['minRating'] as num).toDouble();
          expr = expr & t.foodRating.greaterOrEquals(minRating);
        }

        if (filters?['maxPrice'] != null) {
          final maxPrice = (filters!['maxPrice'] as num).toDouble();
          expr = expr & t.foodPrice.lessOrEquals(maxPrice);
        }

        return expr;
      },
      orderBy: (t) => t.foodRating,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );

    return items.map(_mapModelToFood).toList();
  }

  Future<RestaurantInfo?> getRestaurantById(int restaurantId) async {
    final restaurant = await gen_rest.Restaurant.db.findById(
      _session,
      restaurantId,
    );
    if (restaurant == null) return null;

    final place = await gen_place.RestaurantPlace.db.findFirstRow(
      _session,
      where: (t) => t.restId.equals(restaurantId),
    );

    return RestaurantInfo(
      id: restaurant.id!,
      name: restaurant.name,
      cuisine: restaurant.cuisine,
      logoUrl: restaurant.logoUrl,
      rating: restaurant.rating,
      latitude: place?.latitude ?? 0.0,
      longitude: place?.longitude ?? 0.0,
    );
  }

  Food _mapModelToFood(gen_food.FoodItem item) {
    return Food(
      id: item.id!,
      restaurantId: item.restId,
      name: item.foodName,
      iconUrl: item.foodThumbnail ?? '',
      price: item.foodPrice,
      rating: item.foodRating,
      estimatedOrdersAmount: item.estimatedOrders,
      description: item.description,
      nutritionCals: item.nutritionCals,
    );
  }
}
EOF