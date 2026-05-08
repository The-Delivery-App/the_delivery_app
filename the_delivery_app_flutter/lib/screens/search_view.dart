import 'package:flutter/material.dart';

import '../models/food.dart';
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      trailing: Text(
        '£${food.price.toStringAsFixed(2)}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.deepOrange,
        ),
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
    return ListView.separated(
      itemCount: widget.state.results.length,
      separatorBuilder: (_, _) =>
          const Divider(height: 1, indent: 16, endIndent: 16),
      itemBuilder: (context, index) =>
          _buildResultTile(context, widget.state.results[index]),
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
