import 'package:bloc/bloc.dart';
import 'package:expenses_tracker/repository/expense_repository.dart';
import 'package:expenses_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'expense_bloc_event.dart';
part 'expense_bloc_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository expenseRepository;

  ExpenseBloc(this.expenseRepository) : super(ExpenseLoading()) {
    on<AddExpense>(_onAddExpense);
    on<GetExpenses>(_onGetExpenses);
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
      await expenseRepository.addExpense(event.expense);

      emit(ExpenseSuccess("Expense added successfully"));
      // Navigate to home screen and reload expenses
      event.context.read<ExpenseBloc>().add(GetExpenses());
    } catch (e) {
      emit(ExpenseError("Failed to add expense: ${e.toString()}"));
    }
  }

  // get expenses event handler
  Future<void> _onGetExpenses(
      GetExpenses event, Emitter<ExpenseState> emit) async {
    try {
      emit(ExpenseLoading());
      final expenses = await expenseRepository.getExpenses();
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError("Failed to get expenses: ${e.toString()}"));
    }
  }
}
