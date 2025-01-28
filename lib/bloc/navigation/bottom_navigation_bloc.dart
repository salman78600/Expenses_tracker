import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(HomeState()) {
    on<NavigateToHome>((event, emit) => emit(HomeState()));
    on<NavigateToAddExpense>((event, emit) => emit(AddExpenseState()));
    on<NavigateToSummary>((event, emit) => emit(SummaryState()));
  }
}
