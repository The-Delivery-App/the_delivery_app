import 'package:flutter/material.dart';

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
    );
  }
}
