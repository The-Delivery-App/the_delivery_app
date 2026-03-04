abstract class IFoodApiService {
  /// Requests a feed portion for the given session and location.
  /// Returns up to 500 Food IDs mixed across restaurants.
  Future<FeedPortionDTO> fetchFeedPortion({
    required String sessionId,
    required Location location,
    FoodFilter? filter,
  });

  /// Retrieves a chunk of fully populated food items by their IDs.
  /// Used by the repository to load visible feed chunks.
  Future<List<FoodDTO>> fetchFoodChunk({
    required List<String> foodIds,
  });

  /// Performs a search across food items, restaurants, and cuisines.
  Future<List<FoodDTO>> search({
    required String query,
    required Location location,
  });

  /// Retrieves quartile‑based price tier information for filtering.
  Future<PriceTierInfoDTO> fetchPriceTierInfo({
    required Location location,
  });
}