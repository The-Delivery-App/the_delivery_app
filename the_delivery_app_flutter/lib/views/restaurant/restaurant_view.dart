import 'package:flutter/material.dart';
import '../../dtos/food_dto.dart';
import '../food_item/food_item_view.dart';

class RestaurantView extends StatefulWidget {
  final String restaurantId;
  final String restaurantName;
  final List<FoodDTO> menuItems;

  const RestaurantView({
    super.key,
    required this.restaurantId,
    required this.restaurantName,
    required this.menuItems,
  });

  @override
  State<RestaurantView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  // Derived stats aggregated from the menu items
  double get _avgRating {
    if (widget.menuItems.isEmpty) return 0;
    return widget.menuItems.map((i) => i.rating).reduce((a, b) => a + b) /
        widget.menuItems.length;
  }

  int get _minDeliveryTime {
    if (widget.menuItems.isEmpty) return 0;
    return widget.menuItems
        .map((i) => i.deliveryTimeMinutes)
        .reduce((a, b) => a < b ? a : b);
  }

  bool get _hasDeals => widget.menuItems.any((i) => i.isDiscounted);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      // Scrollable restaurant details plus menu list in one sliver viewport
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(theme),
                  const SizedBox(height: 16),
                  _buildStatsRow(theme),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _buildMenuHeader(theme),
          _buildMenuList(),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    // Pinned header with a simple restaurant hero placeholder
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: const Color(0xFFE8E8E8),
          child: const Center(
            child: Icon(Icons.storefront, size: 72, color: Color(0xFFBBBBBB)),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(ThemeData theme) {
    // Restaurant identity block with optional deals badge
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.restaurantName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_hasDeals) ...[
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5722),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'DEALS AVAILABLE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(ThemeData theme) {
    // Snapshot metrics derived from the current menu data
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat(
            Icons.star,
            const Color(0xFFFFC107),
            _avgRating.toStringAsFixed(1),
            'Avg Rating',
            theme,
          ),
          _buildDivider(),
          _buildStat(
            Icons.access_time,
            const Color(0xFFFF5722),
            '$_minDeliveryTime min',
            'From',
            theme,
          ),
          _buildDivider(),
          _buildStat(
            Icons.restaurant_menu,
            Colors.grey,
            '${widget.menuItems.length}',
            'Items',
            theme,
          ),
        ],
      ),
    );
  }

  Widget _buildStat(
    IconData icon,
    Color iconColor,
    String value,
    String label,
    ThemeData theme,
  ) {
    return Column(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 36, width: 1, color: const Color(0xFFEEEEEE));
  }

  Widget _buildMenuHeader(ThemeData theme) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
        child: Text(
          'Menu',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuList() {
    // Empty state fallback when no menu items are available
    if (widget.menuItems.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Text(
              'No items available',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = widget.menuItems[index];
          return _MenuItemTile(
            item: item,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => FoodItemView(item: item),
              ),
            ),
          );
        },
        childCount: widget.menuItems.length,
      ),
    );
  }
}

class _MenuItemTile extends StatelessWidget {
  final FoodDTO item;
  final VoidCallback onTap;

  const _MenuItemTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      // Compact tappable summary card for a single menu item
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Thumbnail placeholder
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.fastfood,
                    size: 32,
                    color: Color(0xFFCCCCCC),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (item.isDiscounted)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF5722),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'DEAL',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 12,
                            color: Color(0xFFFFC107),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            item.rating.toStringAsFixed(1),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.local_fire_department,
                            size: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${item.calories} cal',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '£${item.price.toStringAsFixed(2)}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFF5722),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
