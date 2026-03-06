class FoodDTO {
  final String foodId;
  final String name;
  final double price;
  final double rating;
  final List<String> tags;
  final String foodThumbnail;
  final String restaurantThumbnail;
  final String restaurantId;
  final String restaurantName;
  final int recentOrders;
  final int deliveryTimeMinutes;
  final String unitType;
  final int size;
  final int calories;
  final bool isDiscounted;

  const FoodDTO({
    required this.foodId,
    required this.name,
    required this.price,
    required this.rating,
    required this.tags,
    required this.foodThumbnail,
    required this.restaurantThumbnail,
    required this.restaurantId,
    required this.restaurantName,
    required this.recentOrders,
    required this.deliveryTimeMinutes,
    required this.unitType,
    required this.size,
    required this.calories,
    required this.isDiscounted,
  });

  factory FoodDTO.fromJson(Map<String, dynamic> json) => FoodDTO(
    foodId: json['food_id'] as String,
    name: json['name'] as String,
    price: (json['price'] as num).toDouble(),
    rating: (json['rating'] as num).toDouble(),
    tags: (json['tags'] as List<dynamic>).cast<String>(),
    foodThumbnail: json['food_thumbnail'] as String,
    restaurantThumbnail: json['restaurant_thumbnail'] as String,
    restaurantId: json['restaurant_id'] as String,
    restaurantName: json['restaurant_name'] as String,
    recentOrders: json['recent_orders'] as int,
    deliveryTimeMinutes: json['delivery_time_minutes'] as int,
    unitType: json['unit_type'] as String,
    size: json['size'] as int,
    calories: json['calories'] as int,
    isDiscounted: json['is_discounted'] as bool,
  );
}
