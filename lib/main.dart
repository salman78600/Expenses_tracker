import 'package:expenses_tracker/app_observer.dart';
import 'package:expenses_tracker/bloc/category/category_bloc.dart';
import 'package:expenses_tracker/bloc/expense/expense_bloc_bloc.dart';
import 'package:expenses_tracker/presentation/screens/main_screen.dart';
import 'package:expenses_tracker/presentation/screens/summary.dart';
import 'package:expenses_tracker/repository/expense_repository.dart';
import 'package:expenses_tracker/presentation/screens/add_expense.dart';
import 'package:expenses_tracker/presentation/screens/home.dart';
import 'package:expenses_tracker/presentation/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // bloc observer
  Bloc.observer = const AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ExpenseRepository expenseRepository = ExpenseRepository();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ExpenseBloc(expenseRepository)..add(GetExpenses()),
          ),
          BlocProvider(
            create: (context) => CategoryBloc()..add(LoadCategories()),
          )
        ],
        child: MaterialApp(
          title: 'Expenses Tracker',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            '/main': (context) => MainScreen(),
            '/home': (context) => ExpenseListScreen(),
            '/addexpense': (context) => AddExpenseScreen(),
            '/summary': (context) => SummaryScreen(),
          },
        ));
  }
}
