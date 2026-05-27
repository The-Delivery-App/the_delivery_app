import 'package:flutter/foundation.dart';

import '../models/basket.dart';
import '../models/food.dart';
import '../repositories/interfaces/i_basket_repository.dart';
import '../state/basket_state.dart';

class BasketViewModel extends ChangeNotifier {
  final IBasketRepository _repository;
  BasketState _state = const BasketState(basket: Basket(items: []));

  BasketViewModel({required IBasketRepository repository})
    : _repository = repository;

  BasketState getState() => _state;

  Future<void> loadBasket() async {
    try {
      final basket = await _repository.getBasket();
      _state = BasketState(basket: basket);
    } catch (_) {
      _state = const BasketState(basket: Basket(items: []));
    }
    notifyListeners();
  }

  void addItem(Food food) {
    final newItems = [..._state.basket.items, food];
    _state = BasketState(basket: Basket(items: newItems));
    notifyListeners();
    _repository.updateBasket(_state.basket);
  }

  void removeItem(Food food) {
    final list = List<Food>.from(_state.basket.items);
    final index = list.indexWhere((f) => f.id == food.id);
    if (index != -1) list.removeAt(index);
    _state = BasketState(basket: Basket(items: list));
    notifyListeners();
    _repository.updateBasket(_state.basket);
  }

  void clearBasket() {
    _state = const BasketState(basket: Basket(items: []));
    notifyListeners();
    _repository.updateBasket(_state.basket);
  }
}
