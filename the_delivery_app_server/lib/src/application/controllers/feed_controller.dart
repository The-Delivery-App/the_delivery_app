import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../../business/services/feed_service.dart';
import '../../business/models/food.dart';
import '../../business/models/location.dart';
import '../../generated/protocol.dart';
import '../../data_access/daos/food_dao.dart';

class FeedController extends Endpoint {

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
}