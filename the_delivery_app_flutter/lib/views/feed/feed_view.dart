import 'package:flutter/material.dart';
import '../../dtos/food_dto.dart';
import '../../widgets/food_card.dart';
import '../food_item/food_item_view.dart';

// Hardcoded sample data until the backend feed endpoint is wired up.
final _sampleFeed = <FoodDTO>[
  FoodDTO(
    foodId: '1',
    name: 'Margherita Pizza',
    price: 10.99,
    rating: 4.7,
    tags: ['Italian', 'Vegetarian'],
    foodThumbnail: '',
    restaurantThumbnail: '',
    restaurantId: 'r1',
    restaurantName: 'Bella Napoli',
    recentOrders: 240,
    deliveryTimeMinutes: 25,
    unitType: 'item',
    size: 1,
    calories: 820,
    isDiscounted: false,
  ),
  FoodDTO(
    foodId: '2',
    name: 'Chicken Burger',
    price: 8.49,
    rating: 4.5,
    tags: ['Burgers', 'Chicken'],
    foodThumbnail: '',
    restaurantThumbnail: '',
    restaurantId: 'r2',
    restaurantName: 'Burger Barn',
    recentOrders: 189,
    deliveryTimeMinutes: 20,
    unitType: 'item',
    size: 1,
    calories: 650,
    isDiscounted: true,
  ),
  FoodDTO(
    foodId: '3',
    name: 'Pad Thai',
    price: 12.50,
    rating: 4.8,
    tags: ['Thai', 'Noodles'],
    foodThumbnail: '',
    restaurantThumbnail: '',
    restaurantId: 'r3',
    restaurantName: 'Thai Garden',
    recentOrders: 310,
    deliveryTimeMinutes: 30,
    unitType: 'item',
    size: 1,
    calories: 720,
    isDiscounted: false,
  ),
  FoodDTO(
    foodId: '4',
    name: 'Caesar Salad',
    price: 7.99,
    rating: 4.3,
    tags: ['Salad', 'Healthy'],
    foodThumbnail: '',
    restaurantThumbnail: '',
    restaurantId: 'r4',
    restaurantName: 'Green Bowl',
    recentOrders: 95,
    deliveryTimeMinutes: 15,
    unitType: 'item',
    size: 1,
    calories: 380,
    isDiscounted: false,
  ),
  FoodDTO(
    foodId: '5',
    name: 'Beef Tacos (x3)',
    price: 9.75,
    rating: 4.6,
    tags: ['Mexican', 'Beef'],
    foodThumbnail: '',
    restaurantThumbnail: '',
    restaurantId: 'r5',
    restaurantName: 'El Rancho',
    recentOrders: 210,
    deliveryTimeMinutes: 22,
    unitType: 'item',
    size: 3,
    calories: 540,
    isDiscounted: true,
  ),
];

final _filterLabels = [
  'All',
  'Burgers',
  'Pizza',
  'Thai',
  'Mexican',
  'Healthy',
  'Vegetarian',
];

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  int _selectedFilter = 0;
  String _searchQuery = '';

  // Applies the selected chip filter to the current feed data
  List<FoodDTO> get _filteredFeed {
    final byChip = _selectedFilter == 0
        ? _sampleFeed
        : _sampleFeed
              .where((f) => f.tags.contains(_filterLabels[_selectedFilter]))
              .toList();

    if (_searchQuery.trim().isEmpty) return byChip;

    final query = _searchQuery.toLowerCase().trim();
    return byChip.where((f) {
      final matchesName = f.name.toLowerCase().contains(query);
      final matchesRestaurant = f.restaurantName.toLowerCase().contains(query);
      final matchesTags = f.tags.any(
        (tag) => tag.toLowerCase().contains(query),
      );
      return matchesName || matchesRestaurant || matchesTags;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        // Sliver layout keeps header blocks and scrolling feed in one viewport
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(theme)),
            SliverToBoxAdapter(child: _buildSearchBar(theme)),
            SliverToBoxAdapter(child: _buildFilterChips(theme)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: Text(
                  'Popular near you',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Food card
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => FoodCard(
                  item: _filteredFeed[index],
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => FoodItemView(item: _filteredFeed[index]),
                    ),
                  ),
                ),
                childCount: _filteredFeed.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      // Top row with delivery location and profile shortcut
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 16,
                color: Color(0xFFFF5722),
              ),
              const SizedBox(width: 4),
              Text(
                'Manchester, UK',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFFF5722),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: Color(0xFFFF5722),
              ),
            ],
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFFF5722),
            child: const Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),

      // Inline search lives in Home and filters the visible feed
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          onChanged: (value) => setState(() => _searchQuery = value),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            hintText: 'Search restaurants or dishes...',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            suffixIcon: _searchQuery.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () => setState(() => _searchQuery = ''),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips(ThemeData theme) {
    return SizedBox(
      height: 52,
      // Horizontal category chips to filter visible feed items
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        itemCount: _filterLabels.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = _selectedFilter == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFFFF5722) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                _filterLabels[index],
                style: theme.textTheme.bodySmall?.copyWith(
                  color: selected ? Colors.white : Colors.black87,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
