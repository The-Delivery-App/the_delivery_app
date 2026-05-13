import 'package:flutter/material.dart';

import '../models/food.dart';
import '../models/restaurant.dart';
import '../state/search_state.dart';
import 'restaurant_view.dart';

class SearchView extends StatefulWidget {
  final SearchState state;
  final ValueChanged<String> onSearch;
  final void Function(Food)? onAddToBasket;

  const SearchView({super.key, required this.state, required this.onSearch, this.onAddToBasket});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();
  String _selectedCategory = 'All';

  static const _categories = ['All', 'Burgers', 'Pizza', 'Sushi', 'Healthy'];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _matchesCategory(Food food, String category) {
    if (category == 'All') return true;
    final name = food.name.toLowerCase();
    switch (category) {
      case 'Burgers':
        return name.contains('burger');
      case 'Pizza':
        return name.contains('pizza');
      case 'Sushi':
        return name.contains('sushi') || name.contains('roll') || name.contains('sashimi');
      case 'Healthy':
        return name.contains('salad') || name.contains('bowl') || name.contains('smoothie');
      default:
        return true;
    }
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search food...',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {});
                widget.onSearch(value);
              },
            ),
          ),
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () {
                _controller.clear();
                widget.onSearch('');
                setState(() {});
              },
            ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _selectedCategory = label),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Colors.deepOrange : Colors.grey[300]!,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                const Icon(Icons.check, size: 16, color: Colors.deepOrange),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.deepOrange : Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: _categories.map(_buildFilterChip).toList(),
      ),
    );
  }

  Widget _buildRestaurantCard(BuildContext context, Restaurant restaurant, List<Food> foods) {
    final imageUrl = foods.first.restaurantImageUrl.isNotEmpty
        ? foods.first.restaurantImageUrl
        : foods.first.imageUrl;
    final rating = foods.map((f) => f.rating).reduce((a, b) => a + b) / foods.length;
    final minutes = foods.first.deliveryTime.inMinutes;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: int.tryParse(restaurant.id) != null
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RestaurantView(restaurant: restaurant, onAddToBasket: widget.onAddToBasket),
                ),
              )
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: imageUrl.isNotEmpty
                  ? (imageUrl.startsWith('http')
                      ? Image.network(imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(height: 160, color: Colors.grey[200], child: const Icon(Icons.restaurant, color: Colors.deepOrange, size: 48)))
                      : Image.asset(imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(height: 160, color: Colors.grey[200], child: const Icon(Icons.restaurant, color: Colors.deepOrange, size: 48))))
                  : Container(height: 160, color: Colors.grey[200], child: const Icon(Icons.restaurant, color: Colors.deepOrange, size: 48)),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(restaurant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 2),
                      Text(rating.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.grey, size: 14),
                      Text(' $minutes min', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                      const SizedBox(width: 12),
                      const Icon(Icons.delivery_dining, color: Colors.grey, size: 14),
                      const Text(' £1.99 delivery', style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDishCard(BuildContext context, Food food) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: food.imageUrl.isNotEmpty
                ? (food.imageUrl.startsWith('http')
                    ? Image.network(food.imageUrl, width: 60, height: 60, fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.deepOrange)))
                    : Image.asset(food.imageUrl, width: 60, height: 60, fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.deepOrange))))
                : Container(width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.deepOrange)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(food.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(food.restaurant.name, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          Text(
            '£${food.price.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultTile(BuildContext context, Food food) {
    return ListTile(
      onTap: int.tryParse(food.restaurant.id) != null
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RestaurantView(
                    restaurant: food.restaurant,
                    onAddToBasket: widget.onAddToBasket,
                  ),
                ),
              )
          : null,
      leading: food.imageUrl.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: food.imageUrl.startsWith('http')
                  ? Image.network(food.imageUrl, width: 40, height: 40, fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const Icon(Icons.fastfood, color: Colors.deepOrange))
                  : Image.asset(food.imageUrl, width: 40, height: 40, fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const Icon(Icons.fastfood, color: Colors.deepOrange)),
            )
          : const Icon(Icons.fastfood, color: Colors.deepOrange),
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
    );
  }

  Widget _buildBody() {
    if (widget.state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (widget.state.query.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 48, color: Colors.grey),
            SizedBox(height: 12),
            Text('Type to search for food.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }
    if (widget.state.results.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey),
            SizedBox(height: 12),
            Text('No results found.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }
    final foods = widget.state.results.where((f) => _matchesCategory(f, _selectedCategory)).toList();
    final grouped = <String, MapEntry<Restaurant, List<Food>>>{};
    for (final food in foods) {
      if (grouped.containsKey(food.restaurant.id)) {
        grouped[food.restaurant.id]!.value.add(food);
      } else {
        grouped[food.restaurant.id] = MapEntry(food.restaurant, [food]);
      }
    }
    final restaurants = grouped.values.toList();

    return ListView(
      children: [
        if (restaurants.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text('Restaurants', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          ...restaurants.map((e) => _buildRestaurantCard(context, e.key, e.value)),
        ],
        if (foods.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text('Dishes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          ...foods.map((f) => _buildDishCard(context, f)),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Search', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryFilters(),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }
}
