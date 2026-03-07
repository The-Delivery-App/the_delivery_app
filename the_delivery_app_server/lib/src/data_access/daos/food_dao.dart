import 'package:serverpod/serverpod.dart';
import '../../business/models/food.dart';
import '../../business/models/location.dart';
import '../../business/models/restaurant.dart'; // changed: was restaurant_info.dart

/// Data Access Object for food-related database operations.
/// Handles retrieving food items and restaurant information.
class FoodDAO {
  final Database _db;

  FoodDAO(this._db);

  /// Retrieves food items within a specified distance from user location.
  /// Applies filters and limits results based on feed parameters.
  Future<List<Food_DTO>> getFoodByMunicipality(
    String municipality, {
    int limit = 200,
    int offset = 0,
    Map<String, dynamic>? filters,
  }) async {
    try {
      String query = '''
        SELECT DISTINCT f.* FROM food_item f
        JOIN restaurant r ON f.restaurant_id = r.id
        WHERE r.municipality = ?
      ''';

      List<dynamic> values = [municipality];

      if (filters != null && filters['minRating'] != null) {
        query += ' AND f.rating >= ?';
        values.add(filters['minRating']);
      }

      if (filters != null && filters['maxPrice'] != null) {
        query += ' AND f.price <= ?';
        values.add(filters['maxPrice']);
      }

      query +=
          ' ORDER BY f.rating DESC, f.estimated_orders DESC LIMIT ? OFFSET ?';
      values.addAll([limit, offset]);

      final result = await _db.query(query, substitutionValues: values);

      return result.map((row) => _mapRowToFood(row)).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves restaurant information by ID.
  Future<RestaurantInfo?> getRestaurantById(int restaurantId) async {
    try {
      final result = await _db.query(
        '''SELECT id, name, icon_url, latitude, longitude, 
                  municipality, estimated_delivery_time, cuisine 
           FROM restaurant WHERE id = ?''',
        substitutionValues: [restaurantId],
      );

      if (result.isEmpty) {
        return null;
      }

      final row = result.first;
      return _mapRowToRestaurantInfo(row);
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves multiple restaurants by their IDs.
  Future<Map<int, RestaurantInfo>> getRestaurantsByIds(
    List<int> restaurantIds,
  ) async {
    try {
      if (restaurantIds.isEmpty) {
        return {};
      }

      final placeholders = List.filled(restaurantIds.length, '?').join(',');
      final result = await _db.query(
        '''SELECT id, name, icon_url, latitude, longitude, 
                  municipality, estimated_delivery_time, cuisine 
           FROM restaurant WHERE id IN ($placeholders)''',
        substitutionValues: restaurantIds,
      );

      final map = <int, RestaurantInfo>{};
      for (final row in result) {
        final info = _mapRowToRestaurantInfo(row);
        map[info.restaurantId] = info;
      }
      return map;
    } catch (e) {
      rethrow;
    }
  }

  /// Counts total food items available in a municipality.
  Future<int> countFoodByMunicipality(String municipality) async {
    try {
      final result = await _db.query(
        '''SELECT COUNT(*) as count FROM food_item f
           JOIN restaurant r ON f.restaurant_id = r.id
           WHERE r.municipality = ?''',
        substitutionValues: [municipality],
      );

      return (result.first['count'] as int?) ?? 0;
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves all municipalities available in the database.
  Future<List<String>> getAllMunicipalities() async {
    try {
      final result = await _db.query(
        'SELECT DISTINCT municipality FROM restaurant WHERE municipality IS NOT NULL ORDER BY municipality',
      );

      return result.map((row) => row['municipality'] as String).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Maps a database row to a Food object.
  Food_DTO _mapRowToFood(Map<String, dynamic> row) {
    return Food_DTO(
      id: row['id'] as int,
      restaurantId: row['restaurant_id'] as int,
      name: row['name'] as String,
      iconUrl: row['icon_url'] as String?,
      price: (row['price'] as num).toDouble(),
      rating: (row['rating'] as num?)?.toDouble() ?? 0.0,
      estimatedOrdersAmount: (row['estimated_orders'] as int?) ?? 0,
      description: row['description'] as String?,
      nutritionCals: row['nutrition_cals'] as int?,
      createdAt: DateTime.parse(row['created_at'] as String),
    );
  }

  /// Maps a database row to a RestaurantInfo object.
  RestaurantInfo _mapRowToRestaurantInfo(Map<String, dynamic> row) {
    final location = Location(
      latitude: (row['latitude'] as num).toDouble(),
      longitude: (row['longitude'] as num).toDouble(),
      municipality: row['municipality'] as String?,
    );

    return RestaurantInfo(
      restaurantId: row['id'] as int,
      name: row['name'] as String,
      iconUrl: row['icon_url'] as String?,
      location: location,
      estimatedDeliverytime:
          (row['estimated_delivery_time'] as num?)?.toDouble() ?? 30.0,
      cuisine: _parseCuisine(row['cuisine'] as String?),
    );
  }

  /// Parses cuisine types from database format.
  List<String>? _parseCuisine(String? cuisineStr) {
    if (cuisineStr == null || cuisineStr.isEmpty) {
      return null;
    }
    return cuisineStr.split(',').map((c) => c.trim()).toList();
  }
}
