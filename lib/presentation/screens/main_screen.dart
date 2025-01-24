import 'package:expenses_tracker/bloc/navigationbar/bottom_navigation_bloc.dart';
import 'package:expenses_tracker/presentation/screens/add_expense.dart';
import 'package:expenses_tracker/presentation/screens/home.dart';
import 'package:expenses_tracker/presentation/screens/summary.dart';
import 'package:expenses_tracker/presentation/widgets/bottom_navigationnbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          Widget getCurrentScreen() {
            if (state is HomeState) return ExpenseListScreen();
            if (state is AddExpenseState) return AddExpenseScreen();
            if (state is SummaryState) return SummaryScreen();
            return Container();
          }

          return Scaffold(
            body: getCurrentScreen(),
            bottomNavigationBar: const BottomNavigationWidget(),
          );
        },
      ),
    );
  }
}
