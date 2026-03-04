class Food {
  final String id;
  final String name;
  final double price;
  final double rating;
  final List<String> tags;
  final String imageUrl;
  final String restaurantImageUrl;
  final Restaurant restaurant;
  final int recentOrders;
  final Time deliveryTime;

  const Food({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.tags,
    required this.imageUrl,
    required this.restaurantImageUrl,
    required this.restaurant,
    required this.recentOrders,
    required this.deliveryTime
  });
}
