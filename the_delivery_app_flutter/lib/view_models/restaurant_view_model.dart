import 'package:flutter/foundation.dart';

import '../state/restaurant_state.dart';

class RestaurantViewModel extends ChangeNotifier {
  RestaurantState _state = const RestaurantState(menuItems: [], isLoading: false);

  RestaurantViewModel();

  RestaurantState getState() => _state;

  Future<void> loadMenu(String restaurantId) async {
    _state = const RestaurantState(menuItems: [], isLoading: true);
    notifyListeners();

    // No backend connected yet — menu stays empty until wired up.
    _state = const RestaurantState(menuItems: [], isLoading: false);
    notifyListeners();
  }
}
