import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:the_delivery_app_flutter/screens/restaurant_view.dart';
import 'package:the_delivery_app_flutter/models/restaurant.dart';

void main() {
  testWidgets('RestaurantView shows reviews TC-057..TC-059', (tester) async {
    final resto = const Restaurant(id: '1', name: 'Resto');
    await tester.pumpWidget(
      MaterialApp(home: RestaurantView(restaurant: resto)),
    );

    // Inject review data into private state to avoid network calls
    final state = tester.state(find.byType(RestaurantView));
    (state as dynamic).setState(() {
      (state as dynamic)._reviews = [
        {
          'rating': 5,
          'userName': 'Alice',
          'comment': 'Excellent',
          'foodItemName': 'Pizza',
        },
        {
          'rating': 3,
          'userName': 'Bob',
          'comment': '',
          'foodItemName': '',
        },
      ];
    });

    await tester.pumpAndSettle();

    expect(find.text('Alice'), findsOneWidget);
    expect(find.text('Excellent'), findsOneWidget);
    expect(find.text('Pizza'), findsOneWidget);
    expect(find.text('Bob'), findsOneWidget);
  });
}
