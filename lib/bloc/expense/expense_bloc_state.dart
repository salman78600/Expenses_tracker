part of 'expense_bloc_bloc.dart';

@immutable
sealed class ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;

  ExpenseLoaded(this.expenses);
}

class ExpenseSuccess extends ExpenseState {
  final String message;

  ExpenseSuccess(this.message);
}

class ExpenseError extends ExpenseState {
  final String error;

  ExpenseError(this.error);
}
