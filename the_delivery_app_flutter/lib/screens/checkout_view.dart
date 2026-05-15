import 'dart:convert';

import 'package:flutter/material.dart';

import '../main.dart';
import '../view_models/basket_view_model.dart';

class CheckoutView extends StatefulWidget {
  final BasketViewModel basketViewModel;

  const CheckoutView({super.key, required this.basketViewModel});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _addressLine1Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _postcodeController = TextEditingController();
  final _countryController = TextEditingController(text: 'UK');

  @override
  void dispose() {
    _addressLine1Controller.dispose();
    _cityController.dispose();
    _postcodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Widget _buildAddressForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Delivery Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          TextField(
            controller: _addressLine1Controller,
            decoration: const InputDecoration(labelText: 'Address line 1', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _cityController,
            decoration: const InputDecoration(labelText: 'City', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _postcodeController,
            decoration: const InputDecoration(labelText: 'Postcode', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _countryController,
            decoration: const InputDecoration(labelText: 'Country', border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    final items = widget.basketViewModel.getState().basket.items;
    final subtotal = items.fold(0.0, (sum, f) => sum + f.price);
    final deliveryFee = subtotal >= 15.0 ? 0.0 : 2.99;
    final serviceFee = subtotal * 0.10;
    final total = subtotal + deliveryFee + serviceFee;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          _row('Items', '${items.length}'),
          const SizedBox(height: 6),
          _row('Subtotal', '£${subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 6),
          _row('Delivery fee', deliveryFee == 0.0 ? 'Free' : '£${deliveryFee.toStringAsFixed(2)}'),
          const SizedBox(height: 6),
          _row('Service fee', '£${serviceFee.toStringAsFixed(2)}'),
          const Divider(height: 20),
          _row('Total', '£${total.toStringAsFixed(2)}', bold: true),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) {
    final style = bold
        ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
        : const TextStyle(color: Colors.grey, fontSize: 13);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: style), Text(value, style: style)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: const Color(0xFFFAF7F2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildOrderSummary(),
          _buildAddressForm(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
