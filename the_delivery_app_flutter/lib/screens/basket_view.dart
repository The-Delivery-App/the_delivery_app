import 'package:flutter/material.dart';

import '../models/food.dart';
import '../view_models/basket_view_model.dart';

class BasketView extends StatelessWidget {
  final BasketViewModel viewModel;

  const BasketView({super.key, required this.viewModel});

  List<MapEntry<Food, int>> _groupItems(List<Food> items) {
    final map = <String, MapEntry<Food, int>>{};
    for (final food in items) {
      if (map.containsKey(food.id)) {
        map[food.id] = MapEntry(food, map[food.id]!.value + 1);
      } else {
        map[food.id] = MapEntry(food, 1);
      }
    }
    return map.values.toList();
  }

  Widget _placeholder() => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 56,
          height: 56,
          color: Colors.grey[200],
          child: const Icon(Icons.fastfood, color: Colors.deepOrange),
        ),
      );

  Widget _buildItem(Food food) {
    return ListTile(
      title: Text(food.name),
      subtitle: Text(food.restaurant.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '£${food.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.deepOrange,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => viewModel.removeItem(food),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingRow(String label, String value, {bool bold = false}) {
    final style = bold
        ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
        : const TextStyle(color: Colors.grey);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: style), Text(value, style: style)],
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_basket_outlined, size: 48, color: Colors.grey),
          SizedBox(height: 12),
          Text('Your basket is empty.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.getState();
        final items = state.basket.items;

        final total = items.fold(0.0, (sum, f) => sum + f.price);

        return Scaffold(
          appBar: AppBar(title: const Text('Basket')),
          body: items.isEmpty
              ? _buildEmptyState()
              : ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, _) =>
                      const Divider(height: 1, indent: 16, endIndent: 16),
                  itemBuilder: (context, index) => _buildItem(items[index]),
                ),
          bottomNavigationBar: items.isEmpty
              ? null
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${items.length} ${items.length == 1 ? 'item' : 'items'}',
                            style: const TextStyle(color: Colors.grey)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Total: £${total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Place Order'),
                                    content: const Text(
                                      'To place an order, please sign in and add a delivery address in your account.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text('Place Order'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
