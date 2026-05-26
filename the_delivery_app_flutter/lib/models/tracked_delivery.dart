class TrackedDelivery {
  final int orderId;
  final double restaurantLat;
  final double restaurantLng;
  final String restaurantName;
  String? courierName;
  String? courierVehicle;
  String? courierPlate;
  String? courierPhone;
  int? courierId;

  TrackedDelivery({
    required this.orderId,
    required this.restaurantLat,
    required this.restaurantLng,
    required this.restaurantName,
  });
}
