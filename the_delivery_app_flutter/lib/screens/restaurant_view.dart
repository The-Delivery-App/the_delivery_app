import 'package:flutter/material.dart';

import '../APIs/restaurant_api_service.dart';
import '../main.dart';
import '../models/food.dart';
import '../models/restaurant.dart';
import '../repositories/restaurant_repository.dart';
import '../view_models/restaurant_view_model.dart';

class RestaurantView extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantView({super.key, required this.restaurant});

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
    return ListTile(
      leading: const Icon(Icons.fastfood, color: Colors.deepOrange),
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
      child: Text(
        widget.restaurant.name,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                    const SizedBox(height: 12),
                    const Text('Could not load menu.',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(state.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            );
          }

          if (state.menuItems.isEmpty) {
            return const Center(child: Text('No menu items available.'));
          }

          return ListView.builder(
            itemCount: state.menuItems.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) return _buildHeader();
              return _buildMenuItem(state.menuItems[index - 1]);
            },
          );
        },
      ),
    );
  }
}
