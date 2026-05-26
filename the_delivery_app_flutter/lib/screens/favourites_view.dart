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

  Widget _buildFavTile(Map<String, dynamic> fav) {
    final type = fav['type'] as String? ?? '';
    final isFood = type == 'food';
    final name = isFood ? (fav['foodItemName'] as String? ?? '') : (fav['restaurantName'] as String? ?? '');
    final price = isFood ? (fav['foodItemPrice'] as num?)?.toDouble() : null;
    final id = fav['id'] as int;
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
          Icon(isFood ? Icons.fastfood : Icons.restaurant, color: Colors.deepOrange),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(isFood ? 'Food item' : 'Restaurant', style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          if (price != null)
            Text('£${price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _remove(id),
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
        title: const Text('My Favourites'),
        backgroundColor: const Color(0xFFFAF7F2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: const SizedBox.shrink(),
    );
  }
}
