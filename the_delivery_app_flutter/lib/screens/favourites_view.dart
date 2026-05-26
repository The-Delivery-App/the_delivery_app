import 'dart:convert';

import 'package:flutter/material.dart';

import '../main.dart';

class FavouritesView extends StatefulWidget {
  const FavouritesView({super.key});

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  List<Map<String, dynamic>> _favourites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    setState(() => _isLoading = true);
    try {
      final userRaw = await client.userProfileController.getCurrentUser();
      final userData = jsonDecode(userRaw);
      if (userData['success'] != true) throw Exception('Not signed in');
      final userId = userData['userId'] as int;
      final raw = await client.favouritesController.getFavourites(userId);
      final data = jsonDecode(raw) as Map<String, dynamic>;
      final list = (data['favourites'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .toList();
      if (!mounted) return;
      setState(() {
        _favourites = list;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _remove(int favouriteId) async {
    await client.favouritesController.removeFavourite(favouriteId);
    _loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        title: const Text('My Favourites'),
        backgroundColor: const Color(0xFFFAF7F2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: const SizedBox.shrink(),
    );
  }
}
