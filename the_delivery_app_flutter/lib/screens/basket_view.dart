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
