import 'package:flutter/material.dart';

import '../models/food.dart';
import '../models/restaurant.dart';

class RestaurantView extends StatelessWidget {
  final Restaurant restaurant;
  final List<Food> menuItems;

  const RestaurantView({
    super.key,
    required this.restaurant,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
