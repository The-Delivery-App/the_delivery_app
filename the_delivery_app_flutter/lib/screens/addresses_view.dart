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
      body: const SizedBox.shrink(),
    );
  }
}
