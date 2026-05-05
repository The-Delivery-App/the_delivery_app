import 'package:flutter/foundation.dart';

import '../state/filter_state.dart';

class FilterViewModel extends ChangeNotifier {
  FilterState _state = const FilterState(
    foodFilters: [],
    restaurantFilters: [],
  );

  FilterViewModel();

  FilterState getState() => _state;

  Future<void> loadFoodFilters() async {
    // No backend connected yet — returns mock categories.
    _state = FilterState(
      foodFilters: const ['Pizza', 'Burgers', 'Sushi', 'Vegan'],
      restaurantFilters: _state.restaurantFilters,
    );
    notifyListeners();
  }

  Future<void> loadRestaurantFilters() async {
    // No backend connected yet — returns mock restaurant tags.
    _state = FilterState(
      foodFilters: _state.foodFilters,
      restaurantFilters: const ['Open now', 'Top rated', 'Fast delivery'],
    );
    notifyListeners();
  }
}
