import 'package:flutter/material.dart';

import '../models/food.dart';
import '../models/restaurant.dart';
import '../state/feed_state.dart';
import 'restaurant_view.dart';

class FeedView extends StatelessWidget {
  final FeedState state;
  final void Function(Food)? onAddToBasket;
  final VoidCallback? onRetry;
  final VoidCallback? onLoadMore;
  final VoidCallback? onDeals;
  final VoidCallback? onSearchTap;
  final VoidCallback? onSeeMap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onAddressTap;
  final String addressLabel;
  final List<Restaurant> featuredRestaurants;
  final double? userLat;
  final double? userLng;

  const FeedView({super.key, required this.state, this.onAddToBasket, this.onRetry, this.onLoadMore, this.onDeals, this.onSearchTap, this.onSeeMap, this.onProfileTap, this.onAddressTap, this.addressLabel = 'London, UK', this.featuredRestaurants = const [], this.userLat, this.userLng});

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onAddressTap,
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.deepOrange, size: 20),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Delivering to', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Row(
                          children: [
                            Flexible(
                              child: Text(addressLabel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), overflow: TextOverflow.ellipsis),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.keyboard_arrow_down, size: 18),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: onProfileTap,
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFFFFE0D0),
              child: Icon(Icons.person, color: Colors.deepOrange, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: onSearchTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Text('Search restaurants or dishes...', style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    return GestureDetector(
      onTap: onDeals,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Special Deals', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Text('Check out today\'s offers', style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            Icon(Icons.local_offer, color: Colors.white, size: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildNearYouCard(BuildContext context, Restaurant restaurant, List<Food> foods) {
    final imageUrl = foods.first.restaurantImageUrl.isNotEmpty
        ? foods.first.restaurantImageUrl
        : foods.first.imageUrl;
    final rating = foods.map((f) => f.rating).reduce((a, b) => a + b) / foods.length;
    final minutes = foods.first.deliveryTime.inMinutes;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: int.tryParse(restaurant.id) != null
          ? () => Navigator.push(context, MaterialPageRoute(
                builder: (_) => RestaurantView(restaurant: restaurant, onAddToBasket: onAddToBasket),
              ))
          : null,
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: imageUrl.isNotEmpty
                  ? (imageUrl.startsWith('http')
                      ? Image.network(imageUrl, width: 180, height: 110, fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(width: 180, height: 110, color: Colors.grey[200], child: const Icon(Icons.restaurant, color: Colors.deepOrange, size: 40)))
                      : Image.asset(imageUrl, width: 180, height: 110, fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(width: 180, height: 110, color: Colors.grey[200], child: const Icon(Icons.restaurant, color: Colors.deepOrange, size: 40))))
                  : Container(width: 180, height: 110, color: Colors.grey[200], child: const Icon(Icons.restaurant, color: Colors.deepOrange, size: 40)),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      Text(' ${rating.toStringAsFixed(1)}', style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 8),
                      const Icon(Icons.access_time, size: 14, color: Colors.grey),
                      Text(' $minutes min', style: const TextStyle(fontSize: 12, color: Colors.grey)),
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

  Widget _buildNearYouSection(BuildContext context, List<MapEntry<Restaurant, List<Food>>> groups) {
    if (groups.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Near You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              if (onSeeMap != null)
                ElevatedButton.icon(
                  onPressed: onSeeMap,
                  icon: const Icon(Icons.map, size: 16),
                  label: const Text('Show on map'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 195,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: groups.length,
            itemBuilder: (ctx, i) => _buildNearYouCard(ctx, groups[i].key, groups[i].value),
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantListTile(BuildContext context, Restaurant restaurant, List<Food> foods) {
    final imageUrl = foods.first.restaurantImageUrl.isNotEmpty
        ? foods.first.restaurantImageUrl
        : foods.first.imageUrl;
    final rating = foods.map((f) => f.rating).reduce((a, b) => a + b) / foods.length;
    final minutes = foods.first.deliveryTime.inMinutes;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: int.tryParse(restaurant.id) != null
          ? () => Navigator.push(context, MaterialPageRoute(
                builder: (_) => RestaurantView(restaurant: restaurant, onAddToBasket: onAddToBasket),
              ))
          : null,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageUrl.isNotEmpty
                  ? (imageUrl.startsWith('http')
                      ? Image.network(imageUrl, width: 70, height: 70, fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(width: 70, height: 70, color: Colors.grey[200], child: const Icon(Icons.restaurant, color: Colors.deepOrange)))
                      : Image.asset(imageUrl, width: 70, height: 70, fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(width: 70, height: 70, color: Colors.grey[200], child: const Icon(Icons.restaurant, color: Colors.deepOrange))))
                  : Container(width: 70, height: 70, color: Colors.grey[200], child: const Icon(Icons.restaurant, color: Colors.deepOrange)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      Text(' ${rating.toStringAsFixed(1)}', style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 8),
                      const Icon(Icons.access_time, size: 14, color: Colors.grey),
                      Text(' $minutes min', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildAllRestaurantsSection(BuildContext context, List<MapEntry<Restaurant, List<Food>>> groups) {
    if (groups.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Text('All Restaurants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ...groups.map((e) => _buildRestaurantListTile(context, e.key, e.value)),
        const SizedBox(height: 16),
      ],
    );
  }

  List<MapEntry<Restaurant, List<Food>>> _groupByRestaurant(List<Food> items) {
    final map = <String, MapEntry<Restaurant, List<Food>>>{};
    for (final food in items) {
      final id = food.restaurant.id;
      if (map.containsKey(id)) {
        map[id]!.value.add(food);
      } else {
        map[id] = MapEntry(food.restaurant, [food]);
      }
    }
    return map.values.toList();
  }

  List<MapEntry<Restaurant, List<Food>>> _sortByDistance(
    List<MapEntry<Restaurant, List<Food>>> groups,
  ) {
    if (userLat == null || userLng == null || featuredRestaurants.isEmpty) {
      return groups;
    }
    double? distanceFor(Restaurant r) {
      final match = featuredRestaurants.firstWhere(
        (f) => f.name == r.name,
        orElse: () => const Restaurant(id: '', name: ''),
      );
      if (match.latitude == null || match.longitude == null) return null;
      final dLat = match.latitude! - userLat!;
      final dLng = match.longitude! - userLng!;
      return dLat * dLat + dLng * dLng;
    }

    final sorted = List<MapEntry<Restaurant, List<Food>>>.from(groups);
    sorted.sort((a, b) {
      final da = distanceFor(a.key);
      final db = distanceFor(b.key);
      if (da == null && db == null) return 0;
      if (da == null) return 1;
      if (db == null) return -1;
      return da.compareTo(db);
    });
    return sorted;
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            const Text('Could not load feed.',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              TextButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (state.errorMessage != null) {
      return Scaffold(body: _buildError(state.errorMessage!));
    }
    final groups = _groupByRestaurant(state.feedItems);
    final nearYou = _sortByDistance(groups).take(5).toList();
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (onLoadMore != null &&
                notification.metrics.pixels >= notification.metrics.maxScrollExtent - 200) {
              onLoadMore!();
            }
            return false;
          },
          child: ListView(
            children: [
              _buildHeader(),
              _buildSearchBar(context),
              if (onDeals != null) _buildPromoBanner(context),
              _buildNearYouSection(context, nearYou),
              _buildAllRestaurantsSection(context, groups),
              if (state.isLoadingMore)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
