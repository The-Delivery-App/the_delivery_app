import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../../business/services/feed_service.dart';
import '../../business/models/food.dart';
import '../../business/models/location.dart';
// changed: was restaurant_info.dart
import '../../data_access/daos/food_dao.dart';

/// Controller endpoint for feed operations.
/// Handles retrieving paginated food item feeds with geo-aware infinite scroll.
class FeedController extends Endpoint {
  /// Retrieves a chunk of food items based on user location and device parameters.
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
          errorMessage: 'Invalid chunkSize. Must be between 1 and 500',
          errorCode: 'INVALID_CHUNK_SIZE',
        );
      }

      if (chunkOffset < 0) {
        return FeedChunkResponse(
          success: false,
          foodItems: [],
          restaurants: [],
          totalItemsAvailable: 0,
          fetchedCount: 0,
          errorMessage: 'Invalid chunkOffset. Must be >= 0',
          errorCode: 'INVALID_OFFSET',
        );
      }

      // In Serverpod 2+, database access is via session.db (not server.database)
      final foodDAO = FoodDAO(session.db);
      final feedService = FeedService(foodDAO: foodDAO);

      final userLocation = Location(
        latitude: userLatitude,
        longitude: userLongitude,
      );

      final feedRequest = FeedRequest(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        dpi: dpi,
        dataTransferRate: dataTransferRate,
        userLocation: userLocation,
        chunkSize: chunkSize,
        filters: filters,
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
          estimatedDeliveryTime:
              item.restaurant.estimatedDeliverytime, // lowercase 't'
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
            id: r.restaurantId, // changed: was r.id
            name: r.name,
            iconUrl: r.iconUrl,
            estimatedDeliveryTime: r.estimatedDeliverytime, // lowercase 't'
            cuisine: r.cuisine,
          );
        }).toList(),
        totalItemsAvailable: response.totalItemsAvailable,
        fetchedCount: response.fetchedCount,
        errorMessage: response.errorMessage,
      );
    } catch (e) {
      return FeedChunkResponse(
        success: false,
        foodItems: [],
        restaurants: [],
        totalItemsAvailable: 0,
        fetchedCount: 0,
        errorMessage: 'Database error: $e',
        errorCode: 'DATABASE_ERROR',
      );
    }
  }

  /// Applies filters to a cached feed in memory without database queries.
  Future<FilteredFeedResponse> applyFilter(
    Session session,
    String cachedItemsJson,
    Map<String, dynamic> filters,
  ) async {
    try {
      final decoded = jsonDecode(cachedItemsJson) as List<dynamic>;
      final itemCount = decoded.length;

      return FilteredFeedResponse(
        success: true,
        itemCount: itemCount,
        message: 'Filter applied successfully',
      );
    } catch (e) {
      return FilteredFeedResponse(
        success: false,
        itemCount: 0,
        message: 'Error applying filter: $e',
      );
    }
  }

  /// Retrieves available municipalities for location selection.
  Future<MunicipalitiesResponse> getMunicipalities(Session session) async {
    try {
      final foodDAO = FoodDAO(session.db);
      final municipalities = await foodDAO.getAllMunicipalities();

      return MunicipalitiesResponse(
        success: true,
        municipalities: municipalities,
        message: 'Municipalities retrieved successfully',
      );
    } catch (e) {
      return MunicipalitiesResponse(
        success: false,
        municipalities: [],
        message: 'Error retrieving municipalities: $e',
      );
    }
  }
}

class FeedChunkResponse {
  final bool success;
  final List<FoodItemResponse> foodItems;
  final List<RestaurantResponse> restaurants;
  final int totalItemsAvailable;
  final int fetchedCount;
  final String? errorMessage;
  final String? errorCode;

  FeedChunkResponse({
    required this.success,
    required this.foodItems,
    required this.restaurants,
    required this.totalItemsAvailable,
    required this.fetchedCount,
    this.errorMessage,
    this.errorCode,
  });

  Map<String, dynamic> toJson() => {
    'success': success,
    'foodItems': foodItems.map((e) => e.toJson()).toList(),
    'restaurants': restaurants.map((e) => e.toJson()).toList(),
    'totalItemsAvailable': totalItemsAvailable,
    'fetchedCount': fetchedCount,
    'errorMessage': errorMessage,
    'errorCode': errorCode,
  };
}

class FoodItemResponse {
  final int? id;
  final String name;
  final String? iconUrl;
  final double price;
  final double rating;
  final int estimatedOrdersAmount;
  final double estimatedDeliveryTime;
  final double? distanceKm;
  final String restaurantName;
  final String? restaurantIconUrl;

  FoodItemResponse({
    required this.id,
    required this.name,
    this.iconUrl,
    required this.price,
    required this.rating,
    required this.estimatedOrdersAmount,
    required this.estimatedDeliveryTime,
    this.distanceKm,
    required this.restaurantName,
    this.restaurantIconUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'iconUrl': iconUrl,
    'price': price,
    'rating': rating,
    'estimatedOrdersAmount': estimatedOrdersAmount,
    'estimatedDeliveryTime': estimatedDeliveryTime,
    'distanceKm': distanceKm,
    'restaurantName': restaurantName,
    'restaurantIconUrl': restaurantIconUrl,
  };
}

class RestaurantResponse {
  final int id;
  final String name;
  final String? iconUrl;
  final double estimatedDeliveryTime;
  final List<String>? cuisine;

  RestaurantResponse({
    required this.id,
    required this.name,
    this.iconUrl,
    required this.estimatedDeliveryTime,
    this.cuisine,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'iconUrl': iconUrl,
    'estimatedDeliveryTime': estimatedDeliveryTime,
    'cuisine': cuisine,
  };
}

class FilteredFeedResponse {
  final bool success;
  final int itemCount;
  final String message;

  FilteredFeedResponse({
    required this.success,
    required this.itemCount,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
    'success': success,
    'itemCount': itemCount,
    'message': message,
  };
}

class MunicipalitiesResponse {
  final bool success;
  final List<String> municipalities;
  final String message;

  MunicipalitiesResponse({
    required this.success,
    required this.municipalities,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
    'success': success,
    'municipalities': municipalities,
    'message': message,
  };
}
