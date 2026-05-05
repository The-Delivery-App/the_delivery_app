import '../../models/food.dart';
import '../../models/restaurant.dart';

abstract class IRestaurantRepository {
  Future<List<Food>> loadMenu(String restaurantId);
  Future<List<Restaurant>> getRestaurantList();
}
