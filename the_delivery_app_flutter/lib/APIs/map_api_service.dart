import '../models/location.dart';
import 'i_map_api_service.dart';

class MapAPIService implements IMapAPIService {
  @override
  Future<Location?> getCurrentLocation() async {
    // No GPS service connected yet — returns null until wired up.
    return null;
  }

  @override
  Stream<Location> get locationStream async* {
    // No GPS service connected yet — emits nothing until wired up.
  }
}
