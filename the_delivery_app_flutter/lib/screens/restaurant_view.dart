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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurant.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('ID: ${restaurant.id}',
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
