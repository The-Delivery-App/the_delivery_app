import '../models/food.dart';
import '../models/restaurant.dart';

abstract class IRestaurantAPIService {
  Future<List<Food>> loadMenu(String restaurantId, String restaurantName);
  Future<List<Restaurant>> getRestaurantList();
}
