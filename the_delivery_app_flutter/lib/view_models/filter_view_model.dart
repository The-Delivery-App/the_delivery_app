import 'package:flutter/foundation.dart';

import '../state/filter_state.dart';

class FilterViewModel extends ChangeNotifier {
  FilterState _state = const FilterState(
    foodFilters: [],
    restaurantFilters: [],
  );

  FilterViewModel();

  FilterState getState() => _state;
}
