import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:the_delivery_app_flutter/screens/favourites_view.dart';

void main() {
  testWidgets('FavouritesView displays favourite items TC-055..TC-056', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: FavouritesView()));

    // Access private state and set favourites directly to avoid network calls.
    final state = tester.state(find.byType(FavouritesView));
    (state as dynamic).setState(() {
      (state as dynamic)._isLoading = false;
      (state as dynamic)._favourites = [
        {
          'id': 1,
          'type': 'food',
          'foodItemName': 'Test Food',
          'foodItemPrice': 4.5,
        },
      ];
    });

    await tester.pumpAndSettle();

    expect(find.text('Test Food'), findsOneWidget);
    expect(find.text('£4.50'), findsOneWidget);
  });
}
