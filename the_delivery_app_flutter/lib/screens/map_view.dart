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
          MarkerLayer(
            markers: [
              for (final r in state.restaurants)
                if (r.latitude != null && r.longitude != null)
                  Marker(
                    point: LatLng(r.latitude!, r.longitude!),
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_on, color: Colors.deepOrange, size: 36),
                  ),
              if (location != null)
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RestaurantView(restaurant: restaurant, onAddToBasket: onAddToBasket),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundColor: Color(0xFFFFE5DC),
              child: Icon(Icons.restaurant, color: Colors.deepOrange),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(restaurant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
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
