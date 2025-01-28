part of 'expense_bloc_bloc.dart';

@immutable
sealed class ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  final double weeklyTotal;
  final double monthlyTotal;
  final String mostExpensiveCategory;
  final double mostExpensiveCategoryTotal;

  ExpenseLoaded(
    this.expenses,
    this.weeklyTotal,
    this.monthlyTotal,
    this.mostExpensiveCategory,
    this.mostExpensiveCategoryTotal,
  );
}

class ExpenseLoadedByDate extends ExpenseState {
  final List<Expense> expenses;

  ExpenseLoadedByDate(this.expenses);
}

class ExpenseSuccess extends ExpenseState {
  final String message;

  ExpenseSuccess(this.message);
}

class ExpenseError extends ExpenseState {
  final String error;

  ExpenseError(this.error);
}
