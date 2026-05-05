import 'interfaces/i_filter_repository.dart';

class FilterRepository implements IFilterRepository {
  @override
  Future<List<String>> getFoodFilters() async {
    // No backend connected yet — returns empty list until wired up.
    return [];
  }

  @override
  Future<List<String>> getRestaurantFilters() async {
    // No backend connected yet — returns empty list until wired up.
    return [];
  }
}
