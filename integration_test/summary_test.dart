import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expenses_tracker/main.dart' as app;

void main() {
  group('Summary Screen Integration Test', () {
    testWidgets('Display summary with loaded expenses',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to SummaryScreen
      await tester
          .tap(find.byIcon(Icons.bar_chart_outlined)); // Use an existing icon
      await tester.pumpAndSettle();

      // Verify SummaryScreen is displayed
      expect(find.text('Expense Summary'), findsOneWidget);

      // Verify loading indicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for data to load
      await tester.pumpAndSettle();

      // Verify summary widgets are displayed
      expect(find.text('Weekly Expense'), findsOneWidget);
      expect(find.text('Monthly Expense'), findsOneWidget);

      // Verify top spending category is displayed if present
      if (find.textContaining('Top Spending Category').evaluate().isNotEmpty) {
        expect(find.textContaining('Top Spending Category'), findsOneWidget);
      }
    });

    testWidgets('Display error message on data load failure',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to SummaryScreen
      await tester.tap(find.byIcon(Icons.bar_chart_outlined));
      await tester.pumpAndSettle();

      // Verify SummaryScreen is displayed
      expect(find.text('Expense Summary'), findsOneWidget);

      // Verify loading indicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Simulate error state
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify error message is displayed
      expect(find.text('Failed to load expenses'), findsOneWidget);
    });
  });
}
