// Basic widget test for Union Shop
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('App starts and displays homepage', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Verify the app bar title
    expect(find.text('Union Shop'), findsWidgets);
  });
}
