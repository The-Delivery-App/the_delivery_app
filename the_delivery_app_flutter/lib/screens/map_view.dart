import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../state/map_state.dart';

class MapView extends StatelessWidget {
  final MapState state;

  const MapView({super.key, required this.state});

  Widget _buildMapPlaceholder() {
    final location = state.currentLocation;
    final locationText = location == null
        ? 'Location not available'
        : 'Lat: ${location.latitude.toStringAsFixed(4)}, '
            'Lng: ${location.longitude.toStringAsFixed(4)}';

    return Container(
      height: 260,
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.map, size: 60, color: Colors.grey),
            const SizedBox(height: 8),
            Text(locationText,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantTile(Restaurant restaurant) {
    return ListTile(
      leading: const Icon(Icons.restaurant, color: Colors.deepOrange),
      title: Text(restaurant.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Column(
        children: [
          _buildMapPlaceholder(),
          const Divider(),
          Expanded(
            child: state.restaurants.isEmpty
                ? const Center(child: Text('No restaurants nearby.'))
                : ListView.builder(
                    itemCount: state.restaurants.length,
                    itemBuilder: (context, index) =>
                        _buildRestaurantTile(state.restaurants[index]),
                  ),
          ),
        ],
      ),
    );
  }
}
