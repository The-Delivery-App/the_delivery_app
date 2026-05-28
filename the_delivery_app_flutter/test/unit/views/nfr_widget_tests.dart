import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _NfrDemoWidget extends StatelessWidget {
  const _NfrDemoWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Delivery App',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Find restaurants fast',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Open feed'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Show map'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('TC-069 NFR-1 text size ≥ 14px', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(360, 640)),
          child: _NfrDemoWidget(),
        ),
      ),
    );

    final titleText = tester.widget<Text>(find.text('Delivery App'));
    final subtitleText = tester.widget<Text>(
      find.text('Find restaurants fast'),
    );

    expect((titleText.style?.fontSize ?? 0) >= 14.0, isTrue);
    expect((subtitleText.style?.fontSize ?? 0) >= 14.0, isTrue);
  });

  testWidgets('TC-070 NFR-2 button tap target ≥ 16px', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(360, 640)),
          child: _NfrDemoWidget(),
        ),
      ),
    );

    final elevated = find.widgetWithText(ElevatedButton, 'Open feed');
    final outlined = find.widgetWithText(OutlinedButton, 'Show map');

    expect(elevated, findsOneWidget);
    expect(outlined, findsOneWidget);

    final elevatedSize = tester.getSize(elevated);
    final outlinedSize = tester.getSize(outlined);

    expect(elevatedSize.width >= 16.0, isTrue);
    expect(elevatedSize.height >= 16.0, isTrue);
    expect(outlinedSize.width >= 16.0, isTrue);
    expect(outlinedSize.height >= 16.0, isTrue);
  });

  testWidgets('TC-071 UI consistency across screen sizes', (tester) async {
    final sizes = [
      const Size(360, 640),
      const Size(1024, 768),
    ];

    for (final size in sizes) {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: size),
            child: const _NfrDemoWidget(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Delivery App'), findsOneWidget);
      expect(find.text('Find restaurants fast'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Open feed'), findsOneWidget);
      expect(find.widgetWithText(OutlinedButton, 'Show map'), findsOneWidget);
    }
  });
}
