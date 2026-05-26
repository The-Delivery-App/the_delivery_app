import 'package:flutter/material.dart';

import '../models/food.dart';
import '../models/food_sort_rule.dart';
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
  final FoodSortRule? sortRule;
  final String? priceTier;
  final bool onlyDiscounted;
  final VoidCallback? onFilterTap;
  final VoidCallback? onClearFilters;

  const FeedView({super.key, required this.state, this.onAddToBasket, this.onRetry, this.onLoadMore, this.onDeals, this.onSearchTap, this.onSeeMap, this.onProfileTap, this.onAddressTap, this.addressLabel = 'London, UK', this.featuredRestaurants = const [], this.userLat, this.userLng, this.sortRule, this.priceTier, this.onlyDiscounted = false, this.onFilterTap, this.onClearFilters});

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
    final imageUrl = foods.isEmpty
        ? ''
        : (foods.first.restaurantImageUrl.isNotEmpty ? foods.first.restaurantImageUrl : foods.first.imageUrl);
    final rating = foods.isEmpty ? 0.0 : foods.map((f) => f.rating).reduce((a, b) => a + b) / foods.length;
    final minutes = foods.isEmpty ? 30 : foods.first.deliveryTime.inMinutes;

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

  Widget _buildNearYouSection(BuildContext context, List<MapEntry<Restaurant, List<Food>>> groups, {bool isRanking = false}) {
    if (groups.isEmpty && !isRanking) return const SizedBox.shrink();
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
          child: isRanking
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.deepOrange),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Finding the closest restaurants to your address...',
                        style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
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

  Widget _buildAllRestaurantsSection(BuildContext context, List<MapEntry<Restaurant, List<Food>>> groups, List<Food> filteredFood, {VoidCallback? onClearFilters}) {
    final hasFilters = sortRule != null || priceTier != null || onlyDiscounted;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hasFilters ? 'Filtered Foods' : 'All Restaurants', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              if (onFilterTap != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      onPressed: onFilterTap,
                      icon: Icon(Icons.tune, size: 16, color: hasFilters ? Colors.white : Colors.deepOrange),
                      label: Text(hasFilters ? 'Filters on' : 'Filter'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hasFilters ? Colors.deepOrange : Colors.white,
                        foregroundColor: hasFilters ? Colors.white : Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        side: const BorderSide(color: Colors.deepOrange),
                        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    if (hasFilters && onClearFilters != null)
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.deepOrange, size: 20),
                        tooltip: 'Clear filters',
                        onPressed: onClearFilters,
                      ),
                  ],
                ),
            ],
          ),
        ),
        if (hasFilters)
          if (filteredFood.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                children: [
                  const Icon(Icons.search_off, size: 48, color: Colors.grey),
                  const SizedBox(height: 8),
                  const Text('No foods match your filters.', style: TextStyle(color: Colors.grey)),
                  if (onClearFilters != null) ...[
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: onClearFilters,
                      child: const Text('Clear filters', style: TextStyle(color: Colors.deepOrange)),
                    ),
                  ],
                ],
              ),
            )
          else
            ...filteredFood.map((f) => _buildFoodTile(context, f))
        else
          ...groups.map((e) => _buildRestaurantListTile(context, e.key, e.value)),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFoodTile(BuildContext context, Food food) {
    return GestureDetector(
      onTap: int.tryParse(food.restaurant.id) != null
          ? () => Navigator.push(context, MaterialPageRoute(
                builder: (_) => RestaurantView(restaurant: food.restaurant, onAddToBasket: onAddToBasket),
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
              borderRadius: BorderRadius.circular(8),
              child: food.imageUrl.isNotEmpty
                  ? (food.imageUrl.startsWith('http')
                      ? Image.network(food.imageUrl, width: 60, height: 60, fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.deepOrange)))
                      : Image.asset(food.imageUrl, width: 60, height: 60, fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.deepOrange))))
                  : Container(width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.deepOrange)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(food.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(food.restaurant.name, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 12, color: Colors.amber),
                      Text(' ${food.rating.toStringAsFixed(1)}', style: const TextStyle(fontSize: 11)),
                      const SizedBox(width: 8),
                      Text('£${food.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.deepOrange)),
                    ],
                  ),
                ],
              ),
            ),
            if (onAddToBasket != null)
              IconButton(
                icon: const Icon(Icons.add_shopping_cart, color: Colors.deepOrange),
                onPressed: () {
                  onAddToBasket!(food);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${food.name} added to basket'), duration: const Duration(seconds: 1), backgroundColor: Colors.deepOrange));
                },
              ),
          ],
        ),
      ),
    );
  }

  List<Food> _applyFilter(List<Food> items) {
    var filtered = items;
    if (onlyDiscounted) {
      filtered = filtered.where((f) => f.isDiscounted).toList();
    }
    if (priceTier != null && filtered.isNotEmpty) {
      final prices = filtered.map((f) => f.price).toList()..sort();
      final q1 = prices[(prices.length * 0.25).floor()];
      final q3 = prices[(prices.length * 0.75).floor()];
      if (priceTier == 'low') {
        filtered = filtered.where((f) => f.price <= q1).toList();
      } else if (priceTier == 'mid') {
        filtered = filtered.where((f) => f.price > q1 && f.price < q3).toList();
      } else if (priceTier == 'high') {
        filtered = filtered.where((f) => f.price >= q3).toList();
      }
    }
    return filtered;
  }

  List<Food> _applySort(List<Food> items) {
    if (sortRule == null) return items;
    final sorted = List<Food>.from(items);
    switch (sortRule!) {
      case FoodSortRule.priceLowToHigh:
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case FoodSortRule.priceHighToLow:
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case FoodSortRule.rating:
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case FoodSortRule.recentOrdersFirst:
        sorted.sort((a, b) => b.recentOrders.compareTo(a.recentOrders));
        break;
      case FoodSortRule.recentOrdersLast:
        sorted.sort((a, b) => a.recentOrders.compareTo(b.recentOrders));
        break;
      case FoodSortRule.distanceClosestFirst:
        sorted.sort((a, b) => a.deliveryTime.compareTo(b.deliveryTime));
        break;
      case FoodSortRule.distanceFarthestFirst:
        sorted.sort((a, b) => b.deliveryTime.compareTo(a.deliveryTime));
        break;
    }
    return sorted;
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

  List<MapEntry<Restaurant, List<Food>>> _nearYouFromFeatured(
    List<MapEntry<Restaurant, List<Food>>> feedGroups,
  ) {
    if (userLat == null || userLng == null) return [];
    final sortedFeatured = List<Restaurant>.from(featuredRestaurants);
    sortedFeatured.sort((a, b) {
      double? distFor(Restaurant r) {
        if (r.latitude == null || r.longitude == null) return null;
        final dLat = r.latitude! - userLat!;
        final dLng = r.longitude! - userLng!;
        return dLat * dLat + dLng * dLng;
      }
      final da = distFor(a);
      final db = distFor(b);
      if (da == null && db == null) return 0;
      if (da == null) return 1;
      if (db == null) return -1;
      return da.compareTo(db);
    });
    return sortedFeatured.take(5).map((restaurant) {
      final match = feedGroups.firstWhere(
        (g) => g.key.name == restaurant.name,
        orElse: () => MapEntry(restaurant, <Food>[]),
      );
      return MapEntry(restaurant, match.value);
    }).toList();
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
    final filteredFood = _applyFilter(state.feedItems);
    final sortedFood = _applySort(filteredFood);
    final groups = _groupByRestaurant(sortedFood);
    final canRank = userLat != null && userLng != null && featuredRestaurants.isNotEmpty;
    final nearYou = canRank ? _nearYouFromFeatured(groups) : <MapEntry<Restaurant, List<Food>>>[];
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
              _buildNearYouSection(context, nearYou, isRanking: !canRank),
              _buildAllRestaurantsSection(context, groups, sortedFood, onClearFilters: onClearFilters),
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
