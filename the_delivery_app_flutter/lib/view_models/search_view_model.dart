import 'package:flutter/foundation.dart';

import '../models/food.dart';
import '../state/search_state.dart';

class SearchViewModel extends ChangeNotifier {
  SearchState _state = const SearchState(
    query: '',
    results: [],
    isLoading: false,
  );

  List<Food> _items = [];

  SearchViewModel();

  SearchState getState() => _state;

  void loadItems(List<Food> items) {
    _items = items;
  }

  void search(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      _state = const SearchState(query: '', results: [], isLoading: false);
      notifyListeners();
      return;
    }
    final results = _items.where((food) {
      return food.name.toLowerCase().contains(q) ||
          food.restaurant.name.toLowerCase().contains(q) ||
          food.tags.any((tag) => tag.toLowerCase().contains(q));
    }).toList();
    _state = SearchState(query: query, results: results, isLoading: false);
    notifyListeners();
  }
}
