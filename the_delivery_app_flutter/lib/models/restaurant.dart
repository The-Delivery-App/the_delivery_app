class Restaurant {
  final String id;
  final String name;
  final double? latitude;
  final double? longitude;

  const Restaurant({required this.id, required this.name, this.latitude, this.longitude});
}
