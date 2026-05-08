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

  const FeedView({super.key, required this.state, this.onAddToBasket, this.onRetry, this.onLoadMore, this.onDeals});

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

  Widget _buildCompactFoodCard(BuildContext context, Food food) {
    return SizedBox(
      width: 140,
      child: Card(
        margin: const EdgeInsets.only(right: 10, bottom: 8, top: 4),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onAddToBasket != null ? () {
            onAddToBasket!(food);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${food.name} added to basket'),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.deepOrange,
            ));
          } : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: food.imageUrl.isNotEmpty
                    ? (food.imageUrl.startsWith('http')
                        ? Image.network(food.imageUrl, width: 140, height: 90, fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => const SizedBox(height: 90, child: Center(child: Icon(Icons.fastfood, color: Colors.deepOrange))))
                        : Image.asset(food.imageUrl, width: 140, height: 90, fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => const SizedBox(height: 90, child: Center(child: Icon(Icons.fastfood, color: Colors.deepOrange)))))
                    : const SizedBox(height: 90, child: Center(child: Icon(Icons.fastfood, color: Colors.deepOrange))),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(food.name, maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text('£${food.price.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantHeader(BuildContext context, Restaurant restaurant) {
    final hasValidId = int.tryParse(restaurant.id) != null;
    return InkWell(
      onTap: hasValidId
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RestaurantView(
                    restaurant: restaurant,
                    onAddToBasket: onAddToBasket,
                  ),
                ),
              )
          : null,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.deepOrange,
              child: Icon(Icons.restaurant, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                restaurant.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const Text('View all', style: TextStyle(fontSize: 12, color: Colors.deepOrange)),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: Colors.deepOrange, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fastfood, size: 48, color: Colors.grey),
          SizedBox(height: 12),
          Text('No items in feed.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
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
    final appBar = AppBar(
      title: const Text('Home'),
      actions: [
        if (onDeals != null)
          IconButton(
            icon: const Icon(Icons.local_offer_outlined),
            tooltip: 'Deals',
            onPressed: onDeals,
          ),
      ],
    );
    if (state.isLoading) {
      return Scaffold(
        appBar: appBar,
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (state.errorMessage != null) {
      return Scaffold(appBar: appBar, body: _buildError(state.errorMessage!));
    }
    return Scaffold(
      appBar: appBar,
      body: state.feedItems.isEmpty
          ? _buildEmpty()
          : NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (onLoadMore != null &&
                    notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent - 200) {
                  onLoadMore!();
                }
                return false;
              },
              child: Builder(builder: (context) {
                final groups = _groupByRestaurant(state.feedItems);
                return ListView.builder(
                  itemCount: groups.length + (state.isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == groups.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final entry = groups[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRestaurantHeader(context, entry.key),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: entry.value.length,
                            itemBuilder: (ctx, i) =>
                                _buildCompactFoodCard(ctx, entry.value[i]),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
            ),
    );
  }
}
