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

  Widget _buildOrderTile(Map<String, dynamic> order) {
    final restaurantName = order['restaurantName'] as String? ?? 'Unknown';
    final status = order['status'] as String? ?? '';
    final total = (order['totalAmount'] as num?)?.toDouble() ?? 0.0;
    final preview = order['previewItem'] as String? ?? '';
    final createdAt = order['createdAt'] as String? ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
              Expanded(child: Text(restaurantName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
              Text('£${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
            ],
          ),
          if (preview.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(preview, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ],
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE5DC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(status, style: const TextStyle(color: Colors.deepOrange, fontSize: 11, fontWeight: FontWeight.w600)),
              ),
              const Spacer(),
              Text(_formatDate(createdAt), style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
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
              : ListView(children: _orders.map(_buildOrderTile).toList()),
    );
  }
}
