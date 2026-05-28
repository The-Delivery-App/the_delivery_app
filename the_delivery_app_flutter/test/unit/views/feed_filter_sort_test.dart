import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_delivery_app_flutter/screens/feed_view.dart';
import 'package:the_delivery_app_flutter/models/food.dart';
import 'package:the_delivery_app_flutter/models/restaurant.dart';
import 'package:the_delivery_app_flutter/models/food_sort_rule.dart';
import 'package:the_delivery_app_flutter/models/food_unit_type.dart';
import 'package:the_delivery_app_flutter/state/feed_state.dart';

Food makeFoodWith({
  required String id,
  required double price,
  required bool discounted,
  required String restName,
  double rating = 4.0,
}) => Food(
  id: id,
  name: 'Food $id',
  price: price,
  rating: rating,
  tags: const [],
  imageUrl: '',
  restaurantImageUrl: '',
  restaurant: Restaurant(id: id, name: restName),
  recentOrders: 0,
  deliveryTime: const Duration(minutes: 20),
  unitType: FoodUnitType.pcs,
  size: 1,
  calories: 100,
  isDiscounted: discounted,
);

void main() {
  group('Feed view filter & sort', () {
    testWidgets('TC-040 onlyDiscounted filters out non-discounted items', (
      tester,
    ) async {
      final f1 = makeFoodWith(
        id: '1',
        price: 5.0,
        discounted: true,
        restName: 'A',
      );
      final f2 = makeFoodWith(
        id: '2',
        price: 10.0,
        discounted: false,
        restName: 'A',
      );
      final state = FeedState(feedItems: [f1, f2], isLoading: false);

      await tester.pumpWidget(
        MaterialApp(home: FeedView(state: state, onlyDiscounted: true)),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Food 1'), findsOneWidget);
      expect(find.text('Food 2'), findsNothing);
    });

    testWidgets(
      'TC-041 cuisine filter returns only matching restaurant cuisine',
      (tester) async {
        final f1 = makeFoodWith(
          id: '1',
          price: 5.0,
          discounted: false,
          restName: 'Pizza Place',
        );
        final f2 = makeFoodWith(
          id: '2',
          price: 10.0,
          discounted: false,
          restName: 'Sushi Bar',
        );
        final state = FeedState(feedItems: [f1, f2], isLoading: false);

        final cuisines = {'Pizza Place': 'Italian', 'Sushi Bar': 'Japanese'};

        await tester.pumpWidget(
          MaterialApp(
            home: FeedView(
              state: state,
              cuisine: 'Italian',
              restaurantCuisines: cuisines,
            ),
          ),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Food 1'), findsOneWidget);
        expect(find.text('Food 2'), findsNothing);
      },
    );

    testWidgets('TC-042 priceTier low returns lowest quartile items', (
      tester,
    ) async {
      final f1 = makeFoodWith(
        id: '1',
        price: 5.0,
        discounted: false,
        restName: 'A',
      );
      final f2 = makeFoodWith(
        id: '2',
        price: 10.0,
        discounted: false,
        restName: 'A',
      );
      final f3 = makeFoodWith(
        id: '3',
        price: 15.0,
        discounted: false,
        restName: 'A',
      );
      final f4 = makeFoodWith(
        id: '4',
        price: 20.0,
        discounted: false,
        restName: 'A',
      );
      final state = FeedState(feedItems: [f1, f2, f3, f4], isLoading: false);

      await tester.pumpWidget(
        MaterialApp(
          home: FeedView(state: state, priceTier: 'low'),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // low should include the lowest quartile: prices <= q1 (10.0)
      expect(find.text('Food 1'), findsOneWidget);
      expect(find.text('Food 2'), findsOneWidget);
      expect(find.text('Food 3'), findsNothing);
      expect(find.text('Food 4'), findsNothing);
    });

    testWidgets('TC-043 filter no matches returns empty message', (
      tester,
    ) async {
      final f1 = makeFoodWith(
        id: '1',
        price: 5.0,
        discounted: false,
        restName: 'A',
      );
      final f2 = makeFoodWith(
        id: '2',
        price: 10.0,
        discounted: false,
        restName: 'B',
      );
      final state = FeedState(feedItems: [f1, f2], isLoading: false);

      await tester.pumpWidget(
        MaterialApp(
          home: FeedView(
            state: state,
            cuisine: 'Martian',
            restaurantCuisines: {'A': 'Italian', 'B': 'Japanese'},
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('No foods match your filters.'), findsOneWidget);
    });

    testWidgets('TC-044 sort price low to high orders items ascending', (
      tester,
    ) async {
      final f1 = makeFoodWith(
        id: '1',
        price: 20.0,
        discounted: false,
        restName: 'A',
      );
      final f2 = makeFoodWith(
        id: '2',
        price: 5.0,
        discounted: false,
        restName: 'A',
      );
      final f3 = makeFoodWith(
        id: '3',
        price: 12.0,
        discounted: false,
        restName: 'A',
      );
      final state = FeedState(feedItems: [f1, f2, f3], isLoading: false);

      await tester.pumpWidget(
        MaterialApp(
          home: FeedView(state: state, sortRule: FoodSortRule.priceLowToHigh),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // The visible order should be f2 (5.0), f3 (12.0), f1 (20.0)
      final listFinder = find.byType(ListView);
      expect(find.text('Food 2'), findsOneWidget);
      expect(find.text('Food 3'), findsOneWidget);
      expect(find.text('Food 1'), findsOneWidget);
    });
  });
}
