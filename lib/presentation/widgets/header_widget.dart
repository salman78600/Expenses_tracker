import 'package:expenses_tracker/bloc/expense/expense_bloc_bloc.dart';
import 'package:expenses_tracker/presentation/widgets/date_selector_widget.dart';
import 'package:expenses_tracker/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const Key('header_widget'),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello user,', style: bodyText),
              Text('Welcome Back!', style: titleText),
            ],
          ),
          DatePickerWidget(
            onDateSelected: (selectedDate) {
              context.read<ExpenseBloc>().add(FilterExpensesByDate(
                  DateFormat('dd-MM-yyyy')
                      .format(DateTime.parse(selectedDate.toString()))));
            },
          ),
        ],
      ),
    );
  }
}
