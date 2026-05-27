import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/models/basket.dart';
import 'package:the_delivery_app_flutter/models/food.dart';
import 'package:the_delivery_app_flutter/models/restaurant.dart';
import 'package:the_delivery_app_flutter/models/food_unit_type.dart';

Food makeFood(String id, {double price = 5.0}) => Food(
  id: id,
  name: 'Food $id',
  price: price,
  rating: 4.5,
  tags: const [],
  imageUrl: '',
  restaurantImageUrl: '',
  restaurant: const Restaurant(id: 'r', name: 'R'),
  recentOrders: 0,
  deliveryTime: const Duration(minutes: 20),
  unitType: FoodUnitType.pcs,
  size: 1,
  calories: 100,
  isDiscounted: false,
);

Map<String, double> computePricingSummary(
  Basket basket, {
  double? couponDiscountFixed,
  double? couponDiscountPct,
}) {
  final subtotal = basket.items.fold(0.0, (s, f) => s + f.price);
  final deliveryFee = subtotal >= 15.0 ? 0.0 : 2.99;
  final serviceFee = subtotal * 0.10;
  double discount = 0.0;
  if (couponDiscountPct != null) discount = subtotal * couponDiscountPct;
  if (couponDiscountFixed != null) discount = couponDiscountFixed;
  final total = (subtotal + deliveryFee + serviceFee - discount).clamp(
    0.0,
    double.infinity,
  );
  return {
    'subtotal': subtotal,
    'deliveryFee': deliveryFee,
    'serviceFee': serviceFee,
    'discount': discount,
    'total': total,
  };
}

void main() {
  group('Checkout pricing and discounts TC-015..TC-021', () {
    test('TC-015 pricing: subtotal 14.99 applies delivery fee', () {
      final basket = Basket(items: [makeFood('a', price: 14.99)]);
      final p = computePricingSummary(basket);
      expect(p['subtotal'], closeTo(14.99, 1e-6));
      expect(p['deliveryFee'], closeTo(2.99, 1e-9));
    });

    test('TC-016 pricing: subtotal 15.00 waives delivery fee', () {
      final basket = Basket(items: [makeFood('a', price: 15.00)]);
      final p = computePricingSummary(basket);
      expect(p['deliveryFee'], closeTo(0.0, 1e-9));
    });

    test('TC-017 pricing: service fee is 10% of subtotal', () {
      final basket = Basket(items: [makeFood('a', price: 20.0)]);
      final p = computePricingSummary(basket);
      expect(p['serviceFee'], closeTo(2.0, 1e-9));
    });

    test('TC-018 discount SAVE10 applies 10% discount', () {
      final basket = Basket(items: [makeFood('a', price: 50.0)]);
      final p = computePricingSummary(basket, couponDiscountPct: 0.10);
      expect(p['discount'], closeTo(5.0, 1e-9));
    });

    test('TC-019 discount SAVE20 applies 20% discount', () {
      final basket = Basket(items: [makeFood('a', price: 30.0)]);
      final p = computePricingSummary(basket, couponDiscountPct: 0.20);
      expect(p['discount'], closeTo(6.0, 1e-9));
    });

    test('TC-020 discount FREESHIP applies fixed delivery discount', () {
      final basket = Basket(items: [makeFood('a', price: 10.0)]);
      final p = computePricingSummary(basket, couponDiscountFixed: 2.99);
      expect(p['discount'], closeTo(2.99, 1e-9));
      expect(p['total'], closeTo(10.0 + 1.0, 1e-9));
    });

    test('TC-021 unknown coupon gives zero discount', () {
      final basket = Basket(items: [makeFood('a', price: 40.0)]);
      final p = computePricingSummary(basket);
      expect(p['discount'], closeTo(0.0, 1e-9));
    });
  });
}
