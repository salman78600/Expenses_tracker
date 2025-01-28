part of 'bottom_navigation_bloc.dart';

@immutable
abstract class NavigationState {}

class HomeState extends NavigationState {}

class AddExpenseState extends NavigationState {}

class SummaryState extends NavigationState {}
