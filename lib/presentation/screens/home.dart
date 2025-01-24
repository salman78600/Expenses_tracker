import 'package:expenses_tracker/bloc/category/category_bloc.dart';
import 'package:expenses_tracker/bloc/expense/expense_bloc_bloc.dart';
import 'package:expenses_tracker/presentation/widgets/header.dart';
import 'package:expenses_tracker/presentation/widgets/header_title.dart';
import 'package:expenses_tracker/presentation/widgets/today_expense_card.dart';
import 'package:expenses_tracker/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
                SizedBox(
                  height: 10,
                ),
                HeaderWidget(),
                SizedBox(
                  height: 5,
                ),
                TodayExpensesCard(
                  expenses: 25.50,
                  onAddPressed: () {
                    print('Add button pressed');
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryInitial) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is CategoryLoaded) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          height: 70,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              final category = state.categories[index];
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        category.icon,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 5),
                                      Text(category.title,
                                          style: Appstyle.bodyText),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                    return Center(child: Text('Unknown state'));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                HeaderTitleWidget(
                    title: "Recent Expenses", viewTitle: "See all"),
                BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (context, state) {
                    if (state is ExpenseLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ExpenseLoaded) {
                      final expenses = state.expenses;
                      return expenses.isEmpty
                          ? Center(
                              child: Text(
                                "There is no expense added yet!",
                                style: Appstyle.bodyText,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: expenses.length,
                              reverse: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final expense = expenses[index];
                                return Dismissible(
                                  key: Key(expense.description),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Expense deleted'),
                                    ));
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                  ),
                                  child: ListTile(
                                    // isThreeLine: true,
                                    title: Text(
                                      expense.description,
                                      style: Appstyle.titleText,
                                    ),
                                    subtitle: Text(
                                      DateFormat('MMMM dd, yyyy')
                                          .format(DateTime.parse(expense.date)),
                                      style: Appstyle.bodyText,
                                    ),
                                    trailing: Text(
                                      '€${expense.amount}',
                                      style: Appstyle.titleText,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
