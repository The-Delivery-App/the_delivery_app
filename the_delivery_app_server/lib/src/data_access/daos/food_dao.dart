import 'package:serverpod/serverpod.dart';
import '../../business/models/food.dart';
import '../../business/models/location.dart';
import '../../business/models/restaurant.dart';

// ignore: uri_does_not_exist
import 'package:the_delivery_app_server/src/generated/food_item.dart'
    as gen_food;
// ignore: uri_does_not_exist
import 'package:the_delivery_app_server/src/generated/restaurant.dart'
    as gen_rest;
// ignore: uri_does_not_exist
import 'package:the_delivery_app_server/src/generated/restaurant_place.dart'
    as gen_place;

/// Data Access Object for food-related database operations.
/// Handles retrieving food items and restaurant information.

class FoodDAO {
  final Session _session;

  FoodDAO(this._session);

  /// Retrieves food items for restaurants located in a given city/municipality.
  /// Applies optional rating and price filters, then returns a paginated slice.
  Future<List<Food_DTO>> getFoodByMunicipality(
    String municipality, {
    int limit = 200,
    int offset = 0,
    Map<String, dynamic>? filters,
  }) async {
    // Step 1 — find all restaurant branches in the requested city.
    final places = await gen_place.RestaurantPlace.db.find(
      _session,
      where: (t) => t.city.equals(municipality),
    );

    if (places.isEmpty) return [];

    final restaurantIds = places.map((p) => p.restId).toSet();

    // Step 2 — fetch food items for those restaurants, applying any filters.
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

  /// Retrieves restaurant information (brand + first branch location) by ID.
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
    if (place == null) return null;

    return _mapModelsToRestaurantInfo(restaurant, place);
  }

  /// Retrieves multiple restaurants by their IDs.
  Future<Map<int, RestaurantInfo>> getRestaurantsByIds(
    List<int> restaurantIds,
  ) async {
    if (restaurantIds.isEmpty) return {};

    final restaurants = await gen_rest.Restaurant.db.find(
      _session,
      where: (t) => t.id.inSet(restaurantIds.toSet()),
    );

    // Fetch all relevant places in one query.
    final places = await gen_place.RestaurantPlace.db.find(
      _session,
      where: (t) => t.restId.inSet(restaurantIds.toSet()),
    );

    // Index the first place per restaurant.
    final placeByRestId = <int, gen_place.RestaurantPlace>{};
    for (final place in places) {
      placeByRestId.putIfAbsent(place.restId, () => place);
    }

    final result = <int, RestaurantInfo>{};
    for (final restaurant in restaurants) {
      final id = restaurant.id;
      if (id == null) continue;
      final place = placeByRestId[id];
      if (place == null) continue;
      result[id] = _mapModelsToRestaurantInfo(restaurant, place);
    }
    return result;
  }

  /// Counts total food items available for restaurants in a municipality.
  Future<int> countFoodByMunicipality(String municipality) async {
    final places = await gen_place.RestaurantPlace.db.find(
      _session,
      where: (t) => t.city.equals(municipality),
    );

    if (places.isEmpty) return 0;

    final restaurantIds = places.map((p) => p.restId).toSet();

    return gen_food.FoodItem.db.count(
      _session,
      where: (t) => t.restId.inSet(restaurantIds),
    );
  }

  /// Retrieves all distinct cities that have at least one restaurant branch.
  Future<List<String>> getAllMunicipalities() async {
    // DISTINCT is not expressible through the ORM, so we use a raw query.
    final result = await _session.db.unsafeQuery(
      'SELECT DISTINCT city FROM restaurant_place'
      ' WHERE city IS NOT NULL ORDER BY city',
    );

    return result.map((row) => row.toColumnMap()['city'] as String).toList();
  }

  // ---------------------------------------------------------------------------
  // Mappers
  // ---------------------------------------------------------------------------

  Food_DTO _mapModelToFood(gen_food.FoodItem item) {
    return Food_DTO(
      id: item.id,
      restaurantId: item.restId,
      name: item.foodName,
      iconUrl: item.foodThumbnail,
      price: item.foodPrice,
      rating: item.foodRating,
      estimatedOrdersAmount: item.estimatedOrders,
      description: item.description,
      nutritionCals: item.nutritionCals,
      createdAt: item.createdAt,
    );
  }

  RestaurantInfo _mapModelsToRestaurantInfo(
    gen_rest.Restaurant restaurant,
    gen_place.RestaurantPlace place,
  ) {
    final location = Location(
      latitude: place.latitude,
      longitude: place.longitude,
      municipality: place.city,
    );

    return RestaurantInfo(
      restaurantId: restaurant.id!,
      name: restaurant.restName,
      iconUrl: restaurant.logoThumb,
      location: location,
      estimatedDeliverytime: restaurant.estimatedDeliveryTime,
      cuisine: _parseCuisine(restaurant.cuisine),
    );
  }

  /// Parses a comma-separated cuisine string from the database.
  List<String>? _parseCuisine(String? cuisineStr) {
    if (cuisineStr == null || cuisineStr.isEmpty) return null;
    return cuisineStr.split(',').map((c) => c.trim()).toList();
  }
}
