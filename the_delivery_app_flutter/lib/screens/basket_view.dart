import 'package:flutter/material.dart';

import '../models/food.dart';
import '../models/restaurant.dart';
import '../view_models/basket_view_model.dart';

class BasketView extends StatefulWidget {
  final BasketViewModel viewModel;

  const BasketView({super.key, required this.viewModel});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  bool _splitEnabled = false;
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Widget _buildQtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFFFE5DC),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: Colors.deepOrange),
      ),
    );
  }

  Widget _buildItemCard(Food food, int qty) {
    final imageUrl = food.imageUrl;
    Widget image;
    if (imageUrl.isNotEmpty) {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imageUrl.startsWith('http')
            ? Image.network(imageUrl, width: 48, height: 48, fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Icon(Icons.fastfood, color: Colors.deepOrange, size: 28))
            : Image.asset(imageUrl, width: 48, height: 48, fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Icon(Icons.fastfood, color: Colors.deepOrange, size: 28)),
      );
    } else {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 48,
          height: 48,
          color: Colors.grey[200],
          child: const Icon(Icons.fastfood, color: Colors.deepOrange, size: 28),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          image,
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(food.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                const SizedBox(height: 4),
                Text(
                  '£${(food.price * qty).toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.deepOrange),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildQtyButton(Icons.remove, () => widget.viewModel.removeItem(food)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              _buildQtyButton(Icons.add, () => widget.viewModel.addItem(food)),
            ],
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              for (var i = 0; i < qty; i++) {
                widget.viewModel.removeItem(food);
              }
            },
            child: const Icon(Icons.delete_outline, color: Colors.deepOrange, size: 20),
          ),
        ],
      ),
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
      listenable: widget.viewModel,
      builder: (context, _) {
        final items = widget.viewModel.getState().basket.items;
        if (items.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text('Your Cart')),
            body: _buildEmptyState(),
          );
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
