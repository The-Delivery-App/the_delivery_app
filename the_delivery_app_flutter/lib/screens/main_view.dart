import 'package:flutter/material.dart';

import '../APIs/feed_api_service.dart';
import '../APIs/restaurant_api_service.dart';
import '../main.dart';
import '../models/restaurant.dart';
import '../repositories/basket_repository.dart';
import '../repositories/food_repository.dart';
import '../repositories/restaurant_repository.dart';
import '../repositories/settings_repository.dart';
import '../repositories/special_deal_repository.dart';
import '../state/map_state.dart';
import '../storage/local_storage.dart';
import '../view_models/basket_view_model.dart';
import '../view_models/feed_view_model.dart';
import '../view_models/search_view_model.dart';
import '../view_models/settings_view_model.dart';
import '../view_models/special_deal_view_model.dart';
import 'account_view.dart';
import 'basket_view.dart';
import 'feed_view.dart';
import 'map_view.dart';
import 'search_view.dart';
import 'special_deal_view.dart';

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
  late final SpecialDealViewModel _specialDealViewModel;
  List<Restaurant> _featuredRestaurants = [];

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
    _searchViewModel = SearchViewModel(
      repository: FoodRepository(
        apiService: FeedAPIService(client: client),
        sessionId: '',
      ),
    );
    _specialDealViewModel = SpecialDealViewModel(
      repository: SpecialDealRepository(client: client),
    );
    _loadFeaturedRestaurants();
    _basketViewModel.loadBasket();
    _feedViewModel.addListener(() {
      _searchViewModel.loadItems(_feedViewModel.getState().feedItems);
    });
    _feedViewModel.loadFeed();
  }

  @override
  void dispose() {
    _basketViewModel.dispose();
    _settingsViewModel.dispose();
    _feedViewModel.dispose();
    _searchViewModel.dispose();
    _specialDealViewModel.dispose();
    super.dispose();
  }

  Future<void> _loadFeaturedRestaurants() async {
    try {
      final repo = RestaurantRepository(
        apiService: RestaurantAPIService(client: client),
      );
      final results = await repo.getRestaurantList();
      if (mounted) setState(() => _featuredRestaurants = results);
    } catch (_) {}
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
          builder: (_, _) => FeedView(
            state: _feedViewModel.getState(),
            onAddToBasket: _basketViewModel.addItem,
            onRetry: _feedViewModel.loadFeed,
            onLoadMore: _feedViewModel.loadMore,
            onDeals: () {
              _specialDealViewModel.loadDeals();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ListenableBuilder(
                    listenable: _specialDealViewModel,
                    builder: (_, _) => SpecialDealView(
                      state: _specialDealViewModel.getState(),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      case 1:
        return ListenableBuilder(
          listenable: _searchViewModel,
          builder: (_, _) => SearchView(
            state: _searchViewModel.getState(),
            onSearch: _searchViewModel.search,
            onAddToBasket: _basketViewModel.addItem,
          ),
        );
      case 2:
        return MapView(state: MapState(restaurants: _featuredRestaurants));
      case 3:
        return BasketView(viewModel: _basketViewModel);
      case 4:
        return AccountView(settingsViewModel: _settingsViewModel);
      default:
        return FeedView(
          state: _feedViewModel.getState(),
          onAddToBasket: _basketViewModel.addItem,
          onRetry: _feedViewModel.loadFeed,
          onLoadMore: _feedViewModel.loadMore,
          onDeals: () {},
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: ListenableBuilder(
        listenable: _basketViewModel,
        builder: (_, _) {
          final basketCount = _basketViewModel.getState().basket.items.length;
          return BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onTabTapped,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            items: [
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
              const BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
              BottomNavigationBarItem(
                icon: basketCount > 0
                    ? Badge.count(
                        count: basketCount,
                        child: const Icon(Icons.shopping_basket),
                      )
                    : const Icon(Icons.shopping_basket),
                label: 'Basket',
              ),
              const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
            ],
          );
        },
      ),
    );
  }
}
