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

  Future<void> updateLocation() async {
    final location = await _apiService.getCurrentLocation();
    _state = MapState(currentLocation: location, restaurants: _state.restaurants);
    notifyListeners();
    _locationSub?.cancel();
    _locationSub = _apiService.locationStream.listen((loc) {
      _state = MapState(currentLocation: loc, restaurants: _state.restaurants);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _locationSub?.cancel();
    super.dispose();
  }

  Future<void> loadRestaurantsOnMap() async {
    // No backend connected yet — list stays empty until wired up.
    _state = MapState(currentLocation: _state.currentLocation, restaurants: const []);
    notifyListeners();
  }
}
