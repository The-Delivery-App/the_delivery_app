import 'package:flutter/material.dart';

import '../models/order_status.dart';
import '../state/order_status_state.dart';

class OrderStatusView extends StatelessWidget {
  final OrderStatusState state;

  const OrderStatusView({super.key, required this.state});

  Widget _buildNoOrder() {
    return const Center(
      child: Text('No active order.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
