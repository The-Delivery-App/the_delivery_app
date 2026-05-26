import 'dart:convert';

import 'package:flutter/material.dart';

import '../main.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  List<Map<String, dynamic>> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() => _isLoading = true);
    try {
      final userRaw = await client.userProfileController.getCurrentUser();
      final userData = jsonDecode(userRaw);
      if (userData['success'] != true) throw Exception('Not signed in');
      final userId = userData['userId'] as int;
      final raw = await client.orderController.getHistory(userId, 50, 0);
      final data = jsonDecode(raw) as Map<String, dynamic>;
      if (data['success'] != true) throw Exception(data['errorMessage'] ?? 'Could not load orders');
      final list = (data['orders'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .toList();
      if (!mounted) return;
      setState(() {
        _orders = list;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  String _formatDate(String iso) {
    try {
      final d = DateTime.parse(iso).toLocal();
      return '${d.day}/${d.month}/${d.year} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }

  List<List<Map<String, dynamic>>> _groupByCheckout(List<Map<String, dynamic>> orders) {
    final groups = <List<Map<String, dynamic>>>[];
    for (final order in orders) {
      final createdAt = DateTime.tryParse(order['createdAt'] as String? ?? '');
      if (createdAt == null) {
        groups.add([order]);
        continue;
      }
      bool added = false;
      for (final group in groups) {
        final first = DateTime.tryParse(group.first['createdAt'] as String? ?? '');
        if (first != null && first.difference(createdAt).inSeconds.abs() <= 10) {
          group.add(order);
          added = true;
          break;
        }
      }
      if (!added) groups.add([order]);
    }
    return groups;
  }

  Widget _buildCheckoutCard(List<Map<String, dynamic>> orders) {
    final total = orders.fold<double>(
      0.0,
      (sum, o) => sum + ((o['totalAmount'] as num?)?.toDouble() ?? 0),
    );
    final createdAt = orders.first['createdAt'] as String? ?? '';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orders.length > 1 ? 'Order from ${orders.length} restaurants' : 'Order',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text('£${total.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
            ],
          ),
          const SizedBox(height: 6),
          Text(_formatDate(createdAt), style: const TextStyle(color: Colors.grey, fontSize: 11)),
          const Divider(height: 16),
          ...orders.map((o) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    const Icon(Icons.restaurant, size: 14, color: Colors.deepOrange),
                    const SizedBox(width: 6),
                    Expanded(child: Text(o['restaurantName'] as String? ?? '', style: const TextStyle(fontSize: 13))),
                    Text('£${((o['totalAmount'] as num?)?.toDouble() ?? 0).toStringAsFixed(2)}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: const Color(0xFFFAF7F2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _orders.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No past orders yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Your completed orders will appear here', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView(children: _groupByCheckout(_orders).map(_buildCheckoutCard).toList()),
    );
  }
}
