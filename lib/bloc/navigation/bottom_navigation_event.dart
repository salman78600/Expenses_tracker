part of 'bottom_navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

class NavigateToHome extends NavigationEvent {}

class NavigateToAddExpense extends NavigationEvent {}

class NavigateToSummary extends NavigationEvent {}
