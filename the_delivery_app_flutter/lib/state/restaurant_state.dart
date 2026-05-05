import '../models/food.dart';

class RestaurantState {
  final List<Food> menuItems;
  final bool isLoading;
  final String? errorMessage;
  final String? cuisine;
  final int? deliveryMinutes;

  const RestaurantState({
    required this.menuItems,
    required this.isLoading,
    this.errorMessage,
    this.cuisine,
    this.deliveryMinutes,
  });
}
