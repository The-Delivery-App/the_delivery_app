import 'location.dart';

/// Represents restaurant data returned from the database.
class RestaurantInfo {
  final int restaurantId;
  final String name;
  final String? iconUrl;
  final Location location;
  final double estimatedDeliverytime; // lowercase 't' — matches FoodDAO constructor
  final List<String>? cuisine;

  RestaurantInfo({
    required this.restaurantId,
    required this.name,
    this.iconUrl,
    required this.location,
    required this.estimatedDeliverytime,
    this.cuisine,
  });
}