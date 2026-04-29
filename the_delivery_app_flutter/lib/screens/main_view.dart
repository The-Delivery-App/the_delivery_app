import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../repositories/basket_repository.dart';
import '../repositories/settings_repository.dart';
import '../state/map_state.dart';
import '../state/order_status_state.dart';
import '../storage/local_storage.dart';
import '../view_models/basket_view_model.dart';
import '../view_models/settings_view_model.dart';
import 'account_view.dart';
import 'basket_view.dart';
import 'map_view.dart';
import 'order_status_view.dart';
import 'restaurant_view.dart';
import 'settings_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const Center(child: Text('Feed'));
      case 1:
        return const Center(child: Text('Search'));
      case 2:
        return const Center(child: Text('Map'));
      case 3:
        return const Center(child: Text('Basket'));
      case 4:
        return const Center(child: Text('Account'));
      default:
        return const Center(child: Text('Feed'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: 'Basket'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
