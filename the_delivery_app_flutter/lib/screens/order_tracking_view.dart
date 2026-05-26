import 'dart:async';

import 'package:flutter/material.dart';

class OrderTrackingView extends StatefulWidget {
  const OrderTrackingView({super.key});

  @override
  State<OrderTrackingView> createState() => _OrderTrackingViewState();
}

class _OrderTrackingViewState extends State<OrderTrackingView> {
  static const _steps = [
    'Order placed',
    'Payment confirmed',
    'Courier assigned',
    'Courier at the restaurant',
    'Courier on the way to you',
    'Delivered',
  ];

  int _currentStep = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 30), (t) {
      if (_currentStep < _steps.length - 1) {
        setState(() => _currentStep++);
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        title: const Text('Order Status'),
        backgroundColor: const Color(0xFFFAF7F2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _steps.length,
        itemBuilder: (context, index) {
          final reached = index <= _currentStep;
          final isCurrent = index == _currentStep;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Icon(
                  reached ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: reached ? Colors.deepOrange : Colors.grey,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _steps[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                      color: reached ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
                if (isCurrent && index < _steps.length - 1)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.deepOrange),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
