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
    final userRaw = await client.userProfileController.getCurrentUser();
    final userId = jsonDecode(userRaw)['userId'] as int;
    final profileRaw = await client.userProfileController.getProfile(userId);
    final profile = jsonDecode(profileRaw);
    final list = (profile['user']['addresses'] as List<dynamic>)
        .whereType<Map<String, dynamic>>()
        .toList();
    if (!mounted) return;
    setState(() {
      _addresses = list;
      _isLoading = false;
    });
  }

  Future<void> _deleteAddress(int addressId) async {
    await client.userProfileController.deleteAddress(addressId);
    _loadAddresses();
  }

  Widget _buildAddressTile(Map<String, dynamic> address) {
    final line1 = address['addressLine1'] as String? ?? '';
    final city = address['city'] as String? ?? '';
    final postcode = address['postcode'] as String? ?? '';
    final isDefault = address['isDefault'] as bool? ?? false;
    return Container(
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
                Text(line1, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('$city, $postcode', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                if (isDefault)
                  const Text('Default', style: TextStyle(color: Colors.deepOrange, fontSize: 11)),
              ],
            ),
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
        title: const Text('My Addresses'),
        backgroundColor: const Color(0xFFFAF7F2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _addresses.isEmpty
              ? const Center(child: Text('No addresses saved yet.'))
              : ListView(
                  children: _addresses.map(_buildAddressTile).toList(),
                ),
    );
  }
}
