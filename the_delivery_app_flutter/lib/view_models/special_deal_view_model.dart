import 'package:flutter/foundation.dart';

import '../models/location.dart';
import '../repositories/interfaces/i_special_deal_repository.dart';
import '../state/special_deal_state.dart';

class SpecialDealViewModel extends ChangeNotifier {
  final ISpecialDealRepository _repository;

  SpecialDealState _state = const SpecialDealState(deals: [], isLoading: false);

  static const _defaultLocation = Location(51.5, -0.1);

  SpecialDealViewModel({required ISpecialDealRepository repository})
      : _repository = repository;

  SpecialDealState getState() => _state;

  Future<void> loadDeals() async {
    _state = const SpecialDealState(deals: [], isLoading: true);
    notifyListeners();
    try {
      final items = await _repository.getSpecialDeals(_defaultLocation);
      _state = SpecialDealState(deals: items, isLoading: false);
    } catch (_) {
      _state = const SpecialDealState(deals: [], isLoading: false);
    }
    notifyListeners();
  }
}
