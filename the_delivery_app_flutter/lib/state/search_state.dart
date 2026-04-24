import '../models/food.dart';

class SearchState {
  final String query;
  final List<Food> results;
  final bool isLoading;

  const SearchState({
    required this.query,
    required this.results,
    required this.isLoading,
  });
}
