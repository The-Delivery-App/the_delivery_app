import '../models/food.dart';

class FeedState {
  final List<Food> feedItems;
  final bool isLoading;
  final String? errorMessage;

  const FeedState({
    required this.feedItems,
    required this.isLoading,
    this.errorMessage,
  });
}
