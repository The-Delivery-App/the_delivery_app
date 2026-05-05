import '../models/food.dart';

class RestaurantState {
  final List<Food> menuItems;
  final bool isLoading;
  final String? errorMessage;

  const RestaurantState({
    required this.menuItems,
    required this.isLoading,
    this.errorMessage,
  });
}
