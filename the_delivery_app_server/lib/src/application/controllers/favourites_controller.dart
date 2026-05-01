import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';
import 'dart:convert';

class FavouritesController extends Endpoint {

  Future<String> getFavourites(
    Session session,
    int userId,
  ) async {
    try {
      final favourites = await UserFavourite.db.find(
        session,
        where: (t) => t.userId.equals(userId),
      );

      final favouritesData = <Map<String, dynamic>>[];

      for (final fav in favourites) {
        if (fav.restaurantId != null) {
          final restaurant = await Restaurant.db.findById(session, fav.restaurantId!);
          favouritesData.add({
            'id': fav.id,
            'type': 'restaurant',
            'restaurantId': fav.restaurantId,
            'restaurantName': restaurant?.restName,
            'restaurantLogo': restaurant?.logoThumb,
          });
        }

        if (fav.foodItemId != null) {
          final foodItem = await FoodItem.db.findById(session, fav.foodItemId!);
          favouritesData.add({
            'id': fav.id,
            'type': 'food',
            'foodItemId': fav.foodItemId,
            'foodItemName': foodItem?.foodName,
            'foodItemPrice': foodItem?.foodPrice,
            'foodItemThumbnail': foodItem?.foodThumbnail,
          });
        }
      }

      return jsonEncode({
        'success': true,
        'favourites': favouritesData,
        'total': favouritesData.length,
      });
    } catch (e) {
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> addFavourite(
    Session session,
    String requestJson,
  ) async {
    try {
      final data = jsonDecode(requestJson) as Map<String, dynamic>;
      final userId = data['userId'] as int;
      final restaurantId = data['restaurantId'] as int?;
      final foodItemId = data['foodItemId'] as int?;

      if (restaurantId == null && foodItemId == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Must provide restaurantId or foodItemId',
          'errorCode': 'INVALID_REQUEST',
        });
      }

      // Check if already favourited
      final existing = await UserFavourite.db.findFirstRow(
        session,
        where: (t) {
          var expr = t.userId.equals(userId);
          if (restaurantId != null) {
            expr = expr & t.restaurantId.equals(restaurantId);
          }
          if (foodItemId != null) {
            expr = expr & t.foodItemId.equals(foodItemId);
          }
          return expr;
        },
      );

      if (existing != null) {
        return jsonEncode({
          'success': true,
          'message': 'Already in favourites',
          'favouriteId': existing.id,
        });
      }

      // Add favourite
      final favourite = await UserFavourite.db.insertRow(
        session,
        UserFavourite(
          userId: userId,
          restaurantId: restaurantId,
          foodItemId: foodItemId,
          createdAt: DateTime.now(),
        ),
      );

      return jsonEncode({
        'success': true,
        'message': 'Added to favourites',
        'favouriteId': favourite.id,
      });
    } catch (e) {
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> removeFavourite(
    Session session,
    int favouriteId,
  ) async {
    try {
      final favourite = await UserFavourite.db.findById(session, favouriteId);

      if (favourite == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Favourite not found',
          'errorCode': 'NOT_FOUND',
        });
      }

      await UserFavourite.db.deleteRow(session, favourite);

      return jsonEncode({
        'success': true,
        'message': 'Removed from favourites',
      });
    } catch (e) {
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }
}
