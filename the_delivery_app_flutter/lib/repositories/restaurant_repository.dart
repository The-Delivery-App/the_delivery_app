import '../models/food.dart';
import '../models/restaurant.dart';
import 'interfaces/i_restaurant_repository.dart';

class RestaurantRepository implements IRestaurantRepository {
  @override
  Future<List<Food>> loadMenu(String restaurantId) async {
    // No backend connected yet — returns empty list until wired up.
    return [];
  }

  @override
  Future<List<Restaurant>> getRestaurantList() async {
    // No backend connected yet — returns empty list until wired up.
    return [];
  }
}
