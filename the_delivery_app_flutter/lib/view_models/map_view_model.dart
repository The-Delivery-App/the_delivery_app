import 'dart:async';

import 'package:flutter/foundation.dart';

import '../APIs/i_map_api_service.dart';
import '../state/map_state.dart';

class MapViewModel extends ChangeNotifier {
  final IMapAPIService _apiService;
  StreamSubscription<dynamic>? _locationSub;

  MapState _state = const MapState(restaurants: []);

  MapViewModel({required IMapAPIService apiService}) : _apiService = apiService;

  MapState getState() => _state;

  void updateLocation() {
    // No GPS service connected yet — location stays null until wired up.
    _state = MapState(currentLocation: null, restaurants: _state.restaurants);
    notifyListeners();
  }

  Future<void> loadRestaurantsOnMap() async {
    // No backend connected yet — list stays empty until wired up.
    _state = MapState(currentLocation: _state.currentLocation, restaurants: const []);
    notifyListeners();
  }
}
