import 'package:expenses_tracker/bloc/category/category_bloc.dart';
import 'package:expenses_tracker/bloc/expense/expense_bloc_bloc.dart';
import 'package:expenses_tracker/model/expense_model.dart';
import 'package:expenses_tracker/presentation/widgets/category_list_widget.dart';
import 'package:expenses_tracker/utils/datePicker.dart';
import 'package:expenses_tracker/utils/app_style.dart';
import 'package:expenses_tracker/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

/* 
  AddExpenseScreen allows users to input and add an expense to the tracker app.
  It includes fields for amount, description, date, and category. The screen uses Flutter Bloc
  to handle expense and category data.

  Features:
  - Form with validation for amount, description, date, and category.
  - Date picker for selecting the date.
  - Category selection from CategoryList widget.
  - Feedback through snack bars for success or error states.
*/

class AddExpenseScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseBloc = context.read<ExpenseBloc>(); // Access ExpenseBloc
    // final categoryBloc = context.read<CategoryBloc>(); // Access CategoryBloc
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocListener<ExpenseBloc, ExpenseState>(
            listener: (context, state) {
              if (state is ExpenseSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: titleTextWhite,
                    ),
                  ),
                );
              } else if (state is ExpenseError) {
                print(state.error);
                showSnackBar(context, state.error);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Add Expense", style: titleText),
                    Text("Enter your expense details", style: bodyText),
                    SizedBox(
                      height: 10,
                    ),
                    fieldLabel("*Amount"),
                    TextFormField(
                      controller: amountController,
                      decoration: InputDecoration(
                        hintText: '0.0',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Please enter an amount';
                        }
                        if (double.tryParse(value) == null) {
                          return '*Please enter a valid amount';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    fieldLabel("*Description"),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Enter description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Please enter a description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    fieldLabel("*Date"),
                    TextFormField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Select a date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        DateTime? selectedDate = await showGlobalDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                        );
                        dateController.text =
                            DateFormat("dd-MM-yyyy").format(selectedDate!);
                        print(selectedDate);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Please select a date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    fieldLabel("*Category"),
                    // Category list
                    CategoryList(),
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.black, // Set the background color to black
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5), // Set the border radius to zero
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Access the selected category from CategoryBloc
                            final categoryBloc = context.read<CategoryBloc>();
                            final currentState = categoryBloc.state;

                            if (currentState is CategoryLoaded &&
                                currentState.selectedCategory != null) {
                              final selectedCategory =
                                  currentState.selectedCategory;

                              final expense = Expense(
                                amount:
                                    double.tryParse(amountController.text) ?? 0,
                                description: descriptionController.text,
                                date: dateController.text,
                                category: selectedCategory!
                                    .title, // Use the selected category ID
                              );

                              expenseBloc.add(AddExpense(expense, context));
                            } else {
                              showSnackBar(context, "Please select a category");
                            }
                          }
                        },
                        child: Text(
                          'Add Expense',
                          style: TextStyle(
                              color: Colors
                                  .white), // Set text color to white for contrast
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget fieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        label,
        style: bodyTextBold,
      ),
    );
  }
}
