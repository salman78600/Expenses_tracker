import 'package:expenses_tracker/utils/app_style.dart';
import 'package:flutter/material.dart';

class DayExpenseWidget extends StatelessWidget {
  final double expenses;
  final VoidCallback onAddPressed;

  const DayExpenseWidget({
    super.key,
    required this.expenses,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Expenses count with Euro symbol
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Day Expenses',
                  style: titleTextWhite,
                ),
                SizedBox(height: 8.0),
                Text(
                  '€${expenses.toStringAsFixed(2)}',
                  style: titleTextWhite22,
                ),
              ],
            ),
            // Right side: Add (+) button
            IconButton(
              onPressed: onAddPressed,
              icon: Icon(Icons.add, color: Colors.white, size: 32),
              tooltip: 'Add Expense',
            ),
          ],
        ),
      ),
    );
  }
}
