import 'package:flutter/material.dart';

Future<DateTime?> showGlobalDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  return await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate ?? DateTime(2000),
    lastDate: lastDate ?? DateTime(2100),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Colors.black, // Header background color
            onPrimary: Colors.white, // Header text color
            surface: Colors.white, // Dialog background color
            onSurface: Colors.black, // Text color inside dialog
          ),
          dialogBackgroundColor: Colors.transparent,
        ),
        child: child!,
      );
    },
  );
}
