import 'package:expenses_tracker/presentation/widgets/expense_list_widget.dart';
import 'package:expenses_tracker/presentation/widgets/header_widget.dart';
import 'package:expenses_tracker/presentation/widgets/header_title_widget.dart';
import 'package:expenses_tracker/presentation/widgets/expense_summary_widget.dart';
import 'package:flutter/material.dart';

/* 
  This is the ExpenseListScreen widget.
  It serves as the main screen for displaying the user's expenses, including:
  - A header with the app's name or title.
  - A section showing day total expenses.
  - A header for the expenses list.
  - A list displaying the user's recent expenses.
*/
class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header widget
                const HeaderWidget(),

                // Calculate today's total expenses
                const TotalExpense(),

                // Recent expenses
                HeaderTitleWidget(title: "Expenses List", viewTitle: ""),

                //Reecent expenses list
                const ExpenseListTileWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
