import 'package:flutter/material.dart';

import '../models/food.dart';
import '../state/search_state.dart';

class SearchView extends StatelessWidget {
  final SearchState state;
  final ValueChanged<String> onSearch;

  const SearchView({super.key, required this.state, required this.onSearch});

  Widget _buildResultTile(Food food) {
    return ListTile(
      leading: const Icon(Icons.fastfood, color: Colors.deepOrange),
      title: Text(food.name),
      subtitle: Text(food.restaurant.name),
      trailing: Text('\$${food.price.toStringAsFixed(2)}'),
    );
  }

  Widget _buildBody() {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.query.isEmpty) {
      return const Center(child: Text('Type to search for food.'));
    }
    if (state.results.isEmpty) {
      return const Center(child: Text('No results found.'));
    }
    return ListView.builder(
      itemCount: state.results.length,
      itemBuilder: (context, index) => _buildResultTile(state.results[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search food...',
            border: InputBorder.none,
          ),
          onSubmitted: onSearch,
        ),
      ),
      body: _buildBody(),
    );
  }
}
