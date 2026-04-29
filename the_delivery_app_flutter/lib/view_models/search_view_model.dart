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
}
