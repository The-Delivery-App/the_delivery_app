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

  Widget _buildMenuItem(Food food) {
    return ListTile(
      title: Text(food.name),
      subtitle: Text('${food.calories} kcal · ⭐ ${food.rating.toStringAsFixed(1)}'),
      trailing: Text(
        '£${food.price.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

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
    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name)),
      body: menuItems.isEmpty
          ? const Center(child: Text('No menu items available.'))
          : ListView.builder(
              itemCount: menuItems.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) return _buildHeader();
                return _buildMenuItem(menuItems[index - 1]);
              },
            ),
    );
  }
}
