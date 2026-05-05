import 'package:flutter/material.dart';

import '../APIs/restaurant_api_service.dart';
import '../main.dart';
import '../models/food.dart';
import '../models/restaurant.dart';
import '../repositories/restaurant_repository.dart';
import '../view_models/restaurant_view_model.dart';

class RestaurantView extends StatefulWidget {
  final Restaurant restaurant;
  final void Function(Food)? onAddToBasket;

  const RestaurantView({super.key, required this.restaurant, this.onAddToBasket});

  @override
  State<RestaurantView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  late final RestaurantViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = RestaurantViewModel(
      repository: RestaurantRepository(
        apiService: RestaurantAPIService(client: client),
      ),
    );
    _viewModel.loadMenu(widget.restaurant.id);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _buildMenuItem(Food food) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: const Icon(Icons.fastfood, color: Colors.deepOrange, size: 32),
          title: Text(food.name, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              '${food.calories} kcal  ·  ⭐ ${food.rating.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
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
              if (widget.onAddToBasket != null) ...[
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart, color: Colors.deepOrange),
                  onPressed: () => widget.onAddToBasket!(food),
                  tooltip: 'Add to basket',
                ),
              ],
            ],
          ),
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
      ],
    );
  }

  Widget _buildMenuHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        'Menu',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.restaurant_menu, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            const Text(
              'Could not load menu.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => _viewModel.loadMenu(widget.restaurant.id),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_menu, size: 48, color: Colors.grey),
          SizedBox(height: 12),
          Text('No menu items yet.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.restaurant.name)),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          final state = _viewModel.getState();
          if (state.isLoading) return _buildLoading();
          if (state.errorMessage != null) return _buildError(state.errorMessage!);
          if (state.menuItems.isEmpty) return _buildEmpty();
          return ListView.builder(
            itemCount: state.menuItems.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) return _buildMenuHeader();
              return _buildMenuItem(state.menuItems[index - 1]);
            },
          );
        },
      ),
    );
  }
}
