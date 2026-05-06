import 'package:flutter/foundation.dart';

import '../repositories/interfaces/i_restaurant_repository.dart';
import '../state/restaurant_state.dart';

class RestaurantViewModel extends ChangeNotifier {
  final IRestaurantRepository _repository;

  RestaurantState _state = const RestaurantState(menuItems: [], isLoading: false);

  RestaurantViewModel({required IRestaurantRepository repository})
      : _repository = repository;

  RestaurantState getState() => _state;

  Future<void> loadMenu(String restaurantId) async {
    _state = const RestaurantState(menuItems: [], isLoading: true);
    notifyListeners();

    try {
      final items = await _repository.loadMenu(restaurantId);
      _state = RestaurantState(menuItems: items, isLoading: false);
    } catch (e) {
      _state = RestaurantState(
        menuItems: [],
        isLoading: false,
        errorMessage: e.toString(),
      );
    }

    notifyListeners();
  }
}
