import '../models/location.dart';
import '../models/restaurant.dart';

class MapState {
  final Location? currentLocation;
  final List<Restaurant> restaurants;

  const MapState({
    this.currentLocation,
    required this.restaurants,
  });
}
