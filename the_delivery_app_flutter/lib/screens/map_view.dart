import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../models/food.dart';
import '../models/restaurant.dart';
import '../state/map_state.dart';
import 'restaurant_view.dart';

class MapView extends StatefulWidget {
  final MapState state;
  final void Function(Food)? onAddToBasket;
  final double? addressLat;
  final double? addressLng;
  final int? orderStatusIndex;
  final List<String> orderStatuses;
  final String? courierName;
  final double? orderRestaurantLat;
  final double? orderRestaurantLng;
  final VoidCallback? onDismissOrder;

  const MapView({super.key, required this.state, this.onAddToBasket, this.addressLat, this.addressLng, this.orderStatusIndex, this.orderStatuses = const [], this.courierName, this.orderRestaurantLat, this.orderRestaurantLng, this.onDismissOrder});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController _mapController = MapController();
  List<LatLng> _routePoints = [];

  Future<void> _loadRoute(double destLat, double destLng) async {
    final fromLat = widget.addressLat;
    final fromLng = widget.addressLng;
    if (fromLat == null || fromLng == null) return;
    try {
      final url = Uri.parse(
        'https://router.project-osrm.org/route/v1/foot/$fromLng,$fromLat;$destLng,$destLat?overview=full&geometries=geojson',
      );
      final response = await http.get(url);
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final routes = data['routes'] as List<dynamic>?;
      if (routes == null || routes.isEmpty) return;
      final coords = routes.first['geometry']['coordinates'] as List<dynamic>;
      final points = coords.map((c) {
        final pair = c as List<dynamic>;
        return LatLng(pair[1] as double, pair[0] as double);
      }).toList();
      if (!mounted) return;
      setState(() => _routePoints = points);
    } catch (_) {}
  }

  Widget _buildMap() {
    final location = widget.state.currentLocation;
    final addressLat = widget.addressLat;
    final addressLng = widget.addressLng;
    LatLng center;
    if (addressLat != null && addressLng != null) {
      center = LatLng(addressLat, addressLng);
    } else if (location != null) {
      center = LatLng(location.latitude, location.longitude);
    } else {
      center = const LatLng(51.5074, -0.1278);
    }

    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(initialCenter: center, initialZoom: 14),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.the_delivery_app',
              ),
          if (_routePoints.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: _routePoints,
                  strokeWidth: 4,
                  color: Colors.deepOrange,
                ),
              ],
            ),
          MarkerLayer(
            markers: [
              for (final r in widget.state.restaurants)
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
              if (addressLat != null && addressLng != null)
                Marker(
                  point: LatLng(addressLat, addressLng),
                  width: 50,
                  height: 50,
                  child: const Icon(Icons.home, color: Colors.green, size: 36),
                ),
            ],
          ),
            ],
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Column(
              children: [
                _zoomButton(Icons.add, () {
                  _mapController.move(_mapController.camera.center, _mapController.camera.zoom + 1);
                }),
                const SizedBox(height: 6),
                _zoomButton(Icons.remove, () {
                  _mapController.move(_mapController.camera.center, _mapController.camera.zoom - 1);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _zoomButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, color: Colors.black87, size: 20),
        ),
      ),
    );
  }

  Widget _buildRestaurantTile(BuildContext context, Restaurant restaurant) {
    return Container(
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
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RestaurantView(restaurant: restaurant, onAddToBasket: widget.onAddToBasket),
                ),
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
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.map, color: Colors.deepOrange),
            tooltip: 'Show on map',
            onPressed: () {
              final lat = restaurant.latitude;
              final lng = restaurant.longitude;
              if (lat != null && lng != null) {
                _mapController.move(LatLng(lat, lng), 15);
                _loadRoute(lat, lng);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${restaurant.name} has no location data'), duration: const Duration(seconds: 2)),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  List<Restaurant> _sortedRestaurants() {
    final list = List<Restaurant>.from(widget.state.restaurants);
    final lat = widget.addressLat;
    final lng = widget.addressLng;
    if (lat == null || lng == null) return list;
    double? distFor(Restaurant r) {
      if (r.latitude == null || r.longitude == null) return null;
      final dLat = r.latitude! - lat;
      final dLng = r.longitude! - lng;
      return dLat * dLat + dLng * dLng;
    }
    list.sort((a, b) {
      final da = distFor(a);
      final db = distFor(b);
      if (da == null && db == null) return 0;
      if (da == null) return 1;
      if (db == null) return -1;
      return da.compareTo(db);
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final sorted = _sortedRestaurants();
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
          if (widget.orderStatusIndex != null) _buildTrackingPanel(),
          const SizedBox(height: 8),
          Expanded(
            child: sorted.isEmpty
                ? const Center(child: Text('No restaurants nearby.'))
                : ListView.builder(
                    itemCount: sorted.length,
                    itemBuilder: (context, index) =>
                        _buildRestaurantTile(context, sorted[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingPanel() {
    final idx = widget.orderStatusIndex ?? 0;
    final statusText = idx < widget.orderStatuses.length ? widget.orderStatuses[idx] : '';
    final isDelivered = idx >= widget.orderStatuses.length - 1;
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepOrange),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.delivery_dining, color: Colors.deepOrange),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Courier: ${widget.courierName ?? "Assigning..."}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              if (isDelivered && widget.onDismissOrder != null)
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: widget.onDismissOrder,
                  tooltip: 'Close',
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(statusText, style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: (idx + 1) / widget.orderStatuses.length,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation(Colors.deepOrange),
          ),
        ],
      ),
    );
  }
}
