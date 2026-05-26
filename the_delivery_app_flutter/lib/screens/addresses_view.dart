import 'dart:convert';

import 'package:flutter/material.dart';

import '../main.dart';

class AddressesView extends StatefulWidget {
  const AddressesView({super.key});

  @override
  State<AddressesView> createState() => _AddressesViewState();
}

class _AddressesViewState extends State<AddressesView> {
  List<Map<String, dynamic>> _addresses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    setState(() => _isLoading = true);
    try {
      final userRaw = await client.userProfileController.getCurrentUser();
      final userData = jsonDecode(userRaw);
      if (userData['success'] != true) {
        throw Exception(userData['errorMessage'] ?? 'Not signed in');
      }
      final userId = userData['userId'] as int;
      final profileRaw = await client.userProfileController.getProfile(userId);
      final profile = jsonDecode(profileRaw);
      final list = (profile['user']?['addresses'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .toList();
      if (!mounted) return;
      setState(() {
        _addresses = list;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _showAddressDialog({Map<String, dynamic>? existing}) async {
    final label = TextEditingController(text: existing?['label'] as String? ?? '');
    final line1 = TextEditingController(text: existing?['addressLine1'] as String? ?? '');
    final line2 = TextEditingController(text: existing?['addressLine2'] as String? ?? '');
    final city = TextEditingController(text: existing?['city'] as String? ?? '');
    final postcode = TextEditingController(text: existing?['postcode'] as String? ?? '');
    final country = TextEditingController(text: existing?['country'] as String? ?? 'UK');
    final isEdit = existing != null;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Address' : 'Add Address'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: label, decoration: const InputDecoration(labelText: 'Address name (Home, Work...)')),
              TextField(controller: line1, decoration: const InputDecoration(labelText: 'Address line 1')),
              TextField(controller: line2, decoration: const InputDecoration(labelText: 'Address line 2')),
              TextField(controller: city, decoration: const InputDecoration(labelText: 'City')),
              TextField(controller: postcode, decoration: const InputDecoration(labelText: 'Postcode')),
              TextField(controller: country, decoration: const InputDecoration(labelText: 'Country')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
        ],
      ),
    );

    if (confirmed != true) return;

    if (isEdit) {
      await client.userProfileController.updateAddress(jsonEncode({
        'addressId': existing['id'],
        'label': label.text,
        'addressLine1': line1.text,
        'addressLine2': line2.text,
        'city': city.text,
        'postcode': postcode.text,
        'country': country.text,
      }));
    } else {
      final userRaw = await client.userProfileController.getCurrentUser();
      final userId = jsonDecode(userRaw)['userId'] as int;
      await client.userProfileController.addAddress(jsonEncode({
        'userId': userId,
        'label': label.text,
        'addressLine1': line1.text,
        'addressLine2': line2.text,
        'city': city.text,
        'postcode': postcode.text,
        'country': country.text,
      }));
    }
    _loadAddresses();
  }

  Future<void> _deleteAddress(int addressId) async {
    await client.userProfileController.deleteAddress(addressId);
    _loadAddresses();
  }

  Future<void> _setDefault(int addressId) async {
    await client.userProfileController.setDefaultAddress(addressId);
    _loadAddresses();
  }

  Widget _buildAddressTile(Map<String, dynamic> address) {
    final label = address['label'] as String? ?? '';
    final line1 = address['addressLine1'] as String? ?? '';
    final city = address['city'] as String? ?? '';
    final postcode = address['postcode'] as String? ?? '';
    final isDefault = address['isDefault'] as bool? ?? false;
    final title = label.isNotEmpty ? label : line1;
    final subtitle = label.isNotEmpty ? '$line1, $city, $postcode' : '$city, $postcode';
    return GestureDetector(
      onTap: () => _showAddressDialog(existing: address),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.deepOrange),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  if (isDefault)
                    const Text('Default', style: TextStyle(color: Colors.deepOrange, fontSize: 11)),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isDefault ? Icons.star : Icons.star_border,
                color: Colors.deepOrange,
              ),
              tooltip: isDefault ? 'Default' : 'Set as default',
              onPressed: isDefault ? null : () => _setDefault(address['id'] as int),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _deleteAddress(address['id'] as int),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        title: const Text('My Addresses'),
        backgroundColor: const Color(0xFFFAF7F2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () => _showAddressDialog(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _addresses.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_off_outlined, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No addresses yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Tap the + button to add one', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView(
                  children: _addresses.map(_buildAddressTile).toList(),
                ),
    );
  }
}
