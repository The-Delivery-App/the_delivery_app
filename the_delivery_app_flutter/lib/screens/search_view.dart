import 'package:flutter/material.dart';

import '../models/food.dart';
import '../state/search_state.dart';

class SearchView extends StatefulWidget {
  final SearchState state;
  final ValueChanged<String> onSearch;

  const SearchView({super.key, required this.state, required this.onSearch});

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

  Widget _buildResultTile(Food food) {
    return ListTile(
      leading: const Icon(Icons.fastfood, color: Colors.deepOrange),
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
      return const Center(child: Text('Type to search for food.'));
    }
    if (widget.state.results.isEmpty) {
      return const Center(child: Text('No results found.'));
    }
    return ListView.builder(
      itemCount: widget.state.results.length,
      itemBuilder: (context, index) =>
          _buildResultTile(widget.state.results[index]),
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
