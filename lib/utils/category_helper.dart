import 'package:expenses_tracker/enums/expense_category.dart';
import 'package:flutter/material.dart';

IconData getIconForCategory(ExpenseCategory category) {
  switch (category) {
    case ExpenseCategory.Food:
      return Icons.fastfood;
    case ExpenseCategory.Travel:
      return Icons.flight;
    case ExpenseCategory.Shopping:
      return Icons.shopping_cart;
    case ExpenseCategory.Education:
      return Icons.school;
    case ExpenseCategory.Health:
      return Icons.local_hospital;
    default:
      return Icons.category;
  }
}
