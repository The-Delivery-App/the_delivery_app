import '../models/food.dart';

class FeedState {
  final List<Food> feedItems;
  final bool isLoading;

  const FeedState({
    required this.feedItems,
    required this.isLoading,
  });
}
