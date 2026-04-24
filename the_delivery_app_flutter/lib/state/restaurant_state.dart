import '../models/food.dart';

class RestaurantState {
  final List<Food> menuItems;
  final bool isLoading;

  const RestaurantState({
    required this.menuItems,
    required this.isLoading,
  });
}
