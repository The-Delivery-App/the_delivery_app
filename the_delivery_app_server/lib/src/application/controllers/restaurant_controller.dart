import 'package:serverpod/serverpod.dart';

class RestaurantController extends Endpoint {
  Future<String> getRestaurant(
    Session session,
    int restaurantId,
  ) async {
    return '{"success": true, "restaurantId": $restaurantId}';
  }

  Future<String> getMenu(
    Session session,
    int restaurantId,
  ) async {
    return '{"success": true, "menu": []}';
  }

  Future<String> getReviews(
    Session session,
    int restaurantId,
    int limit,
    int offset,
  ) async {
    return '{"success": true, "reviews": []}';
  }
}