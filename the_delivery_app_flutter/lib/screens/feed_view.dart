import 'package:flutter/material.dart';

import '../models/food.dart';
import '../state/feed_state.dart';

class FeedView extends StatelessWidget {
  final FeedState state;

  const FeedView({super.key, required this.state});

  Widget _buildFoodCard(Food food) {
    final minutes = food.deliveryTime.inMinutes;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.fastfood, size: 48, color: Colors.deepOrange),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(food.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(food.restaurant.name,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(food.rating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 10),
                      const Icon(Icons.access_time,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text('$minutes min',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              '\$${food.price.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.deepOrange),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(child: Text('No items in feed.'));
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            const Text('Could not load feed.',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (state.errorMessage != null) {
      return Scaffold(body: _buildError(state.errorMessage!));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: state.feedItems.isEmpty
          ? _buildEmpty()
          : ListView.builder(
              itemCount: state.feedItems.length,
              itemBuilder: (context, index) =>
                  _buildFoodCard(state.feedItems[index]),
            ),
    );
  }
}
