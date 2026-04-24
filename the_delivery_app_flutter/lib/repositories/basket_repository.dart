import 'dart:convert';

import '../models/basket.dart';
import '../models/food.dart';
import '../models/food_unit_type.dart';
import '../models/restaurant.dart';
import '../storage/i_local_storage.dart';
import 'interfaces/i_basket_repository.dart';

class BasketRepository implements IBasketRepository {
  final ILocalStorage _storage;
  static const _key = 'basket';

  BasketRepository({required ILocalStorage storage}) : _storage = storage;

  @override
  Future<Basket> getBasket() async {
    final raw = await _storage.load(_key);
    if (raw == null) return const Basket(items: []);
    final list = jsonDecode(raw) as List;
    final items = list.map((e) => _foodFromMap(e as Map<String, dynamic>)).toList();
    return Basket(items: items);
  }
}
