import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../APIs/feed_api_service.dart';
import '../APIs/map_api_service.dart';
import '../APIs/restaurant_api_service.dart';
import '../main.dart';
import '../models/food_sort_rule.dart';
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
import '../view_models/map_view_model.dart';
import '../view_models/search_view_model.dart';
import '../view_models/settings_view_model.dart';
import '../view_models/special_deal_view_model.dart';
import 'account_view.dart';
import 'addresses_view.dart';
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
  late final MapViewModel _mapViewModel;
  List<Restaurant> _featuredRestaurants = [];
  String _addressLabel = 'London, UK';
  double? _addressLat;
  double? _addressLng;
  FoodSortRule? _sortRule;
  String? _priceTier;
  bool _onlyDiscounted = false;

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
    _mapViewModel = MapViewModel(apiService: MapAPIService());
    _mapViewModel.updateLocation();
    _loadFeaturedRestaurants();
    _loadDefaultAddress();
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
    _mapViewModel.dispose();
    super.dispose();
  }

  Future<void> _loadDefaultAddress() async {
    try {
      final userRaw = await client.userProfileController.getCurrentUser();
      final userData = jsonDecode(userRaw);
      if (userData['success'] != true) return;
      final userId = userData['userId'] as int;
      final profileRaw = await client.userProfileController.getProfile(userId);
      final profile = jsonDecode(profileRaw);
      final addresses = (profile['user']?['addresses'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .toList();
      if (addresses.isEmpty) return;
      final defaultAddr = addresses.firstWhere(
        (a) => a['isDefault'] == true,
        orElse: () => addresses.first,
      );
      if (!mounted) return;
      setState(() {
        _addressLabel = '${defaultAddr['addressLine1']}, ${defaultAddr['city']}';
      });
      _geocodeAddress(defaultAddr);
    } catch (_) {}
  }

  Future<void> _geocodeAddress(Map<String, dynamic> address) async {
    try {
      final query = '${address['addressLine1']}, ${address['city']}, ${address['postcode']}';
      final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(query)}&format=json&limit=1');
      final response = await http.get(url, headers: {'User-Agent': 'TheDeliveryApp/1.0'});
      final data = jsonDecode(response.body) as List;
      if (data.isEmpty) return;
      final result = data.first as Map<String, dynamic>;
      if (!mounted) return;
      setState(() {
        _addressLat = double.parse(result['lat'] as String);
        _addressLng = double.parse(result['lon'] as String);
      });
    } catch (_) {}
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

  Future<void> _showFilterSheet() async {
    FoodSortRule? sort = _sortRule;
    String? tier = _priceTier;
    bool discounted = _onlyDiscounted;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheet) => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Sort & Filter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 16),
                const Text('Sort by', style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 6,
                  children: [
                    _sortChip('Price ↑', FoodSortRule.priceLowToHigh, sort, (v) => setSheet(() => sort = v)),
                    _sortChip('Price ↓', FoodSortRule.priceHighToLow, sort, (v) => setSheet(() => sort = v)),
                    _sortChip('Rating', FoodSortRule.rating, sort, (v) => setSheet(() => sort = v)),
                    _sortChip('Delivery ↑', FoodSortRule.distanceClosestFirst, sort, (v) => setSheet(() => sort = v)),
                    _sortChip('Delivery ↓', FoodSortRule.distanceFarthestFirst, sort, (v) => setSheet(() => sort = v)),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Price tier', style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 6,
                  children: [
                    _tierChip('£ Cheap', 'low', tier, (v) => setSheet(() => tier = v)),
                    _tierChip('££ Mid', 'mid', tier, (v) => setSheet(() => tier = v)),
                    _tierChip('£££ Premium', 'high', tier, (v) => setSheet(() => tier = v)),
                  ],
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Only show discounted items'),
                  value: discounted,
                  onChanged: (v) => setSheet(() => discounted = v ?? false),
                  activeColor: Colors.deepOrange,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => setSheet(() {
                          sort = null;
                          tier = null;
                          discounted = false;
                        }),
                        child: const Text('Clear'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _sortRule = sort;
                            _priceTier = tier;
                            _onlyDiscounted = discounted;
                          });
                          Navigator.pop(ctx);
                        },
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sortChip(String label, FoodSortRule value, FoodSortRule? current, ValueChanged<FoodSortRule?> onTap) {
    final selected = current == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(selected ? null : value),
      selectedColor: const Color(0xFFFFE5DC),
    );
  }

  Widget _tierChip(String label, String value, String? current, ValueChanged<String?> onTap) {
    final selected = current == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(selected ? null : value),
      selectedColor: const Color(0xFFFFE5DC),
    );
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
            onSearchTap: () => setState(() => _selectedIndex = 1),
            onSeeMap: () => setState(() => _selectedIndex = 2),
            onProfileTap: () => setState(() => _selectedIndex = 4),
            onAddressTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddressesView()),
            ).then((_) => _loadDefaultAddress()),
            addressLabel: _addressLabel,
            featuredRestaurants: _featuredRestaurants,
            userLat: _addressLat,
            userLng: _addressLng,
            sortRule: _sortRule,
            priceTier: _priceTier,
            onlyDiscounted: _onlyDiscounted,
            onFilterTap: _showFilterSheet,
            onClearFilters: () => setState(() {
              _sortRule = null;
              _priceTier = null;
              _onlyDiscounted = false;
            }),
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
        return ListenableBuilder(
          listenable: _mapViewModel,
          builder: (_, _) => MapView(
            state: MapState(
              restaurants: _featuredRestaurants,
              currentLocation: _mapViewModel.getState().currentLocation,
            ),
            onAddToBasket: _basketViewModel.addItem,
            addressLat: _addressLat,
            addressLng: _addressLng,
          ),
        );
      case 3:
        return BasketView(
          viewModel: _basketViewModel,
          onBrowseRestaurants: () => setState(() => _selectedIndex = 0),
        );
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
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            elevation: 12,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            unselectedFontSize: 11,
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
