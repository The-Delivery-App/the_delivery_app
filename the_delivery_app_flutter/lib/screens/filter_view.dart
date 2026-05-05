import 'package:flutter/material.dart';

import '../state/filter_state.dart';

class FilterView extends StatelessWidget {
  final FilterState state;

  const FilterView({super.key, required this.state});

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: items
              .map((label) => Chip(label: Text(label)))
              .toList(),
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          _buildSection('Food', state.foodFilters),
          _buildSection('Restaurants', state.restaurantFilters),
        ],
      ),
    );
  }
}
