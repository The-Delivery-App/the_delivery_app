import '../models/food.dart';
import '../models/restaurant.dart';
import 'i_restaurant_api_service.dart';

class RestaurantAPIService implements IRestaurantAPIService {
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
