import 'package:flutter/material.dart';

import '../models/food.dart';
import '../models/restaurant.dart';
import '../view_models/basket_view_model.dart';

class BasketView extends StatefulWidget {
  final BasketViewModel viewModel;
  final VoidCallback? onBrowseRestaurants;

  const BasketView({super.key, required this.viewModel, this.onBrowseRestaurants});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  bool _splitEnabled = false;
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  List<MapEntry<Restaurant, List<MapEntry<Food, int>>>> _groupByRestaurant(List<Food> items) {
    final qtyMap = <String, MapEntry<Food, int>>{};
    for (final food in items) {
      if (qtyMap.containsKey(food.id)) {
        qtyMap[food.id] = MapEntry(food, qtyMap[food.id]!.value + 1);
      } else {
        qtyMap[food.id] = MapEntry(food, 1);
      }
    }
    final restMap = <String, MapEntry<Restaurant, List<MapEntry<Food, int>>>>{};
    for (final entry in qtyMap.values) {
      final restId = entry.key.restaurant.id;
      if (restMap.containsKey(restId)) {
        restMap[restId]!.value.add(entry);
      } else {
        restMap[restId] = MapEntry(entry.key.restaurant, [entry]);
      }
    }
    return restMap.values.toList();
  }

  Widget _buildMultiRestaurantBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3CD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE082)),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Color(0xFFE65100), size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Items from multiple restaurants — all in one order!',
              style: TextStyle(color: Color(0xFF6D4C41), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantSection(Restaurant restaurant, List<MapEntry<Food, int>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
          child: Text(
            restaurant.name.isNotEmpty ? restaurant.name : 'Restaurant',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        ...items.map((e) => _buildItemCard(e.key, e.value)),
      ],
    );
  }

  Widget _buildQtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFFFE5DC),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: Colors.deepOrange),
      ),
    );
  }

  Widget _buildItemCard(Food food, int qty) {
    final imageUrl = food.imageUrl;
    Widget image;
    if (imageUrl.isNotEmpty) {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imageUrl.startsWith('http')
            ? Image.network(imageUrl, width: 48, height: 48, fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Icon(Icons.fastfood, color: Colors.deepOrange, size: 28))
            : Image.asset(imageUrl, width: 48, height: 48, fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Icon(Icons.fastfood, color: Colors.deepOrange, size: 28)),
      );
    } else {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 48,
          height: 48,
          color: Colors.grey[200],
          child: const Icon(Icons.fastfood, color: Colors.deepOrange, size: 28),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          image,
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(food.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                const SizedBox(height: 4),
                Text(
                  '£${(food.price * qty).toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.deepOrange),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildQtyButton(Icons.remove, () => widget.viewModel.removeItem(food)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              _buildQtyButton(Icons.add, () => widget.viewModel.addItem(food)),
            ],
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              for (var i = 0; i < qty; i++) {
                widget.viewModel.removeItem(food);
              }
            },
            child: const Icon(Icons.delete_outline, color: Colors.deepOrange, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSplitPayment(double total) {
    final splitAmount = total / 2;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.people_alt_outlined, color: Colors.deepOrange, size: 22),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Split Payment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text('Share the cost with a friend', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Switch(
                value: _splitEnabled,
                onChanged: (v) => setState(() => _splitEnabled = v),
                activeThumbColor: Colors.deepOrange,
              ),
            ],
          ),
          if (_splitEnabled) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                hintText: "Friend's email address",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Each person pays £${splitAmount.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w600),
            ),
          ],
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool bold = false}) {
    final style = bold
        ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
        : const TextStyle(color: Colors.grey, fontSize: 13);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: style), Text(value, style: style)],
    );
  }

  Widget _buildPriceBreakdown(double subtotal, double deliveryFee, double serviceFee, double total) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Price Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 12),
          _priceRow('Subtotal', '£${subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 6),
          _priceRow('Delivery fee', deliveryFee == 0.0 ? 'Free' : '£${deliveryFee.toStringAsFixed(2)}'),
          const SizedBox(height: 6),
          _priceRow('Service fee', '£${serviceFee.toStringAsFixed(2)}'),
          const Divider(height: 20),
          _priceRow('Total', '£${total.toStringAsFixed(2)}', bold: true),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_basket_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add items from a restaurant to get started',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: widget.onBrowseRestaurants,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text('Browse Restaurants', style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final items = widget.viewModel.getState().basket.items;

        if (items.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text('Your Cart')),
            body: _buildEmptyState(),
          );
        }

        final grouped = _groupByRestaurant(items);
        final hasMultiple = grouped.length > 1;
        final subtotal = items.fold(0.0, (sum, f) => sum + f.price);
        final deliveryFee = subtotal >= 15.0 ? 0.0 : 2.99;
        final serviceFee = subtotal * 0.10;
        final total = subtotal + deliveryFee + serviceFee;

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            title: const Text('Your Cart'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            actions: [
              TextButton(
                onPressed: () => widget.viewModel.clearBasket(),
                child: const Text('Clear', style: TextStyle(color: Colors.deepOrange)),
              ),
            ],
          ),
          body: ListView(
            children: [
              if (hasMultiple) _buildMultiRestaurantBanner(),
              ...grouped.map((e) => _buildRestaurantSection(e.key, e.value)),
              _buildSplitPayment(total),
              _buildPriceBreakdown(subtotal, deliveryFee, serviceFee, total),
              const SizedBox(height: 16),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Place Order'),
                      content: const Text(
                        'To place an order, please sign in and add a delivery address in your account.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'Proceed to Checkout · £${total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
