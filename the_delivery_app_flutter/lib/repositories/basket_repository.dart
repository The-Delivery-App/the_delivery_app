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

  @override
  Future<void> updateBasket(Basket basket) async {
    final list = basket.items.map(_foodToMap).toList();
    await _storage.save(_key, jsonEncode(list));
  }

  Map<String, dynamic> _foodToMap(Food food) {
    return {
      'id': food.id,
      'name': food.name,
      'price': food.price,
      'rating': food.rating,
      'tags': food.tags,
      'imageUrl': food.imageUrl,
      'restaurantImageUrl': food.restaurantImageUrl,
      'restaurantId': food.restaurant.id,
      'restaurantName': food.restaurant.name,
      'recentOrders': food.recentOrders,
      'deliveryTimeMs': food.deliveryTime.inMilliseconds,
      'unitType': food.unitType.name,
      'size': food.size,
      'calories': food.calories,
      'isDiscounted': food.isDiscounted,
    };
  }

  Food _foodFromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'],
      name: map['name'],
      price: (map['price'] as num).toDouble(),
      rating: (map['rating'] as num).toDouble(),
      tags: List<String>.from(map['tags']),
      imageUrl: map['imageUrl'],
      restaurantImageUrl: map['restaurantImageUrl'],
      restaurant: Restaurant(
        id: map['restaurantId'],
        name: map['restaurantName'],
      ),
      recentOrders: map['recentOrders'],
      deliveryTime: Duration(milliseconds: map['deliveryTimeMs']),
      unitType: FoodUnitType.values.firstWhere(
        (e) => e.name == map['unitType'],
        orElse: () => FoodUnitType.pcs,
      ),
      size: map['size'],
      calories: map['calories'],
      isDiscounted: map['isDiscounted'],
    );
  }
}
