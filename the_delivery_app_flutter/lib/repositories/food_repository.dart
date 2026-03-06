import '../APIs/i_food_api_service.dart';
import '../dtos/food_dto.dart';
import '../models/device_profile.dart';
import '../models/food.dart';
import '../models/food_filters.dart';
import '../models/restaurant.dart';
import '../models/food_sort_rule.dart';
import '../models/food_unit_type.dart';
import '../models/location.dart';
import 'i_feed_repository.dart';

class FoodRepository implements IFoodRepository {
  final IFoodApiService _apiService;
  final String _sessionId;

  List<String> _portionIds = [];
  int _loadedCursor = 0;

  // Only the two most recent chunks are kept in memory.
  final List<Food> _currentFeed = [];
  int _chunkSize = 20;

  FoodSortRule? _sortRule;
  Location? _lastLocation;
  FoodFilter? _lastFilter;

  Future<List<Food>>? _prefetchFuture;

  FoodRepository({
    required IFoodApiService apiService,
    required String sessionId,
  }) : _apiService = apiService,
       _sessionId = sessionId;

  @override
  Future<void> initializeFeed({
    required Location location,
    required DeviceProfile device,
    FoodFilter? filter,
    FoodSortRule? sortRule,
  }) async {
    _portionIds = [];
    _loadedCursor = 0;
    _currentFeed.clear();
    _prefetchFuture = null;
    _sortRule = sortRule;
    _lastLocation = location;
    _lastFilter = filter;
    _chunkSize = _computeChunkSize(device);

    final portion = await _apiService.fetchFeedPortion(
      sessionId: _sessionId,
      location: location,
      filter: filter,
    );
    _portionIds = portion.foodIds;
  }

  @override
  Future<List<Food>> loadNextChunk() async {
    List<Food> chunk;

    if (_prefetchFuture != null) {
      chunk = await _prefetchFuture!;
      _prefetchFuture = null;
    } else {
      chunk = await _fetchChunkAt(_loadedCursor);
    }

    // Portion exhausted — fetch a new one automatically.
    if (chunk.isEmpty && _lastLocation != null) {
      await _refetchPortion();
      chunk = await _fetchChunkAt(_loadedCursor);
    }

    _loadedCursor += chunk.length;
    _applySort(chunk);
    _updateCurrentFeed(chunk);
    return chunk;
  }

  @override
  Future<void> prefetchNextChunk() async {
    if (_prefetchFuture != null) return;
    _prefetchFuture = _fetchChunkAt(_loadedCursor);
  }

  @override
  List<Food> getCurrentFeed() => List.unmodifiable(_currentFeed);

  @override
  Future<List<Food>> search({
    required String query,
    required Location location,
  }) async {
    final dtos = await _apiService.search(query: query, location: location);
    return dtos.map(_dtoToFood).toList();
  }

  @override
  void clear() {
    _portionIds = [];
    _loadedCursor = 0;
    _currentFeed.clear();
    _prefetchFuture = null;
    _lastLocation = null;
    _lastFilter = null;
    _sortRule = null;
  }

  // ---------- helpers ----------

  Future<List<Food>> _fetchChunkAt(int cursor) async {
    if (cursor >= _portionIds.length) return [];
    final end = (cursor + _chunkSize).clamp(0, _portionIds.length);
    final ids = _portionIds.sublist(cursor, end);
    final dtos = await _apiService.fetchFoodChunk(foodIds: ids);
    return dtos.map(_dtoToFood).toList();
  }

  Future<void> _refetchPortion() async {
    _loadedCursor = 0;
    final portion = await _apiService.fetchFeedPortion(
      sessionId: _sessionId,
      location: _lastLocation!,
      filter: _lastFilter,
    );
    _portionIds = portion.foodIds;
  }

  void _updateCurrentFeed(List<Food> chunk) {
    _currentFeed.addAll(chunk);
    // Keep only the two most recent chunks in memory.
    final maxItems = _chunkSize * 2;
    if (_currentFeed.length > maxItems) {
      _currentFeed.removeRange(0, _currentFeed.length - maxItems);
    }
  }

  void _applySort(List<Food> chunk) {
    if (_sortRule == null) return;
    switch (_sortRule!) {
      case FoodSortRule.rating:
        chunk.sort((a, b) => b.rating.compareTo(a.rating));
      case FoodSortRule.priceLowToHigh:
        chunk.sort((a, b) => a.price.compareTo(b.price));
      case FoodSortRule.priceHighToLow:
        chunk.sort((a, b) => b.price.compareTo(a.price));
      case FoodSortRule.recentOrdersFirst:
        chunk.sort((a, b) => b.recentOrders.compareTo(a.recentOrders));
      case FoodSortRule.recentOrdersLast:
        chunk.sort((a, b) => a.recentOrders.compareTo(b.recentOrders));
      // Distance-based sorting requires a reference location; skipped here
      // as Food does not carry a coordinate field yet.
      case FoodSortRule.distanceClosestFirst:
      case FoodSortRule.distanceFarthestFirst:
        break;
    }
  }

  Food _dtoToFood(FoodDTO dto) {
    return Food(
      id: dto.foodId,
      name: dto.name,
      price: dto.price,
      rating: dto.rating,
      tags: dto.tags,
      imageUrl: dto.foodThumbnail,
      restaurantImageUrl: dto.restaurantThumbnail,
      restaurant: Restaurant(id: dto.restaurantId, name: dto.restaurantName),
      recentOrders: dto.recentOrders,
      deliveryTime: Duration(minutes: dto.deliveryTimeMinutes),
      unitType: FoodUnitType.values.firstWhere(
        (e) => e.name == dto.unitType,
        orElse: () => FoodUnitType.pcs,
      ),
      size: dto.size,
      calories: dto.calories,
      isDiscounted: dto.isDiscounted,
    );
  }

  static int _computeChunkSize(DeviceProfile device) {
    if (device.dataTransferRateMbps >= 10) return 40;
    if (device.dataTransferRateMbps >= 5) return 30;
    return 20;
  }
}
