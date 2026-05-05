import 'package:flutter/material.dart';

import '../models/food.dart';
import '../state/feed_state.dart';

class FeedView extends StatelessWidget {
  final FeedState state;

  const FeedView({super.key, required this.state});

  Widget _buildFoodCard(Food food) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.fastfood, color: Colors.deepOrange),
        title: Text(food.name),
        subtitle: Text(food.restaurant.name),
        trailing: Text('\$${food.price.toStringAsFixed(2)}'),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(child: Text('No items in feed.'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.feedItems.isEmpty
              ? _buildEmpty()
              : ListView.builder(
                  itemCount: state.feedItems.length,
                  itemBuilder: (context, index) =>
                      _buildFoodCard(state.feedItems[index]),
                ),
    );
  }
}
