import 'package:flutter/material.dart';

import '../models/order_status.dart';
import '../state/order_status_state.dart';

class OrderStatusView extends StatelessWidget {
  final OrderStatusState state;

  const OrderStatusView({super.key, required this.state});

  Widget _buildStatusSteps(OrderStatus current) {
    const steps = OrderStatus.values;
    return Column(
      children: steps.map((step) {
        final isActive = step == current;
        return ListTile(
          leading: Icon(
            isActive ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isActive ? Colors.deepOrange : Colors.grey,
          ),
          title: Text(
            step.name[0].toUpperCase() + step.name.substring(1),
            style: TextStyle(
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? Colors.deepOrange : Colors.grey,
            ),
          ),
        );
      }).toList(),
    );
  }

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
