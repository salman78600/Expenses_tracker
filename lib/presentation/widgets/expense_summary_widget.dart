import 'package:expenses_tracker/bloc/expense/expense_bloc_bloc.dart';
import 'package:expenses_tracker/bloc/navigation/bottom_navigation_bloc.dart';
import 'package:expenses_tracker/presentation/widgets/day_expense_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalExpense extends StatelessWidget {
  const TotalExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          double total = 0;

          if (state is ExpenseLoadedByDate) {
            final expenses = state.expenses;

            // Filter day's expenses and calculate the total
            total = expenses.fold(0.0, (sum, expense) => sum + expense.amount);
          }

          return DayExpenseWidget(
            expenses: total,
            onAddPressed: () {
              final bloc = BlocProvider.of<NavigationBloc>(context);
              bloc.add(NavigateToAddExpense());
            },
          );
        },
      ),
    );
  }
}
