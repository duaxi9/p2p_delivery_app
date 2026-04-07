import 'package:flutter_test/flutter_test.dart';
import 'package:p2p_delivery_app/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Karim'), findsOneWidget);
  });
}