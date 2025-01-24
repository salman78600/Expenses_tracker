part of 'bottom_navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class NavigateToHome extends NavigationEvent {}

class NavigateToAddExpense extends NavigationEvent {}

class NavigateToSummary extends NavigationEvent {}
