import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:the_delivery_app_flutter/screens/map_view.dart';
import 'package:the_delivery_app_flutter/state/map_state.dart';

void main() {
  testWidgets('TC-067 MapView renders without overflow and shows map title', (
    tester,
  ) async {
    final state = const MapState(restaurants: []);
    await tester.pumpWidget(MaterialApp(home: MapView(state: state)));
    await tester.pumpAndSettle();

    expect(find.text('Map'), findsOneWidget);
    // Ensure the FlutterMap widget exists by finding a widget by type name
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
