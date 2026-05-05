abstract class IFilterRepository {
  Future<List<String>> getFoodFilters();
  Future<List<String>> getRestaurantFilters();
}
