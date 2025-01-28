import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expenses_tracker/main.dart' as app;

void main() {
  group('Add Expense Screen Integration Test', () {
    testWidgets('Add expense with valid data', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to AddExpenseScreen
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Verify AddExpenseScreen is displayed
      expect(find.text('Add Expense'), findsOneWidget);

      // Enter amount
      await tester.enterText(find.byType(TextFormField).at(0), '100.0');
      await tester.pump();

      // Enter description
      await tester.enterText(find.byType(TextFormField).at(1), 'Groceries');
      await tester.pump();

      // Select date
      await tester.tap(find.byIcon(Icons.calendar_today));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pump();

      // Select category
      await tester.tap(find.text('Select Category'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Food'));
      await tester.pump();

      // Submit form
      await tester.tap(find.text('Add Expense'));
      await tester.pumpAndSettle();

      // Verify success message
      expect(find.text('Expense added successfully'), findsOneWidget);
    });

    testWidgets('Show error when required fields are empty',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to AddExpenseScreen
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Submit form without entering data
      await tester.tap(find.text('Add Expense'));
      await tester.pumpAndSettle();

      // Verify error messages
      expect(find.text('*Please enter an amount'), findsOneWidget);
      expect(find.text('*Please enter a description'), findsOneWidget);
      expect(find.text('*Please select a date'), findsOneWidget);
      expect(find.text('Please select a category'), findsOneWidget);
    });
  });
}
