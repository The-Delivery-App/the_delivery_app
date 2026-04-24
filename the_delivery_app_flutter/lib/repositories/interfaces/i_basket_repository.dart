import '../../models/basket.dart';

abstract class IBasketRepository {
  Future<Basket> getBasket();
  Future<void> updateBasket(Basket basket);
}
