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
      body: const SizedBox.shrink(),
    );
  }
}
