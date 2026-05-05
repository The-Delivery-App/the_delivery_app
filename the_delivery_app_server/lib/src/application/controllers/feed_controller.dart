import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../../business/services/feed_service.dart';
import '../../business/models/food.dart';
import '../../business/models/location.dart';
import '../../generated/protocol.dart';
import '../../data_access/daos/food_dao.dart';

class FeedControllerEndpoint extends Endpoint {

  Future<FeedChunkResponse> getFeedChunk(
    Session session,
    int screenWidth,
    int screenHeight,
    int dpi,
    double dataTransferRate,
    double userLatitude,
    double userLongitude,
    int chunkSize,
    int chunkOffset,
    Map<String, dynamic>? filters,
  ) async {
    try {
      if (chunkSize <= 0 || chunkSize > 500) {
        return FeedChunkResponse(
          success: false,
          foodItems: [],
          restaurants: [],
          totalItemsAvailable: 0,
          fetchedCount: 0,
          errorMessage: 'Invalid chunk size',
          errorCode: 'INVALID_CHUNK_SIZE',
        );
      }

      final feedService = FeedService(foodDAO: FoodDAO(session));
      final userLocation = Location(latitude: userLatitude, longitude: userLongitude);
      
      final feedRequest = FeedRequest(
        userLocation: userLocation,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        dpi: dpi,
        dataTransferRate: dataTransferRate,
        chunkSize: chunkSize,
      );

      final response = await feedService.getFeedChunk(feedRequest, chunkOffset);

      final foodItems = response.foodItems.map((item) {
        return FoodItemResponse(
          id: item.food.id,
          name: item.food.name,
          iconUrl: item.food.iconUrl,
          price: item.food.price,
          rating: item.food.rating,
          estimatedOrdersAmount: item.food.estimatedOrdersAmount,
          estimatedDeliveryTime: item.restaurant.estimatedDeliverytime,
          distanceKm: item.distanceToRestaurant,
          restaurantName: item.restaurant.name,
          restaurantIconUrl: item.restaurant.iconUrl,
        );
      }).toList();

      return FeedChunkResponse(
        success: response.success,
        foodItems: foodItems,
        restaurants: response.restaurants.map((r) {
          return RestaurantResponse(
            id: r.restaurantId,
            name: r.name,
            iconUrl: r.iconUrl,
            estimatedDeliveryTime: r.estimatedDeliverytime,
            cuisine: r.cuisine,
          );
        }).toList(),
        totalItemsAvailable: response.totalItemsAvailable,
        fetchedCount: response.fetchedCount,
        errorMessage: response.errorMessage,
      );
    } catch (e) {
      session.log('Error in getFeedChunk: $e', level: LogLevel.error);
      return FeedChunkResponse(
        success: false,
        foodItems: [],
        restaurants: [],
        totalItemsAvailable: 0,
        fetchedCount: 0,
        errorMessage: 'Error: $e',
        errorCode: 'INTERNAL_ERROR',
      );
    }
  }

  Future<String> getSpecialDeals(
    Session session,
    int limit,
    String? city,
  ) async {
    try {
      if (limit <= 0 || limit > 100) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Limit must be between 1 and 100',
          'errorCode': 'INVALID_LIMIT',
        });
      }

      List<SpecialDeals> deals;

      if (city != null && city.isNotEmpty) {
        final places = await RestaurantPlace.db.find(
          session,
          where: (t) => t.city.ilike('%$city%'),
        );

        if (places.isEmpty) {
          return jsonEncode({'success': true, 'deals': [], 'total': 0});
        }

        final placeIds = places.map((p) => p.id!).toSet();
        deals = await SpecialDeals.db.find(
          session,
          where: (t) => t.placeId.inSet(placeIds),
          limit: limit,
        );
      } else {
        deals = await SpecialDeals.db.find(session, limit: limit);
      }

      final dealsData = <Map<String, dynamic>>[];
      for (final deal in deals) {
        final place = await RestaurantPlace.db.findById(session, deal.placeId);
        final restaurant = place != null
            ? await Restaurant.db.findById(session, place.restId)
            : null;

        final foodDeals = await FoodDeal.db.find(
          session,
          where: (t) => t.specialDealId.equals(deal.id!),
        );

        final dealItems = <Map<String, dynamic>>[];
        for (final fd in foodDeals) {
          final food = await FoodItem.db.findById(session, fd.foodId);
          if (food != null) {
            dealItems.add({
              'foodId': food.id,
              'foodName': food.foodName,
              'originalPrice': food.foodPrice,
              'discountedPrice': (food.foodPrice - deal.discountAmount).clamp(0.0, double.infinity),
              'quantity': fd.itemQty,
              'thumbnail': food.foodThumbnail,
            });
          }
        }

        dealsData.add({
          'id': deal.id,
          'description': deal.description,
          'discountAmount': deal.discountAmount,
          'thumbnail': deal.thumbnail,
          'restaurantId': restaurant?.id,
          'restaurantName': restaurant?.restName,
          'city': place?.city,
          'items': dealItems,
        });
      }

      return jsonEncode({
        'success': true,
        'deals': dealsData,
        'total': dealsData.length,
      });
    } catch (e) {
      session.log('Error in getSpecialDeals: $e', level: LogLevel.error);
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> search(
    Session session,
    String query,
    int limit,
    String? city,
  ) async {
    try {
      if (query.trim().isEmpty) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Search query cannot be empty',
          'errorCode': 'EMPTY_QUERY',
        });
      }

      if (limit <= 0 || limit > 50) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Limit must be between 1 and 50',
          'errorCode': 'INVALID_LIMIT',
        });
      }

      final term = query.trim();

      final restaurantResults = await Restaurant.db.find(
        session,
        where: (t) => t.restName.ilike('%$term%') | t.cuisine.ilike('%$term%'),
        limit: limit,
      );

      final foodResults = await FoodItem.db.find(
        session,
        where: (t) => t.foodName.ilike('%$term%') | t.description.ilike('%$term%'),
        limit: limit,
      );

      final restaurantData = <Map<String, dynamic>>[];
      for (final r in restaurantResults) {
        final place = await RestaurantPlace.db.findFirstRow(
          session,
          where: (t) => t.restId.equals(r.id!),
        );
        if (city != null && city.isNotEmpty) {
          if (place == null || !place.city.toLowerCase().contains(city.toLowerCase())) {
            continue;
          }
        }
        restaurantData.add({
          'id': r.id,
          'name': r.restName,
          'cuisine': r.cuisine,
          'logoUrl': r.logoThumb,
          'estimatedDeliveryTime': r.estimatedDeliveryTime,
          'city': place?.city,
        });
      }

      final foodData = <Map<String, dynamic>>[];
      for (final f in foodResults) {
        final restaurant = await Restaurant.db.findById(session, f.restId);
        foodData.add({
          'id': f.id,
          'name': f.foodName,
          'description': f.description,
          'price': f.foodPrice,
          'rating': f.foodRating,
          'thumbnail': f.foodThumbnail,
          'restaurantId': f.restId,
          'restaurantName': restaurant?.restName ?? 'Unknown',
        });
      }

      return jsonEncode({
        'success': true,
        'query': query,
        'restaurants': restaurantData,
        'foodItems': foodData,
        'totalRestaurants': restaurantData.length,
        'totalFoodItems': foodData.length,
      });
    } catch (e) {
      session.log('Error in search: $e', level: LogLevel.error);
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }
}