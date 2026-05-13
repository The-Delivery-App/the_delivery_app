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

  List<Restaurant> _extractRestaurants(List<Food> results, String query) {
    final q = query.trim().toLowerCase();
    final seen = <String>{};
    return results
        .where((f) => f.restaurant.name.toLowerCase().contains(q) && seen.add(f.restaurant.id))
        .map((f) => f.restaurant)
        .toList();
  }

  Widget _buildRestaurantTile(BuildContext context, Restaurant restaurant) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.restaurant, color: Colors.white, size: 20),
      ),
      title: Text(restaurant.name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: const Text('Restaurant', style: TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: int.tryParse(restaurant.id) != null
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RestaurantView(
                    restaurant: restaurant,
                    onAddToBasket: widget.onAddToBasket,
                  ),
                ),
              )
          : null,
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
    final restaurants = _extractRestaurants(widget.state.results, widget.state.query);
    final foods = widget.state.results;
    final hasRestaurants = restaurants.isNotEmpty;
    final itemCount = (hasRestaurants ? 1 + restaurants.length : 0) +
        (foods.isNotEmpty ? 1 + foods.length : 0);
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (hasRestaurants) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text('Restaurants', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey)),
            );
          }
          if (index <= restaurants.length) {
            return _buildRestaurantTile(context, restaurants[index - 1]);
          }
          index -= 1 + restaurants.length;
        }
        if (index == 0) {
          return const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text('Food Items', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey)),
          );
        }
        return _buildResultTile(context, foods[index - 1]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search food...',
            border: InputBorder.none,
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      widget.onSearch('');
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            setState(() {});
            widget.onSearch(value);
          },
        ),
      ),
      body: _buildBody(),
    );
  }
}
