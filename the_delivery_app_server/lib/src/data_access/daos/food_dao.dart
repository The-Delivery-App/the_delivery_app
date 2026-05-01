import 'package:serverpod/serverpod.dart';
import '../../business/models/food.dart';
import '../../business/models/location.dart';
import '../../business/models/restaurant.dart';
import '../../generated/protocol.dart' as gen;

class FoodDAO {
  final Session _session;

  FoodDAO(this._session);

  Future<List<Food_DTO>> getFoodByMunicipality(
    String municipality, {
    int limit = 200,
    int offset = 0,
    Map<String, dynamic>? filters,
  }) async {
    final places = await gen.RestaurantPlace.db.find(
      _session,
      where: (t) => t.city.equals(municipality),
    );

    if (places.isEmpty) return [];

    final restaurantIds = places.map((p) => p.restId).toSet();

    final items = await gen.FoodItem.db.find(
      _session,
      where: (t) => t.restId.inSet(restaurantIds),
      orderBy: (t) => t.foodRating,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );

    return items.map(_mapModelToFood).toList();
  }

  Future<int> countFoodByMunicipality(String municipality) async {
    final places = await gen.RestaurantPlace.db.find(
      _session,
      where: (t) => t.city.equals(municipality),
    );

    if (places.isEmpty) return 0;

    final restaurantIds = places.map((p) => p.restId).toSet();

    final items = await gen.FoodItem.db.find(
      _session,
      where: (t) => t.restId.inSet(restaurantIds),
    );

    return items.length;
  }

  Future<Map<int, RestaurantInfo>> getRestaurantsByIds(List<int> ids) async {
    final result = <int, RestaurantInfo>{};

    for (final id in ids) {
      final info = await getRestaurantById(id);
      if (info != null) {
        result[id] = info;
      }
    }

    return result;
  }

  Future<List<String>> getAllMunicipalities() async {
    final places = await gen.RestaurantPlace.db.find(_session);
    return places.map((p) => p.city).toSet().toList();
  }

  Future<RestaurantInfo?> getRestaurantById(int restaurantId) async {
    final restaurant = await gen.Restaurant.db.findById(
      _session,
      restaurantId,
    );
    if (restaurant == null) return null;

    final place = await gen.RestaurantPlace.db.findFirstRow(
      _session,
      where: (t) => t.restId.equals(restaurantId),
    );

    return RestaurantInfo(
      restaurantId: restaurant.id!,
      name: restaurant.restName,
      iconUrl: restaurant.logoThumb,
      location: Location(
        latitude: place?.latitude ?? 0.0,
        longitude: place?.longitude ?? 0.0,
      ),
      estimatedDeliverytime: restaurant.estimatedDeliveryTime,
    );
  }

  Future<List<RestaurantInfo>> getRestaurantsByMunicipality(
    String municipality,
  ) async {
    final places = await gen.RestaurantPlace.db.find(
      _session,
      where: (t) => t.city.equals(municipality),
    );

    final restaurantInfos = <RestaurantInfo>[];
    for (final place in places) {
      final rest = await gen.Restaurant.db.findById(_session, place.restId);
      if (rest != null) {
        restaurantInfos.add(
          RestaurantInfo(
            restaurantId: rest.id!,
            name: rest.restName,
            iconUrl: rest.logoThumb,
            location: Location(
              latitude: place.latitude,
              longitude: place.longitude,
            ),
            estimatedDeliverytime: rest.estimatedDeliveryTime,
          ),
        );
      }
    }

    return restaurantInfos;
  }

  Food_DTO _mapModelToFood(gen.FoodItem item) {
    return Food_DTO(
      id: item.id!,
      restaurantId: item.restId,
      name: item.foodName,
      iconUrl: item.foodThumbnail,
      price: item.foodPrice,
      rating: item.foodRating,
      estimatedOrdersAmount: item.estimatedOrders,
      description: item.description,
      nutritionCals: item.nutritionCals,
      createdAt: DateTime.now(),
    );
  }
}
