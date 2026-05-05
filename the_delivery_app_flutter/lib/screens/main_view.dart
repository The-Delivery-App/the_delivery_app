import 'package:flutter/material.dart';

import '../APIs/feed_api_service.dart';
import '../main.dart';
import '../repositories/basket_repository.dart';
import '../repositories/food_repository.dart';
import '../repositories/settings_repository.dart';
import '../state/map_state.dart';
import '../storage/local_storage.dart';
import '../view_models/basket_view_model.dart';
import '../view_models/feed_view_model.dart';
import '../view_models/search_view_model.dart';
import '../view_models/settings_view_model.dart';
import 'account_view.dart';
import 'basket_view.dart';
import 'feed_view.dart';
import 'map_view.dart';
import 'search_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  late final BasketViewModel _basketViewModel;
  late final SettingsViewModel _settingsViewModel;
  late final FeedViewModel _feedViewModel;
  late final SearchViewModel _searchViewModel;

  @override
  void initState() {
    super.initState();
    final storage = LocalStorage();
    _basketViewModel = BasketViewModel(
      repository: BasketRepository(storage: storage),
    );
    _settingsViewModel = SettingsViewModel(
      repository: SettingsRepository(storage: storage),
    );
    _feedViewModel = FeedViewModel(
      repository: FoodRepository(
        apiService: FeedAPIService(client: client),
        sessionId: '',
      ),
    );
    _searchViewModel = SearchViewModel();
    _feedViewModel.loadFeed();
  }

  @override
  void dispose() {
    _basketViewModel.dispose();
    _settingsViewModel.dispose();
    _feedViewModel.dispose();
    _searchViewModel.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return ListenableBuilder(
          listenable: _feedViewModel,
          builder: (_, _) {
            _searchViewModel.loadItems(_feedViewModel.getState().feedItems);
            return FeedView(
              state: _feedViewModel.getState(),
              onAddToBasket: _basketViewModel.addItem,
            );
          },
        );
      case 1:
        return ListenableBuilder(
          listenable: _searchViewModel,
          builder: (_, _) => SearchView(
            state: _searchViewModel.getState(),
            onSearch: _searchViewModel.search,
          ),
        );
      case 2:
        return const MapView(state: MapState(restaurants: []));
      case 3:
        return BasketView(viewModel: _basketViewModel);
      case 4:
        return const AccountView();
      default:
        return FeedView(state: _feedViewModel.getState());
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
