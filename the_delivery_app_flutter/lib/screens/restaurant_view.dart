import 'dart:convert';

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
  String? _cuisine;
  int? _deliveryMinutes;
  List<Map<String, dynamic>> _reviews = [];
  bool _isFavourited = false;

  @override
  void initState() {
    super.initState();
    _viewModel = RestaurantViewModel(
      repository: RestaurantRepository(
        apiService: RestaurantAPIService(client: client),
      ),
    );
    _viewModel.loadMenu(widget.restaurant.id, widget.restaurant.name);
    _loadDetails();
    _loadReviews();
  }

  Future<void> _loadDetails() async {
    final id = int.tryParse(widget.restaurant.id);
    if (id == null) return;
    try {
      final raw = await client.restaurantController.getRestaurant(id);
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      if (decoded['success'] != true) return;
      final r = decoded['restaurant'] as Map<String, dynamic>;
      if (mounted) {
        setState(() {
          _cuisine = r['cuisine'] as String?;
          _deliveryMinutes = (r['estimatedDeliveryTime'] as num?)?.round();
        });
      }
    } catch (_) {}
  }

  Future<void> _toggleFavourite() async {
    final id = int.tryParse(widget.restaurant.id);
    if (id == null) return;
    setState(() => _isFavourited = !_isFavourited);
    try {
      await client.favouritesController.addFavourite(
        jsonEncode({'restaurantId': id}),
      );
    } catch (_) {}
  }

  Future<void> _loadReviews() async {
    final id = int.tryParse(widget.restaurant.id);
    if (id == null) return;
    try {
      final raw = await client.restaurantController.getReviews(id, 10, 0);
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      if (decoded['success'] != true) return;
      final list = (decoded['reviews'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .toList();
      if (mounted) setState(() => _reviews = list);
    } catch (_) {}
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
          leading: food.imageUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: food.imageUrl.startsWith('http')
                      ? Image.network(food.imageUrl, width: 48, height: 48, fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Icon(Icons.fastfood, color: Colors.deepOrange, size: 32))
                      : Image.asset(food.imageUrl, width: 48, height: 48, fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Icon(Icons.fastfood, color: Colors.deepOrange, size: 32)),
                )
              : const Icon(Icons.fastfood, color: Colors.deepOrange, size: 32),
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
                  onPressed: () {
                    widget.onAddToBasket!(food);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${food.name} added to basket'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.deepOrange,
                      ),
                    );
                  },
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
    final details = [
      if (_cuisine != null) _cuisine!,
      if (_deliveryMinutes != null) '$_deliveryMinutes min',
    ].join('  ·  ');

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Menu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (details.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(details, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ],
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
              onPressed: () => _viewModel.loadMenu(widget.restaurant.id, widget.restaurant.name),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text('Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    final rating = (review['rating'] as num?)?.toDouble() ?? 0;
    final userName = review['userName'] as String? ?? 'Anonymous';
    final comment = review['comment'] as String? ?? '';
    final foodName = review['foodItemName'] as String? ?? '';
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: const Icon(Icons.person, color: Colors.grey, size: 32),
          title: Row(
            children: [
              Text(userName, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              Text('⭐ ${rating.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (foodName.isNotEmpty)
                Text(foodName, style: const TextStyle(fontSize: 12, color: Colors.deepOrange)),
              if (comment.isNotEmpty) Text(comment),
            ],
          ),
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
      ],
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
      appBar: AppBar(
        title: Text(widget.restaurant.name),
        actions: [
          IconButton(
            icon: Icon(
              _isFavourited ? Icons.favorite : Icons.favorite_border,
              color: Colors.deepOrange,
            ),
            tooltip: 'Favourite',
            onPressed: _toggleFavourite,
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          final state = _viewModel.getState();
          if (state.isLoading) return _buildLoading();
          if (state.errorMessage != null) return _buildError(state.errorMessage!);
          if (state.menuItems.isEmpty) return _buildEmpty();
          final menuCount = state.menuItems.length;
          final hasReviews = _reviews.isNotEmpty;
          final itemCount = 1 + menuCount + (hasReviews ? 1 + _reviews.length : 0);
          return ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index == 0) return _buildMenuHeader();
              if (index <= menuCount) return _buildMenuItem(state.menuItems[index - 1]);
              if (index == menuCount + 1) return _buildReviewsHeader();
              return _buildReviewItem(_reviews[index - menuCount - 2]);
            },
          );
        },
      ),
    );
  }
}
