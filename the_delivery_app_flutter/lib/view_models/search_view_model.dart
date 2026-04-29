import 'package:flutter/foundation.dart';

import '../state/search_state.dart';

class SearchViewModel extends ChangeNotifier {
  SearchState _state = const SearchState(
    query: '',
    results: [],
    isLoading: false,
  );

  SearchViewModel();

  SearchState getState() => _state;

  Future<void> search(String query) async {
    _state = SearchState(query: query, results: [], isLoading: true);
    notifyListeners();

    // No backend connected yet — results stay empty until wired up.
    _state = SearchState(query: query, results: [], isLoading: false);
    notifyListeners();
  }
}
