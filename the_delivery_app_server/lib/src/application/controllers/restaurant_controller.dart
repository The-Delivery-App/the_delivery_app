import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';
import 'dart:convert';

class RestaurantController extends Endpoint {
  Future<String> getRestaurant(
    Session session,
    int restaurantId,
  ) async {
    try {
      final restaurant = await Restaurant.db.findById(session, restaurantId);
      
      if (restaurant == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Restaurant not found',
          'errorCode': 'NOT_FOUND',
        });
      }

      final place = await RestaurantPlace.db.findFirstRow(
        session,
        where: (t) => t.restId.equals(restaurantId),
      );

      final menuItems = await FoodItem.db.find(
        session,
        where: (t) => t.restId.equals(restaurantId),
      );

      double avgRating = 0.0;
      if (menuItems.isNotEmpty) {
        avgRating = menuItems
            .map((item) => item.foodRating)
            .reduce((a, b) => a + b) / menuItems.length;
      }

      return jsonEncode({
        'success': true,
        'restaurant': {
          'id': restaurant.id,
          'name': restaurant.restName,  // FIXED: was 'name'
          'cuisine': restaurant.cuisine,
          'logoUrl': restaurant.logoThumb,  // FIXED: was 'logoUrl'
          'estimatedDeliveryTime': restaurant.estimatedDeliveryTime,
          'averageRating': avgRating,
          'totalMenuItems': menuItems.length,
          'location': place != null ? {
            'latitude': place.latitude,
            'longitude': place.longitude,
            'address': place.addressLine1,  // FIXED: was 'streetAddress'
            'addressLine2': place.addressLine2,
            'city': place.city,
            'postcode': place.postcode,
            'country': place.country,
          } : null,
        },
      });
    } catch (e) {
      session.log('Error in getRestaurant: $e', level: LogLevel.error);
      return jsonEncode({
        'success': false,
        'errorMessage': 'Internal server error: $e',
        'errorCode': 'INTERNAL_ERROR',
      });
    }
  }

  Future<String> getMenu(
    Session session,
    int restaurantId,
  ) async {
    try {
      final items = await FoodItem.db.find(
        session,
        where: (t) => t.restId.equals(restaurantId),
        orderBy: (t) => t.foodRating,
        orderDescending: true,
      );

      if (items.isEmpty) {
        return jsonEncode({
          'success': true,
          'menu': {},
          'message': 'No menu items found',
        });
      }

      final menuData = {
        'All Items': items.map((item) => {
          'id': item.id,
          'name': item.foodName,
          'description': item.description,
          'price': item.foodPrice,
          'rating': item.foodRating,
          'thumbnail': item.foodThumbnail,
          'nutritionCals': item.nutritionCals,
          'estimatedOrders': item.estimatedOrders,
        }).toList(),
      };

      return jsonEncode({
        'success': true,
        'menu': menuData,
        'totalItems': items.length,
      });
    } catch (e) {
      session.log('Error in getMenu: $e', level: LogLevel.error);
      return jsonEncode({
        'success': false,
        'errorMessage': 'Internal server error: $e',
        'errorCode': 'INTERNAL_ERROR',
      });
    }
  }

  Future<String> getReviews(
    Session session,
    int restaurantId,
    int limit,
    int offset,
  ) async {
    try {
      if (limit <= 0 || limit > 100) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Limit must be between 1 and 100',
          'errorCode': 'INVALID_LIMIT',
        });
      }

      final foodItems = await FoodItem.db.find(
        session,
        where: (t) => t.restId.equals(restaurantId),
      );

      if (foodItems.isEmpty) {
        return jsonEncode({
          'success': true,
          'reviews': [],
          'hasMore': false,
        });
      }

      final foodItemIds = foodItems.map((item) => item.id!).toList();

      final allReviews = <FoodReview>[];
      for (final foodItemId in foodItemIds) {
        final reviews = await FoodReview.db.find(
          session,
          where: (t) => t.foodId.equals(foodItemId),  // FIXED: was foodItemId
        );
        allReviews.addAll(reviews);
      }

      final paginatedReviews = allReviews.skip(offset).take(limit).toList();

      final reviewsData = <Map<String, dynamic>>[];
      for (final review in paginatedReviews) {
        final user = await User.db.findById(session, review.userId);
        final foodItem = await FoodItem.db.findById(session, review.foodId);  // FIXED
        
        reviewsData.add({
          'id': review.id,
          'rating': review.rating,
          'comment': review.comment,
          'userName': user?.name ?? 'Anonymous',
          'foodItemName': foodItem?.foodName ?? 'Unknown',
        });
      }

      return jsonEncode({
        'success': true,
        'reviews': reviewsData,
        'hasMore': allReviews.length > (offset + limit),
        'totalReviews': allReviews.length,
      });
    } catch (e) {
      session.log('Error in getReviews: $e', level: LogLevel.error);
      return jsonEncode({
        'success': false,
        'errorMessage': 'Internal server error: $e',
        'errorCode': 'INTERNAL_ERROR',
      });
    }
  }

  Future<String> getFeatured(
    Session session,
    int limit,
  ) async {
    try {
      final restaurants = await Restaurant.db.find(
        session,
        limit: limit,
      );

      final featuredData = <Map<String, dynamic>>[];
      
      for (final restaurant in restaurants) {
        final place = await RestaurantPlace.db.findFirstRow(
          session,
          where: (t) => t.restId.equals(restaurant.id!),
        );

        featuredData.add({
          'id': restaurant.id,
          'name': restaurant.restName,  
          'cuisine': restaurant.cuisine,
          'logoUrl': restaurant.logoThumb,  
          'estimatedDeliveryTime': restaurant.estimatedDeliveryTime,
          'city': place?.city,
        });
      }

      return jsonEncode({
        'success': true,
        'restaurants': featuredData,
      });
    } catch (e) {
      session.log('Error in getFeatured: $e', level: LogLevel.error);
      return jsonEncode({
        'success': false,
        'errorMessage': 'Internal server error: $e',
        'errorCode': 'INTERNAL_ERROR',
      });
    }
  }
}