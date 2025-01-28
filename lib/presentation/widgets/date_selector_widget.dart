import 'package:expenses_tracker/utils/datePicker.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final Function(DateTime) onDateSelected;

  const DatePickerWidget({super.key, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        DateTime? selectedDate = await showGlobalDatePicker(
          context: context,
          initialDate: DateTime.now(),
        );

        if (selectedDate != null) {
          onDateSelected(selectedDate);
        }
      },
      icon: Icon(Icons.filter_list),
    );
  }
}
