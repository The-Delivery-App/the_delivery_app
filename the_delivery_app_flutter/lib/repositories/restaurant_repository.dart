import '../models/food.dart';
import '../models/restaurant.dart';
import '../APIs/i_restaurant_api_service.dart';
import 'interfaces/i_restaurant_repository.dart';

class RestaurantRepository implements IRestaurantRepository {
  final IRestaurantAPIService _apiService;

  RestaurantRepository({required IRestaurantAPIService apiService})
      : _apiService = apiService;

  @override
  Future<List<Food>> loadMenu(String restaurantId, String restaurantName) async {
    return _apiService.loadMenu(restaurantId, restaurantName);
  }

  @override
  Future<List<Restaurant>> getRestaurantList() async {
    return _apiService.getRestaurantList();
  }
}
