import 'dart:math';
import 'package:serverpod/serverpod.dart';

class FeedController extends Endpoint {
  Future<String> hello(Session session) async {
    return 'Feed controller working';
  }
}

Future<FeedChunkResponse> search(
  Session session,
  String searchTerm,
  double userLatitude,
  double userLongitude,
  int limit,
  int offset,
) async {
  try {
    if (searchTerm.isEmpty) {
      return FeedChunkResponse(
        success: false,
        foodItems: [],
        restaurants: [],
        totalItemsAvailable: 0,
        fetchedCount: 0,
        errorMessage: 'Search term cannot be empty',
        errorCode: 'EMPTY_SEARCH',
      );
    }

    final foodDAO = FoodDAO(session);
    
    // Determine municipality from coordinates (simplified)
    final municipality = await _getMunicipalityFromCoordinates(
      session,
      userLatitude,
      userLongitude,
    );

    // Search for food items
    final searchResults = await foodDAO.searchFood(
      searchTerm: searchTerm,
      municipality: municipality,
      limit: limit,
    );

    // Convert to response format
    final foodItems = <FoodItemResponse>[];
    final restaurantIds = <int>{};

    for (final food in searchResults) {
      final restaurant = await foodDAO.getRestaurantById(food.restaurantId);
      if (restaurant != null) {
        restaurantIds.add(restaurant.id);
        
        foodItems.add(FoodItemResponse(
          id: food.id,
          name: food.name,
          iconUrl: food.iconUrl,
          price: food.price,
          rating: food.rating,
          estimatedOrdersAmount: food.estimatedOrdersAmount,
          estimatedDeliveryTime: 30, // Calculate based on distance
          distanceKm: 0.0, // Calculate from coordinates
          restaurantName: restaurant.name,
          restaurantIconUrl: restaurant.logoUrl,
        ));
      }
    }

    return FeedChunkResponse(
      success: true,
      foodItems: foodItems,
      restaurants: [], // Could populate this if needed
      totalItemsAvailable: searchResults.length,
      fetchedCount: foodItems.length,
    );
  } catch (e) {
    return FeedChunkResponse(
      success: false,
      foodItems: [],
      restaurants: [],
      totalItemsAvailable: 0,
      fetchedCount: 0,
      errorMessage: 'Search error: $e',
      errorCode: 'SEARCH_ERROR',
    );
  }
}

Future<String?> _getMunicipalityFromCoordinates(
  Session session,
  double latitude,
  double longitude,
) async {
  final places = await RestaurantPlace.db.find(session, limit: 100);
  
  if (places.isEmpty) return null;
  
  double minDistance = double.infinity;
  String? nearestCity;
  
  for (final place in places) {
    final distance = _calculateDistance(
      latitude,
      longitude,
      place.latitude,
      place.longitude,
    );
    
    if (distance < minDistance) {
      minDistance = distance;
      nearestCity = place.city;
    }
  }
  
  return nearestCity;
}

double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371; // Earth's radius in km
  final dLat = _toRadians(lat2 - lat1);
  final dLon = _toRadians(lon2 - lon1);
  
  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
      sin(dLon / 2) * sin(dLon / 2);
  
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c;
}

double _toRadians(double degrees) {
  return degrees * pi / 180;
}