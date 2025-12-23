// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:resistor_calculator/main.dart';
import 'package:resistor_calculator/home_screen.dart'; // Import home_screen

void main() {
  testWidgets('HomeScreen displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ResistorCalculatorApp());

    // Verify that the HomeScreen is present.
    expect(find.byType(HomeScreen), findsOneWidget);

    // Verify that the AppBar title is correct.
    expect(find.text('Resistor Calculator'), findsOneWidget);

    // Verify that the initial tabs are present.
    expect(find.text('4-Band'), findsOneWidget);
    expect(find.text('5-Band'), findsOneWidget);
    expect(find.text('SMD'), findsOneWidget);
    expect(find.text('E-Series'), findsOneWidget);
  });
}
