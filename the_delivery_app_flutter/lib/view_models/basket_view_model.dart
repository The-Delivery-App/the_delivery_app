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

  void addItem(Food food) {
    final newItems = [..._state.basket.items, food];
    _state = BasketState(basket: Basket(items: newItems));
    notifyListeners();
    _repository.updateBasket(_state.basket);
  }
}
