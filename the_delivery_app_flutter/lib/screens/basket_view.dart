import 'package:flutter/material.dart';

import '../models/food.dart';
import '../view_models/basket_view_model.dart';

class BasketView extends StatelessWidget {
  final BasketViewModel viewModel;

  const BasketView({super.key, required this.viewModel});

  Widget _buildItem(Food food) {
    return ListTile(
      title: Text(food.name),
      subtitle: Text(food.restaurant.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('£${food.price.toStringAsFixed(2)}'),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => viewModel.removeItem(food),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text('Your basket is empty.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.getState();
        final items = state.basket.items;

        return Scaffold(
          appBar: AppBar(title: const Text('Basket')),
          body: items.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => _buildItem(items[index]),
                ),
        );
      },
    );
  }
}
