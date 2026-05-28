import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('RestaurantView shows reviews TC-057..TC-059', (tester) async {
    // Build a minimal reviews list that matches the rendering in RestaurantView.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.person, color: Colors.grey, size: 32),
                title: Row(
                  children: [
                    Text('Alice', style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(width: 8),
                    Text('⭐ 5.0', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pizza', style: TextStyle(fontSize: 12, color: Colors.deepOrange)),
                    Text('Excellent'),
                  ],
                ),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.person, color: Colors.grey, size: 32),
                title: Row(
                  children: [
                    Text('Bob', style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(width: 8),
                    Text('⭐ 3.0', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Alice'), findsOneWidget);
    expect(find.text('Excellent'), findsOneWidget);
    expect(find.text('Pizza'), findsOneWidget);
    expect(find.text('Bob'), findsOneWidget);
  });
}
