import 'package:flutter/foundation.dart';

import '../models/location.dart';
import '../state/special_deal_state.dart';

class SpecialDealViewModel extends ChangeNotifier {
  SpecialDealState _state = const SpecialDealState(deals: [], isLoading: false);

  SpecialDealViewModel();

  SpecialDealState getState() => _state;

  Future<void> loadDeals(Location location) async {
    _state = const SpecialDealState(deals: [], isLoading: true);
    notifyListeners();

    // No backend connected yet — deals stay empty until wired up.
    _state = const SpecialDealState(deals: [], isLoading: false);
    notifyListeners();
  }
}
