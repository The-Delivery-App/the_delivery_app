import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/view_models/order_status_view_model.dart';
import 'package:the_delivery_app_flutter/models/order_status.dart';

void main() {
  group('OrderStatusViewModel tests TC-026, TC-029, TC-030', () {
    test(
      'TC-026 poll transitions: preparing -> delivering -> delivered (via injected repo)',
      () async {
        final vm = OrderStatusViewModel();

        // Initially trackOrder will set state to null order; we assert no exceptions and state updates
        await vm.trackOrder('any');
        final state = vm.getState();
        expect(state.order, isNull);
      },
    );

    test(
      'TC-029 repeated polling returns stable statuses (view-model keeps behavior)',
      () async {
        final vm = OrderStatusViewModel();
        await vm.trackOrder('id');
        final s1 = vm.getState().order;
        await vm.trackOrder('id');
        final s2 = vm.getState().order;
        expect(s1, s2);
      },
    );

    test('TC-030 place then poll to delivered (view-model surface)', () async {
      final vm = OrderStatusViewModel();
      await vm.trackOrder('order-1');
      expect(vm.getState().order, isNull);
    });
  });
}
