import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';
import 'dart:convert';

class ReviewsController extends Endpoint {

  Future<String> createReview(
    Session session,
    String requestJson,
  ) async {
    try {
      final data = jsonDecode(requestJson) as Map<String, dynamic>;
      final userId = data['userId'] as int;
      final foodId = data['foodId'] as int;
      final rating = (data['rating'] as num).toDouble();
      final comment = data['comment'] as String?;

      if (rating < 1 || rating > 5) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Rating must be between 1 and 5',
          'errorCode': 'INVALID_RATING',
        });
      }

      final foodItem = await FoodItem.db.findById(session, foodId);
      if (foodItem == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Food item not found',
          'errorCode': 'NOT_FOUND',
        });
      }

      final existing = await FoodReview.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(userId) & t.foodId.equals(foodId),
      );

      if (existing != null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Already reviewed this item',
          'errorCode': 'ALREADY_REVIEWED',
        });
      }

      final review = await FoodReview.db.insertRow(
        session,
        FoodReview(
          userId: userId,
          foodId: foodId,
          rating: rating,
          comment: comment,
        ),
      );

      final allReviews = await FoodReview.db.find(
        session,
        where: (t) => t.foodId.equals(foodId),
      );

      final avgRating = allReviews
          .map((r) => r.rating)
          .reduce((a, b) => a + b) / allReviews.length;

      foodItem.foodRating = avgRating;
      await FoodItem.db.updateRow(session, foodItem);

      return jsonEncode({
        'success': true,
        'message': 'Review created',
        'reviewId': review.id,
        'newAverageRating': avgRating,
      });
    } catch (e) {
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> getReviews(
    Session session,
    int foodId,
    int limit,
    int offset,
  ) async {
    try {
      final reviews = await FoodReview.db.find(
        session,
        where: (t) => t.foodId.equals(foodId),
        limit: limit,
        offset: offset,
      );

      final reviewsData = <Map<String, dynamic>>[];

      for (final review in reviews) {
        final user = await User.db.findById(session, review.userId);
        reviewsData.add({
          'id': review.id,
          'rating': review.rating,
          'comment': review.comment,
          'userName': user?.name ?? 'Anonymous',
        });
      }

      return jsonEncode({
        'success': true,
        'reviews': reviewsData,
        'hasMore': reviews.length == limit,
      });
    } catch (e) {
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }

  Future<String> deleteReview(
    Session session,
    int reviewId,
  ) async {
    try {
      final review = await FoodReview.db.findById(session, reviewId);

      if (review == null) {
        return jsonEncode({
          'success': false,
          'errorMessage': 'Review not found',
          'errorCode': 'NOT_FOUND',
        });
      }

      await FoodReview.db.deleteRow(session, review);

      return jsonEncode({
        'success': true,
        'message': 'Review deleted',
      });
    } catch (e) {
      return jsonEncode({'success': false, 'error': '$e'});
    }
  }
}
