import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/view_models/map_view_model.dart';
import 'package:the_delivery_app_flutter/APIs/i_map_api_service.dart';
import 'package:the_delivery_app_flutter/models/location.dart';
import 'dart:async';

class FakeMapApi implements IMapAPIService {
  final StreamController<Location> _ctrl =
      StreamController<Location>.broadcast();
  @override
  Future<Location> getCurrentLocation() async => const Location(51.0, -0.1);

  @override
  Stream<Location> get locationStream => _ctrl.stream;

  void push(Location l) => _ctrl.add(l);

  void dispose() => _ctrl.close();
}

void main() {
  test(
    'TC-068 MapViewModel.updateLocation updates state and listens',
    () async {
      final fake = FakeMapApi();
      final vm = MapViewModel(apiService: fake);

      await vm.updateLocation();
      final s1 = vm.getState();
      expect(s1.currentLocation, isNotNull);
      expect(s1.currentLocation!.latitude, equals(51.0));

      // push a new location and verify state updates via listener
      fake.push(const Location(52.0, 0.0));
      // allow async listener to run
      await Future.delayed(const Duration(milliseconds: 50));
      final s2 = vm.getState();
      expect(s2.currentLocation!.latitude, equals(52.0));
      fake.dispose();
    },
  );
}
