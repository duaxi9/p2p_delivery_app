import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen builds correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}