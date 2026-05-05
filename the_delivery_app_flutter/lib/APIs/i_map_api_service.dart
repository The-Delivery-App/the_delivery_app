import '../models/location.dart';

abstract class IMapAPIService {
  Future<Location?> getCurrentLocation();
  Stream<Location> get locationStream;
}
