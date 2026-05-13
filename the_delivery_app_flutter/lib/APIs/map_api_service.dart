import 'package:geolocator/geolocator.dart';

import '../models/location.dart';
import 'i_map_api_service.dart';

class MapAPIService implements IMapAPIService {
  @override
  Future<Location?> getCurrentLocation() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }
      final pos = await Geolocator.getCurrentPosition();
      return Location(pos.latitude, pos.longitude);
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<Location> get locationStream => Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          distanceFilter: 50,
        ),
      ).map((pos) => Location(pos.latitude, pos.longitude));
}
