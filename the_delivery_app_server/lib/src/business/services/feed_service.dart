import '../models/food.dart';
import '../models/location.dart';
import '../../data_access/daos/food_dao.dart';

/// Service for handling feed operations.
/// Implements geo-aware infinite scroll strategy for food items.
class FeedService {
  final FoodDAO _foodDAO;
  final Map<int, List<FoodItem>> _cachedFeeds = {}; // Cache for loaded data

  FeedService({required FoodDAO foodDAO}) : _foodDAO = foodDAO;

  /// Retrieves a chunk of food items for the feed.
  /// Uses geo-location to determine nearby municipalities and loads items in chunks.
  Future<FeedResponse> getFeedChunk(
    FeedRequest feedRequest,
    int chunkOffset,
  ) async {
    try {
      // Determine the municipality based on user location
      final municipality = await _getMunicipalityFromLocation(
        feedRequest.userLocation,
      );

      if (municipality == null) {
        return FeedResponse(
          success: false,
          foodItems: [],
          restaurants: [],
          totalItemsAvailable: 0,
          fetchedCount: 0,
          errorMessage: 'No restaurants found in your area',
        );
      }

      // Get total count of available items
      final totalCount = await _foodDAO.countFoodByMunicipality(municipality);

      // Fetch food items with applied filters
      final foods = await _foodDAO.getFoodByMunicipality(
        municipality,
        limit: feedRequest.chunkSize,
        offset: chunkOffset,
        filters: feedRequest.filters,
      );

      // Get unique restaurant IDs
      final restaurantIds = foods.map((f) => f.restaurantId).toSet().toList();

      // Fetch restaurant information
      final restaurants = await _foodDAO.getRestaurantsByIds(restaurantIds);

      // Build food items with distance information
      final foodItems = foods
          .map((food) {
            final restaurant = restaurants[food.restaurantId];
            if (restaurant == null) {
              return null;
            }

            final distance = feedRequest.userLocation.distanceTo(
              restaurant.location,
            );
            return FoodItem(
              food: food,
              restaurant: restaurant,
              distanceToRestaurant: distance,
            );
          })
          .whereType<FoodItem>()
          .toList();

      // Sort by distance for better UX
      foodItems.sort(
        (a, b) => (a.distanceToRestaurant ?? 999).compareTo(
          b.distanceToRestaurant ?? 999,
        ),
      );

      return FeedResponse(
        success: true,
        foodItems: foodItems,
        restaurants: restaurants.values.toList(),
        totalItemsAvailable: totalCount,
        fetchedCount: foods.length,
      );
    } catch (e) {
      return FeedResponse(
        success: false,
        foodItems: [],
        restaurants: [],
        totalItemsAvailable: 0,
        fetchedCount: 0,
        errorMessage: 'Error loading feed: $e',
      );
    }
  }

  /// Applies filters to already-loaded feed in memory.
  /// Returns filtered food items without fetching from database.
  List<FoodItem> applyFilterToMemory(
    List<FoodItem> cachedItems,
    Map<String, dynamic> filters,
  ) {
    var filtered = cachedItems;

    // Filter by minimum rating
    if (filters['minRating'] != null) {
      filtered = filtered
          .where((item) => item.food.rating >= filters['minRating'])
          .toList();
    }

    // Filter by maximum price
    if (filters['maxPrice'] != null) {
      filtered = filtered
          .where((item) => item.food.price <= filters['maxPrice'])
          .toList();
    }

    // Filter by cuisine type
    if (filters['cuisine'] != null) {
      final cuisineFilter = filters['cuisine'] as String;
      filtered = filtered
          .where(
            (item) => item.restaurant.cuisine?.contains(cuisineFilter) ?? false,
          )
          .toList();
    }

    // Filter by search term
    if (filters['searchTerm'] != null) {
      final term = (filters['searchTerm'] as String).toLowerCase();
      filtered = filtered
          .where(
            (item) =>
                item.food.name.toLowerCase().contains(term) ||
                item.restaurant.name.toLowerCase().contains(term),
          )
          .toList();
    }

    // Sort by distance
    filtered.sort(
      (a, b) => (a.distanceToRestaurant ?? 999).compareTo(
        b.distanceToRestaurant ?? 999,
      ),
    );

    return filtered;
  }

  /// Determines the municipality from user location.
  /// In production, this would use reverse geocoding or database geospatial queries.
  /// For now, it returns the municipality from the location object or defaults.
  Future<String?> _getMunicipalityFromLocation(Location location) async {
    try {
      // If municipality is already provided in location, use it
      if (location.municipality != null && location.municipality!.isNotEmpty) {
        return location.municipality;
      }

      // Otherwise, get all municipalities and find the closest one
      final municipalities = await _foodDAO.getAllMunicipalities();

      if (municipalities.isEmpty) {
        return null;
      }

      // For now, return the first municipality (in production, use geospatial queries)
      return municipalities.first;
    } catch (e) {
      return null;
    }
  }

  /// Handles memory management for cached feeds.
  /// Keeps only the 2 most recent chunks to prevent memory overload.
  void cleanupCache() {
    if (_cachedFeeds.length > 2) {
      final keys = _cachedFeeds.keys.toList()..sort();
      final keysToRemove = keys.sublist(0, keys.length - 2);
      for (final key in keysToRemove) {
        _cachedFeeds.remove(key);
      }
    }
  }

  /// Clears the entire cache.
  void clearCache() {
    _cachedFeeds.clear();
  }
}
