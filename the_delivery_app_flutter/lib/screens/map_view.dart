import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/food.dart';
import '../models/restaurant.dart';
import '../state/map_state.dart';
import 'restaurant_view.dart';

class MapView extends StatelessWidget {
  final MapState state;
  final void Function(Food)? onAddToBasket;

  const MapView({super.key, required this.state, this.onAddToBasket});

  Widget _buildMap() {
    final location = state.currentLocation;
    final center = location != null
        ? LatLng(location.latitude, location.longitude)
        : const LatLng(51.5074, -0.1278);

    return SizedBox(
      height: 300,
      child: FlutterMap(
        options: MapOptions(initialCenter: center, initialZoom: 14),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.the_delivery_app',
          ),
          if (location != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(location.latitude, location.longitude),
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.my_location, color: Colors.blue, size: 32),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildRestaurantTile(BuildContext context, Restaurant restaurant) {
    return ListTile(
      leading: const Icon(Icons.restaurant, color: Colors.deepOrange),
      title: Text(restaurant.name),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RestaurantView(restaurant: restaurant, onAddToBasket: onAddToBasket),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        title: const Text('Map', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFAF7F2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildMap(),
          const SizedBox(height: 8),
          Expanded(
            child: state.restaurants.isEmpty
                ? const Center(child: Text('No restaurants nearby.'))
                : ListView.builder(
                    itemCount: state.restaurants.length,
                    itemBuilder: (context, index) =>
                        _buildRestaurantTile(context, state.restaurants[index]),
                  ),
          ),
        ],
      ),
    );
  }
}
