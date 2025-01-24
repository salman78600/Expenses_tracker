import 'package:expenses_tracker/bloc/expense/expense_bloc_bloc.dart';
import 'package:expenses_tracker/presentation/widgets/header_title.dart';
import 'package:expenses_tracker/repository/expense_repository.dart';
import 'package:expenses_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseScreen extends StatelessWidget {
  final ExpenseBloc expenseBloc = ExpenseBloc(ExpenseRepository());

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (_) => expenseBloc,
          child: BlocListener<ExpenseBloc, ExpenseState>(
            listener: (context, state) {
              if (state is ExpenseSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is ExpenseError) {
                print(state.error);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  HeaderTitleWidget(
                    title: "Add Expense",
                    viewTitle: "",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: amountController,
                    decoration: InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final expense = Expense(
                        amount: double.tryParse(amountController.text) ?? 0,
                        description: descriptionController.text,
                        date: DateTime.now().toIso8601String(),
                      );
                      print(expense.amount);
                      print(expense.description);
                      print(expense.date);
                      expenseBloc.add(AddExpense(expense, context));
                    },
                    child: Text('Add Expense'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
