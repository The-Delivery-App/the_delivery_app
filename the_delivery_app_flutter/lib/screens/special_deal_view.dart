import 'package:flutter/material.dart';

import '../models/food.dart';
import '../state/special_deal_state.dart';

class SpecialDealView extends StatelessWidget {
  final SpecialDealState state;

  const SpecialDealView({super.key, required this.state});

  Widget _buildDealCard(Food food) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: food.imageUrl.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  food.imageUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.local_offer, color: Colors.deepOrange),
                ),
              )
            : const Icon(Icons.local_offer, color: Colors.deepOrange),
        title: Text(food.name),
        subtitle: Text(food.restaurant.name),
        trailing: Text(
          '£${food.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.deepOrange,
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(child: Text('No special deals available.'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Special Deals')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.deals.isEmpty
              ? _buildEmpty()
              : ListView.builder(
                  itemCount: state.deals.length,
                  itemBuilder: (context, index) =>
                      _buildDealCard(state.deals[index]),
                ),
    );
  }
}
