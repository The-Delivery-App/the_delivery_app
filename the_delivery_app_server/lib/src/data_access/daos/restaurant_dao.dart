import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';

class RestaurantDAO {
  final Session session;

  RestaurantDAO(this.session);

  Future<Restaurant?> getById(int restaurantId) async {
    try {
      return await Restaurant.db.findById(session, restaurantId);
    } catch (e) {
      session.log('Error getting restaurant: $e');
      return null;
    }
  }

  Future<Restaurant?> getWithPlace(int restaurantId) async {
    try {
      final restaurant = await Restaurant.db.findById(session, restaurantId);
      if (restaurant == null) return null;

      final place = await RestaurantPlace.db.findById(session, restaurant.placeId);
      // Note - serverpod will handle the relation loading
      
      return restaurant;
    } catch (e) {
      session.log('Error getting restaurant with place: $e');
      return null;
    }
  }

  Future<Map<String, List<FoodItem>>> getGroupedMenu(int restaurantId) async {
    try {
      final items = await FoodItem.db.find(
        session,
        where: (t) => t.restId.equals(restaurantId),
      );

      return {
        'All Items': items,
      };
    } catch (e) {
      session.log('Error getting grouped menu: $e');
      return {};
    }
  }

  Future<List<FoodReview>> getReviews(
    int restaurantId, {
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final foodItems = await FoodItem.db.find(
        session,
        where: (t) => t.restId.equals(restaurantId),
      );

      if (foodItems.isEmpty) return [];

      final foodItemIds = foodItems.map((item) => item.id!).toList();

      final reviews = <FoodReview>[];
      for (final foodItemId in foodItemIds) {
        final itemReviews = await FoodReview.db.find(
          session,
          where: (t) => t.foodItemId.equals(foodItemId),
          limit: limit,
          offset: offset,
        );
        reviews.addAll(itemReviews);
      }

      return reviews;
    } catch (e) {
      session.log('Error getting reviews: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getStatistics(int restaurantId) async {
    try {
      final foodItems = await FoodItem.db.find(
        session,
        where: (t) => t.restId.equals(restaurantId),
      );

      if (foodItems.isEmpty) {
        return {
          'totalItems': 0,
          'averageRating': 0.0,
          'totalReviews': 0,
        };
      }

      final ratings = foodItems.map((item) => item.foodRating).toList();
      final avgRating = ratings.reduce((a, b) => a + b) / ratings.length;

      return {
        'totalItems': foodItems.length,
        'averageRating': avgRating,
        'totalReviews': 0, // todo: Count actual reviews
      };
    } catch (e) {
      session.log('Error getting statistics: $e');
      return {
        'totalItems': 0,
        'averageRating': 0.0,
        'totalReviews': 0,
      };
    }
  }
}