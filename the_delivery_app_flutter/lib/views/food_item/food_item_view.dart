import 'package:flutter/material.dart';
import '../../dtos/food_dto.dart';

class FoodItemView extends StatefulWidget {
  final FoodDTO item;
  final VoidCallback? onRestaurantTap;
  const FoodItemView({super.key, required this.item, this.onRestaurantTap});

  @override
  State<FoodItemView> createState() => _FoodItemViewState();
}

class _FoodItemViewState extends State<FoodItemView> {
  int _quantity = 1;

  // Keeps the CTA price in sync with quantity changes
  double get _totalPrice => widget.item.price * _quantity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final item = widget.item;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      // Scrollable detail content with a pinned media header
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(item),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleRow(theme, item),
                  const SizedBox(height: 8),
                  _buildRestaurantRow(theme, item),
                  const SizedBox(height: 16),
                  _buildStatsRow(theme, item),
                  const SizedBox(height: 16),
                  _buildTags(item),
                  const SizedBox(height: 24),
                  _buildDescription(theme, item),
                  const SizedBox(height: 100), // space for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(theme, item),
    );
  }

  Widget _buildSliverAppBar(FoodDTO item) {
    // Hero-style header with image placeholder and optional deal badge
    return SliverAppBar(
      expandedHeight: 260,
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
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: const Color(0xFFEEEEEE),
              child: const Center(
                child: Icon(
                  Icons.fastfood,
                  size: 80,
                  color: Color(0xFFCCCCCC),
                ),
              ),
            ),
            if (item.isDiscounted)
              Positioned(
                top: 60,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5722),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'DEAL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(ThemeData theme, FoodDTO item) {
    // Item name on the left, base unit price on the right
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            item.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '£${item.price.toStringAsFixed(2)}',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFF5722),
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantRow(ThemeData theme, FoodDTO item) {
    return GestureDetector(
      onTap: widget.onRestaurantTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.storefront, size: 16, color: Colors.grey),
          const SizedBox(width: 6),
          Text(
            item.restaurantName,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
              decoration: widget.onRestaurantTap != null
                  ? TextDecoration.underline
                  : null,
            ),
          ),
          if (widget.onRestaurantTap != null) ...[
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsRow(ThemeData theme, FoodDTO item) {
    // Quick metrics strip for rating, delivery, calories, and order volume
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
            item.rating.toStringAsFixed(1),
            'Rating',
            theme,
          ),
          _buildDivider(),
          _buildStat(
            Icons.access_time,
            const Color(0xFFFF5722),
            '${item.deliveryTimeMinutes} min',
            'Delivery',
            theme,
          ),
          _buildDivider(),
          _buildStat(
            Icons.local_fire_department,
            Colors.grey,
            '${item.calories}',
            'Calories',
            theme,
          ),
          _buildDivider(),
          _buildStat(
            Icons.shopping_bag_outlined,
            Colors.grey,
            '${item.recentOrders}',
            'Orders',
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

  Widget _buildTags(FoodDTO item) {
    // Wrap allows tags to flow onto new lines when space is limited
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: item.tags
          .map(
            (tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Text(
                tag,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDescription(ThemeData theme, FoodDTO item) {
    // Human-readable summary generated from item fields
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'A delicious ${item.name} from ${item.restaurantName}. '
          'Served as ${item.size} ${item.unitType}${item.size > 1 ? 's' : ''}.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.black54,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(ThemeData theme, FoodDTO item) {
    // Sticky action area for quantity controls and add-to-basket CTA
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Quantity selector
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEEEEEE)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 18),
                  onPressed: _quantity > 1
                      ? () => setState(() => _quantity--)
                      : null,
                  color: _quantity > 1 ? Colors.black87 : Colors.grey,
                ),
                SizedBox(
                  width: 28,
                  child: Text(
                    '$_quantity',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 18),
                  onPressed: () => setState(() => _quantity++),
                  color: const Color(0xFFFF5722),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Add to basket button
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5722),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // TODO: wire up BasketViewModel.addItem()
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.name} added to basket'),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: const Color(0xFFFF5722),
                    ),
                  );
                },
                child: Text(
                  'Add to Basket  •  £${_totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
