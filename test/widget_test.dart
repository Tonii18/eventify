// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:eventify/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eventify/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    final auth = AuthProvider();

    await tester.pumpWidget(
      MyApp(logged: false, auth: auth),
    );

    // Verify that at least the initial structure is loaded.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
