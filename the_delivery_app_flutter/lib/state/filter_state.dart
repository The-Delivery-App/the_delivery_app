import '../models/food_filters.dart';

class FilterState {
  final List<String> foodFilters;
  final List<String> restaurantFilters;
  final FoodFilter? selectedFilter;

  const FilterState({
    required this.foodFilters,
    required this.restaurantFilters,
    this.selectedFilter,
  });
}
