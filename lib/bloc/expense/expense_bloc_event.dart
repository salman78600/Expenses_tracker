part of 'expense_bloc_bloc.dart';

@immutable
sealed class ExpenseEvent {}

class AddExpense extends ExpenseEvent {
  final Expense expense;
  final BuildContext context;

  AddExpense(this.expense, this.context);
}

class GetExpenses extends ExpenseEvent {}

class FilterExpensesByDate extends ExpenseEvent {
  final String? date;
  FilterExpensesByDate(this.date);
}

class DeleteExpenseEvent extends ExpenseEvent {
  final String id;
  final String date;

  DeleteExpenseEvent(this.id, this.date);
}
