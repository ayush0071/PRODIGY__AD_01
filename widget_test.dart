import 'package:calculatorapp/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:MyCalculatorApp/main.dart'; // Update with your actual app's main.dart import

void main() {
  testWidgets('Calculator UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyCalculatorApp()); // Update with your app's main widget

    // Verify if the initial state is correct
    expect(find.text('0'), findsOneWidget);
    expect(find.text(''), findsOneWidget);

    // Tap on buttons to simulate user interactions
    await tapButton(tester, '1');
    await tapButton(tester, '+');
    await tapButton(tester, '2');
    await tapButton(tester, '=');

    // Verify the result after performing an operation
    expect(find.text('3'), findsOneWidget);
    expect(find.text('1+2'), findsNothing);

    // Clear the input
    await tapButton(tester, 'C');

    // Verify the cleared state
    expect(find.text('0'), findsOneWidget);
    expect(find.text(''), findsOneWidget);
  });
}

Future<void> tapButton(WidgetTester tester, String buttonText) async {
  await tester.tap(find.text(buttonText));
  await tester.pump();
}
