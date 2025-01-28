import 'package:expenses_tracker/bloc/expense/expense_bloc_bloc.dart';
import 'package:expenses_tracker/enums/expense_category.dart';
import 'package:expenses_tracker/utils/app_style.dart';
import 'package:expenses_tracker/utils/category_helper.dart';
import 'package:expenses_tracker/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class ExpenseListTileWidget extends StatelessWidget {
  const ExpenseListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if (state is ExpenseLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ExpenseLoadedByDate) {
          final expenses = state.expenses;
          return expenses.isEmpty
              ? Center(
                  child: Text(
                    "There is no expense data to display!",
                    style: bodyText,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: expenses.length,
                  reverse: true,
                  addAutomaticKeepAlives: true,
                  addRepaintBoundaries: true,
                  addSemanticIndexes: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Dismissible(
                            key: Key(expense.description),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              context.read<ExpenseBloc>().add(
                                  DeleteExpenseEvent(
                                      expenses[index].id.toString(),
                                      DateFormat('dd-MM-yyyy')
                                          .format(DateTime.now())));
                              showSnackBar(context, "Expense has been deleted");
                            },
                            background: Container(
                              color: Color(0xFFb33939),
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            child: ListTile(
                              // isThreeLine: true,
                              title: Text(
                                expense.description,
                                style: titleText14,
                              ),
                              subtitle: Text(
                                expense.date.toString(),
                                style: bodyText,
                              ),
                              trailing: Text(
                                '€${expense.amount}',
                                style: titleText,
                              ),
                              leading: Icon(
                                getIconForCategory(
                                    ExpenseCategory.values.firstWhere(
                                  (e) =>
                                      e.toString().split('.').last ==
                                      expense.category,
                                  orElse: () => ExpenseCategory.Other,
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
        } else if (state is ExpenseError) {
          return Center(child: Text(state.error));
        }
        return Center(child: Text('Unknown state'));
      },
    );
  }
}
