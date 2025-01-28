import 'package:expenses_tracker/bloc/expense/expense_bloc_bloc.dart';
import 'package:expenses_tracker/presentation/widgets/summary_widget.dart';
import 'package:expenses_tracker/repository/expense_repository.dart';
import 'package:expenses_tracker/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* 
  SummaryScreen  displays a summary of the user's weekly, monthly,
  and category-wise expenses, fetching data from the ExpenseBloc.
 */
class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Expense Summary", style: titleText),
              ),
              SizedBox(
                height: 10,
              ),
              BlocProvider(
                create: (context) =>
                    ExpenseBloc(ExpenseRepository())..add(GetExpenses()),
                child: BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (context, state) {
                    if (state is ExpenseLoaded) {
                      return Column(
                        children: [
                          SummaryWidget(
                            title: "Weekly Expense",
                            count: state.weeklyTotal,
                            color: Color(0xFF006266),
                          ),
                          SummaryWidget(
                            title: "Monthly Expense",
                            count: state.monthlyTotal,
                            color: Color(0xFF192a56),
                          ),
                          state.mostExpensiveCategoryTotal == 0
                              ? Container()
                              : SummaryWidget(
                                  title:
                                      '${state.mostExpensiveCategory} \n(Top Spending Category)',
                                  count: state.mostExpensiveCategoryTotal,
                                  color: Color(0xFFb33939),
                                ),
                        ],
                      );
                    } else if (state is ExpenseError) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
