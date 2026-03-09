import 'package:flutter/material.dart';
import 'views/feed/feed_view.dart';
import 'views/basket/basket_view.dart';
import 'views/orders/orders_view.dart';
import 'views/account/account_view.dart';

class Shell extends StatefulWidget {
  const Shell({super.key});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int _currentIndex = 0;

  // Order must match NavigationBar destinations below
  static const _pages = <Widget>[
    FeedView(),
    BasketView(),
    OrdersView(),
    AccountView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack keeps tab state alive when switching tabs
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      // Bottom navigation for switching between the apps primary sections
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,

        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFFFCCBC),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Color(0xFFFF5722)),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_basket_outlined),
            selectedIcon: Icon(Icons.shopping_basket, color: Color(0xFFFF5722)),
            label: 'Basket',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long, color: Color(0xFFFF5722)),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: Color(0xFFFF5722)),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
