abstract class IFoodRepository {
  // Read USE CASE FROM THE WORD DOCUMENT(2.2) "SCROLLING FEED" TO UNDERSTAND WHATS GOING ON.
  
  /// Initializes a new feed portion for the given session and location.
  /// This resets internal cursors and discards previous feed data.
  Future<void> initializeFeed({
    required Location location,
    required DeviceProfile device,
    FoodFilter? filter,
    FoodSortRule? sortRule,
  });

  /// Loads the next chunk of food items from the current feed portion.
  /// If the portion is exhausted, a new portion is fetched automatically.
  Future<List<Food>> loadNextChunk();

  /// Prefetches the next chunk in the background.
  /// Used when the UI detects near-end of current chunk.
  Future<void> prefetchNextChunk();

  /// Returns the currently loaded chunks (for rendering).
  /// Only the two most recent chunks are retained.
  List<Food> getCurrentFeed();

  /// Performs a search across food items and restaurants.
  Future<List<Food>> search({
    required String query,
    required Location location,
  });

  /// Clears internal caches (used on logout or memory pressure).
  void clear();
}