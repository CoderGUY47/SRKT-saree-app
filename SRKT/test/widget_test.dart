// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nexus_b2b_app/main.dart';

void main() {
  testWidgets('Welcome screen has Get started button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our welcome screen has the "Get started -->" button.
    expect(find.text('Get started -->'), findsOneWidget);

    // Tap the button and trigger a frame.
    await tester.tap(find.text('Get started -->'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the login screen.
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Successful login navigates to Home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Navigate to Login Screen
    await tester.tap(find.text('Get started -->'));
    await tester.pumpAndSettle();

    // Enter email/mobile
    await tester.enterText(find.byType(TextFormField).at(0), 'admin@gmail');

    // Enter password
    await tester.enterText(find.byType(TextFormField).at(1), '1234');

    // Tap login button
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify home screen is loaded
    expect(find.text('Popular Picks'), findsOneWidget);
    expect(find.text('SRKT'), findsOneWidget);
  });
}
