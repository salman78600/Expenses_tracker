import 'package:bloc/bloc.dart';
import 'package:expenses_tracker/repository/expense_repository.dart';
import 'package:expenses_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'expense_bloc_event.dart';
part 'expense_bloc_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository expenseRepository;

  ExpenseBloc(this.expenseRepository) : super(ExpenseLoading()) {
    on<AddExpense>(_onAddExpense);
    on<GetExpenses>(_onGetExpenses);
    on<FilterExpensesByDate>(_onFilterExpensesByDate);
    on<DeleteExpenseEvent>(_onDeleteExpenseEvent);
  }

  // add expense event handler
  Future<void> _onAddExpense(
      AddExpense event, Emitter<ExpenseState> emit) async {
    try {
      // Validate the expense data
      if (event.expense.amount <= 0) {
        emit(ExpenseError("Amount must be greater than zero"));
        return;
      }
      if (event.expense.description.isEmpty) {
        emit(ExpenseError("Description cannot be empty"));
        return;
      }

      emit(ExpenseLoading());

      // Add the expense to the database
      await expenseRepository.save(event.expense.toMap());

      emit(ExpenseSuccess("Expense added successfully"));
      // Navigate to home screen and reload expenses
      event.context.read<ExpenseBloc>().add(FilterExpensesByDate(
          DateFormat('dd-MM-yyyy').format(DateTime.now())));
      Navigator.of(event.context).pushReplacementNamed('/main');
    } catch (e) {
      emit(ExpenseError("Failed to add expense: ${e.toString()}"));
    }
  }

  // get expenses event handler
  Future<void> _onGetExpenses(
      GetExpenses event, Emitter<ExpenseState> emit) async {
    try {
      emit(ExpenseLoading());

      // Fetch expenses from the repository
      final expenses = await expenseRepository.get();

      double weeklyTotal = 0.0;
      double monthlyTotal = 0.0;
      String mostExpensiveCategory = 'No Category';
      double mostExpensiveCategoryTotal = 0;

      if (expenses.isNotEmpty) {
        DateTime today = DateTime.now();

        // Get the start and end of the current week
        DateTime startOfWeek =
            today.subtract(Duration(days: today.weekday - 1));
        DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

        // Get the start and end of the current month
        DateTime startOfMonth = DateTime(today.year, today.month, 1);
        DateTime endOfMonth = DateTime(today.year, today.month + 1, 1)
            .subtract(Duration(days: 1));

        // Custom date format to parse 'dd-MM-yyyy' string format
        final customDateFormat = DateFormat('dd-MM-yyyy');

        // Calculate weekly total
        weeklyTotal = expenses.where((expense) {
          DateTime expenseDate = customDateFormat.parse(expense.date);

          DateTime startOfWeekAtMidnight =
              DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
          DateTime endOfWeekAtMidnight = DateTime(
              endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59, 999);

          return expenseDate
                  .isAfter(startOfWeekAtMidnight.subtract(Duration(days: 1))) &&
              expenseDate.isBefore(endOfWeekAtMidnight.add(Duration(days: 1)));
        }).fold(0.0, (sum, expense) => sum + expense.amount);

        // Calculate monthly total
        monthlyTotal = expenses.where((expense) {
          DateTime expenseDate = customDateFormat.parse(expense.date);

          return expenseDate
                  .isAfter(startOfMonth.subtract(Duration(seconds: 1))) &&
              expenseDate.isBefore(endOfMonth.add(Duration(seconds: 1)));
        }).fold(0.0, (sum, expense) => sum + expense.amount);

        // Calculate the total for each category and track the most expensive category
        Map<String, double> categoryTotals = {};
        for (var expense in expenses) {
          String category = expense.category.toString();
          categoryTotals[category] =
              (categoryTotals[category] ?? 0.0) + expense.amount;
        }

        mostExpensiveCategory = categoryTotals.entries
            .reduce((a, b) => a.value > b.value ? a : b)
            .key;

        mostExpensiveCategoryTotal =
            categoryTotals[mostExpensiveCategory] ?? 0.0;
      }

      // Emit the ExpenseLoaded state with the calculated totals
      emit(ExpenseLoaded(
        expenses,
        weeklyTotal,
        monthlyTotal,
        mostExpensiveCategory,
        mostExpensiveCategoryTotal,
      ));
    } catch (e) {
      emit(ExpenseError("Failed to get expenses: ${e.toString()}"));
    }
  }

  Future<void> _onFilterExpensesByDate(
      FilterExpensesByDate event, Emitter<ExpenseState> emit) async {
    try {
      emit(ExpenseLoading());
      final expenses = await expenseRepository.getByDate(event.date.toString());
      emit(ExpenseLoadedByDate(expenses));
    } catch (e) {
      emit(ExpenseError("Failed to get expenses: ${e.toString()}"));
    }
  }

  // delete expense event handler
  void _onDeleteExpenseEvent(
      DeleteExpenseEvent event, Emitter<ExpenseState> emit) async {
    try {
      await expenseRepository.delete(int.parse(event.id));
      final updatedExpenses =
          await expenseRepository.getByDate(event.date.toString());
      emit(ExpenseLoadedByDate(updatedExpenses));
    } catch (_) {
      emit(ExpenseError('Failed to delete expense'));
    }
  }
}
