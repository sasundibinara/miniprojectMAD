// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:miniprojectmad/main.dart';

void main() {
  testWidgets('scores runs, wickets, overs, and reset', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CricketApp());

    expect(find.text('0/0'), findsOneWidget);
    expect(find.text('0.0'), findsOneWidget);

    final fourButton = find.widgetWithText(ElevatedButton, '4');
    await tester.ensureVisible(fourButton);
    await tester.tap(fourButton);

    final wicketButton = find.widgetWithText(ElevatedButton, 'Wicket');
    await tester.ensureVisible(wicketButton);
    await tester.tap(wicketButton);
    await tester.pump();

    expect(find.text('4/1'), findsOneWidget);
    expect(find.text('0.2'), findsOneWidget);
    expect(find.text('4'), findsWidgets);

    final resetButton = find.widgetWithText(ElevatedButton, 'Reset');
    await tester.ensureVisible(resetButton);
    await tester.tap(resetButton);
    await tester.pump();

    expect(find.text('0/0'), findsOneWidget);
    expect(find.text('0.0'), findsOneWidget);
  });
}
