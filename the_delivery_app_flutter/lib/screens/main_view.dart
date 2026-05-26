import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../APIs/feed_api_service.dart';
import '../APIs/map_api_service.dart';
import '../APIs/restaurant_api_service.dart';
import '../main.dart';
import '../models/food_sort_rule.dart';
import '../models/restaurant.dart';
import '../models/tracked_delivery.dart';
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
  String? _cuisine;
  int? _orderStatusIndex;
  List<TrackedDelivery> _activeDeliveries = [];
  double _onTheWayProgress = 0.0;
  Timer? _orderStatusTimer;
  Timer? _animationTimer;

  static const _orderStatuses = [
    'Order placed',
    'Payment confirmed',
    'Courier assigned',
    'Courier at the restaurant',
    'Courier on the way to you',
    'Delivered',
  ];
  static const _orderStatusKeys = [
    'placed',
    'confirmed',
    'assigned',
    'restaurant',
    'customer',
    'delivered',
  ];
  static const _cuisines = ['Thai', 'Chinese', 'Indian', 'Japanese', 'Vietnamese', 'Italian', 'American'];

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

  Future<void> _startOrderTracking(List<TrackedDelivery> deliveries) async {
    setState(() {
      _orderStatusIndex = 0;
      _onTheWayProgress = 0.0;
      _activeDeliveries = deliveries;
      _selectedIndex = 2;
    });
    await _assignCouriers();
    _orderStatusTimer?.cancel();
    _orderStatusTimer = Timer.periodic(const Duration(seconds: 3), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      final current = _orderStatusIndex ?? 0;
      if (current >= _orderStatuses.length - 1) {
        t.cancel();
        return;
      }
      if (current == 3) {
        // Entering "on the way" — switch to animation timer
        t.cancel();
        _advanceStatus(4);
        _startOnTheWayAnimation();
        return;
      }
      _advanceStatus(current + 1);
    });
  }

  void _advanceStatus(int next) {
    setState(() => _orderStatusIndex = next);
    _pushStatusToBackend(next);
  }

  void _startOnTheWayAnimation() {
    _animationTimer?.cancel();
    const totalTicks = 100; // 20 seconds at 200ms intervals
    int tick = 0;
    _animationTimer = Timer.periodic(const Duration(milliseconds: 200), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      tick++;
      setState(() => _onTheWayProgress = (tick / totalTicks).clamp(0.0, 1.0));
      if (tick >= totalTicks) {
        t.cancel();
        _advanceStatus(5);
      }
    });
  }

  Future<void> _assignCouriers() async {
    try {
      final raw = await client.courierController.getAvailableCouriers();
      final data = jsonDecode(raw) as Map<String, dynamic>;
      final couriers = (data['couriers'] as List<dynamic>? ?? []).whereType<Map<String, dynamic>>().toList();
      if (couriers.isEmpty || !mounted) return;
      final used = <int>{};
      for (var i = 0; i < _activeDeliveries.length; i++) {
        Map<String, dynamic>? pick;
        for (var j = 0; j < couriers.length; j++) {
          final candidate = couriers[(DateTime.now().millisecondsSinceEpoch + i + j) % couriers.length];
          final id = candidate['id'] as int?;
          if (id == null) continue;
          if (used.contains(id) && couriers.length > used.length) continue;
          used.add(id);
          pick = candidate;
          break;
        }
        pick ??= couriers[i % couriers.length];
        final d = _activeDeliveries[i];
        d.courierId = pick['id'] as int?;
        d.courierName = pick['name'] as String?;
        d.courierVehicle = pick['vehicle'] as String?;
        d.courierPlate = pick['plateNumber'] as String?;
        d.courierPhone = pick['phone'] as String?;
      }
      setState(() {});
    } catch (_) {}
  }

  Future<void> _pushStatusToBackend(int index) async {
    if (_activeDeliveries.isEmpty || index >= _orderStatusKeys.length) return;
    final newStatus = _orderStatusKeys[index];
    for (final d in _activeDeliveries) {
      try {
        if (newStatus == 'assigned' && d.courierId != null) {
          await client.courierController.assignCourier(jsonEncode({
            'orderId': d.orderId,
            'courierId': d.courierId,
          }));
        } else {
          await client.courierController.updateDeliveryStatus(jsonEncode({
            'orderId': d.orderId,
            'newStatus': newStatus,
          }));
        }
      } catch (_) {}
    }
  }

  void _clearOrderTracking() {
    _orderStatusTimer?.cancel();
    _animationTimer?.cancel();
    setState(() {
      _orderStatusIndex = null;
      _onTheWayProgress = 0.0;
      _activeDeliveries = [];
    });
  }

  void _onOrderPlaced(List<String> restaurantIds, List<int> orderIds) {
    if (restaurantIds.isEmpty || orderIds.isEmpty) return;
    final deliveries = <TrackedDelivery>[];
    for (var i = 0; i < restaurantIds.length && i < orderIds.length; i++) {
      final restId = restaurantIds[i];
      final r = _featuredRestaurants.firstWhere(
        (r) => r.id == restId,
        orElse: () => Restaurant(id: restId, name: 'Restaurant'),
      );
      if (r.latitude == null || r.longitude == null) continue;
      deliveries.add(TrackedDelivery(
        orderId: orderIds[i],
        restaurantLat: r.latitude!,
        restaurantLng: r.longitude!,
        restaurantName: r.name,
      ));
    }
    if (deliveries.isEmpty) return;
    _startOrderTracking(deliveries);
  }

  Future<void> _showFilterSheet() async {
    FoodSortRule? sort = _sortRule;
    String? tier = _priceTier;
    bool discounted = _onlyDiscounted;
    String? selectedCuisine = _cuisine;
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
                const Text('Cuisine', style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 6,
                  children: _cuisines.map((c) {
                    final isSelected = selectedCuisine == c;
                    return ChoiceChip(
                      label: Text(c),
                      selected: isSelected,
                      onSelected: (_) => setSheet(() => selectedCuisine = isSelected ? null : c),
                      selectedColor: const Color(0xFFFFE5DC),
                    );
                  }).toList(),
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
                          selectedCuisine = null;
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
                            _cuisine = selectedCuisine;
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
            cuisine: _cuisine,
            restaurantCuisines: {
              for (final r in _featuredRestaurants)
                if (r.cuisine != null) r.name: r.cuisine!,
            },
            onFilterTap: _showFilterSheet,
            onClearFilters: () => setState(() {
              _sortRule = null;
              _priceTier = null;
              _onlyDiscounted = false;
              _cuisine = null;
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
            orderStatusIndex: _orderStatusIndex,
            orderStatuses: _orderStatuses,
            trackedDeliveries: _activeDeliveries,
            onTheWayProgress: _onTheWayProgress,
            onDismissOrder: _clearOrderTracking,
          ),
        );
      case 3:
        return BasketView(
          viewModel: _basketViewModel,
          onBrowseRestaurants: () => setState(() => _selectedIndex = 0),
          onOrderPlaced: _onOrderPlaced,
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
