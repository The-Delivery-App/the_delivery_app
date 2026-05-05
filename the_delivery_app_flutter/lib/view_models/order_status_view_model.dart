import 'package:flutter/foundation.dart';

import '../state/order_status_state.dart';

class OrderStatusViewModel extends ChangeNotifier {
  OrderStatusState _state = const OrderStatusState();

  OrderStatusViewModel();

  OrderStatusState getState() => _state;

  Future<void> trackOrder(String orderId) async {
    // No backend connected yet — order stays null until wired up.
    _state = const OrderStatusState(order: null);
    notifyListeners();
  }
}
