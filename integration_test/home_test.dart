import 'package:expenses_tracker/bloc/expense/expense_bloc_bloc.dart';
import 'package:expenses_tracker/presentation/screens/home.dart';
import 'package:expenses_tracker/presentation/widgets/expense_list_widget.dart';
import 'package:expenses_tracker/presentation/widgets/expense_summary_widget.dart';
import 'package:expenses_tracker/presentation/widgets/header_widget.dart';
import 'package:expenses_tracker/repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpenseListScreen Integration Test', () {
    testWidgets('should display all widgets and interact correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => ExpenseBloc(ExpenseRepository()),
          child: MaterialApp(
            home: ExpenseListScreen(),
          ),
        ),
      );

      // Act & Assert: Verify HeaderWidget is displayed
      expect(find.byType(HeaderWidget), findsOneWidget);

      // Verify TotalExpense widget is displayed
      expect(find.byType(TotalExpense), findsOneWidget);

      // Verify HeaderTitleWidget with specific title is displayed
      expect(find.text("Expenses List"), findsOneWidget);

      // Verify ExpenseListTileWidget is displayed
      expect(find.byType(ExpenseListTileWidget), findsOneWidget);

      // Simulate scrolling through the SingleChildScrollView
      final scrollableFinder = find.byType(SingleChildScrollView);
      await tester.drag(scrollableFinder, const Offset(0, -200));
      await tester.pump();

      // Verify scrolling works without errors
      expect(scrollableFinder, findsOneWidget);
    });
  });
}
