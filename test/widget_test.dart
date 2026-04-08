import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scientific_calculator/main.dart';

void main() {
  testWidgets('Calculator app renders correctly', (WidgetTester tester) async {
    // Set a realistic phone size to avoid overflow in tests with flexible layout
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;

    await tester.pumpWidget(const ScientificCalculatorApp());

    // Verify the app title is displayed
    expect(find.text('Scientific Calculator'), findsOneWidget);

    // Verify the initial display shows 0
    expect(find.text('0'), findsWidgets);

    // Verify some buttons are present
    expect(find.text('sin('), findsOneWidget);
    expect(find.text('cos('), findsOneWidget);
    expect(find.text('='), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
  });
}
