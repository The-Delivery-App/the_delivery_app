abstract class IFoodRepository {
  /// Loads the main food feed for the user.
  /// The caller provides the location (lat/lng or a domain Location object).
  Future<List<Food>> loadFeed({
    required Location location,
  });

  /// Searches for food items by partial name.
  Future<List<Food>> search({
    required String query,
    required Location location,
  });

  /// Applies filters (category, price, dietary tags, etc.) to the feed.
  Future<List<Food>> filter({
    required FoodFilter filter,
    required Location location,
  });

  /// Sorts a given list of food items according to a sort rule.
  /// Sorting is usually done locally, not via API.
  List<Food> sort({
    required List<Food> items,
    required FoodSortRule sortRule,
  });
}
