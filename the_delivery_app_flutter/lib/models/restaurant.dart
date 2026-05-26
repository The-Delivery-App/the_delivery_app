class Restaurant {
  final String id;
  final String name;
  final double? latitude;
  final double? longitude;
  final String? cuisine;

  const Restaurant({required this.id, required this.name, this.latitude, this.longitude, this.cuisine});
}
