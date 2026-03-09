import 'package:the_delivery_app_server/src/business/models/location.dart';
import 'restaurant.dart';

/// Represents a food item available for delivery.
class Food_DTO {
  final int? id;
  final int restaurantId;
  final String name;
  final String? iconUrl;
  final double price;
  final double rating; // 0-5 stars
  final int estimatedOrdersAmount; // Number of orders for this item
  final String? description;
  final int? nutritionCals;
  final DateTime createdAt;

  Food_DTO({
    this.id,
    required this.restaurantId,
    required this.name,
    this.iconUrl,
    required this.price,
    required this.rating,
    required this.estimatedOrdersAmount,
    this.description,
    this.nutritionCals,
    required this.createdAt,
  });

  /// Creates a copy of this Food with optional field overrides.
  Food_DTO copyWith({
    int? id,
    int? restaurantId,
    String? name,
    String? iconUrl,
    double? price,
    double? rating,
    int? estimatedOrdersAmount,
    String? description,
    int? nutritionCals,
    DateTime? createdAt,
  }) {
    return Food_DTO(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      iconUrl: iconUrl ?? this.iconUrl,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      estimatedOrdersAmount:
          estimatedOrdersAmount ?? this.estimatedOrdersAmount,
      description: description ?? this.description,
      nutritionCals: nutritionCals ?? this.nutritionCals,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

/// Feed request containing device information and location data.
class FeedRequest {
  final int screenWidth; // in pixels
  final int screenHeight;
  final int dpi; // dots per inch
  final double dataTransferRate; // in Mbps
  final Location userLocation;
  final int chunkSize; // Number of items to fetch per chunk
  final Map<String, dynamic>? filters; // Optional filters

  FeedRequest({
    required this.screenWidth,
    required this.screenHeight,
    required this.dpi,
    required this.dataTransferRate,
    required this.userLocation,
    required this.chunkSize,
    this.filters,
  });
}

/// Response containing a chunk of food items and restaurant information.
class FeedResponse {
  final bool success;
  final List<FoodItem> foodItems;
  final List<RestaurantInfo> restaurants;
  final int totalItemsAvailable; // Total items available in DB
  final int fetchedCount; // Items fetched in this response
  final String? errorMessage;

  FeedResponse({
    required this.success,
    required this.foodItems,
    required this.restaurants,
    required this.totalItemsAvailable,
    required this.fetchedCount,
    this.errorMessage,
  });
}

/// Complete food item with associated restaurant information.
class FoodItem {
  final Food_DTO food;
  final RestaurantInfo restaurant;
  final double? distanceToRestaurant; // in km

  FoodItem({
    required this.food,
    required this.restaurant,
    this.distanceToRestaurant,
  });
}
