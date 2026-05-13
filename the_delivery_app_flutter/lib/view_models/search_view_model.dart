import 'package:flutter/foundation.dart';

import '../models/food.dart';
import '../models/location.dart';
import '../repositories/i_feed_repository.dart';
import '../state/search_state.dart';

class SearchViewModel extends ChangeNotifier {
  final IFoodRepository? _repository;

  SearchState _state = const SearchState(
    query: '',
    results: [],
    isLoading: false,
  );

  List<Food> _items = [];

  static const _defaultLocation = Location(51.5, -0.1);

  SearchViewModel({IFoodRepository? repository}) : _repository = repository;

  SearchState getState() => _state;

  void loadItems(List<Food> items) {
    _items = items;
    if (_state.query.isNotEmpty) search(_state.query);
  }

  void search(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      _state = const SearchState(query: '', results: [], isLoading: false);
      notifyListeners();
      return;
    }

    final seenIds = <String>{};
    final localResults = _items.where((food) {
      final matches = food.name.toLowerCase().contains(q) ||
          food.restaurant.name.toLowerCase().contains(q) ||
          food.tags.any((tag) => tag.toLowerCase().contains(q));
      return matches && seenIds.add(food.id);
    }).toList();

    final useBackend = q.length >= 3 && _repository != null;
    _state = SearchState(
      query: query,
      results: localResults,
      isLoading: useBackend,
    );
    notifyListeners();

    if (useBackend) {
      _repository.search(query: q, location: _defaultLocation).then((backendResults) {
        if (_state.query != query) return;
        final seen = <String>{};
        final unique = backendResults.where((f) => seen.add(f.id)).toList();
        _state = SearchState(
          query: query,
          results: unique.isNotEmpty ? unique : localResults,
          isLoading: false,
        );
        notifyListeners();
      }).catchError((_) {
        if (_state.query != query) return;
        _state = SearchState(query: query, results: localResults, isLoading: false);
        notifyListeners();
      });
    }
  }
}
