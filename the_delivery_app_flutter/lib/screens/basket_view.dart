import 'package:flutter/material.dart';

import '../models/food.dart';
import '../view_models/basket_view_model.dart';

class BasketView extends StatelessWidget {
  final BasketViewModel viewModel;

  const BasketView({super.key, required this.viewModel});

  Widget _buildEmptyState() {
    return const Center(
      child: Text('Your basket is empty.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
