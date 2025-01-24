import 'package:expenses_tracker/model/expense_model.dart';
import 'package:sqflite/sqflite.dart';
import '../services/AppDatabase.dart';

class ExpenseRepository {
  // Database? _database;
  final AppDatabase _databaseInstance = AppDatabase.instance;

  // insert expense
  Future<void> addExpense(Expense expense) async {
    try {
      final db = await _databaseInstance.database;
      await db.insert(
        'expenses',
        expense.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception("Failed to add expense: $e");
    }
  }

  // expenses list
  Future<List<Expense>> getExpenses() async {
    try {
      final db = await _databaseInstance.database;
      print("database");
      print(db);
      final maps = await db.query('expenses');
      print('maps datbase');
      print(maps);
      return maps.map((map) => Expense.fromMap(map)).toList();
    } catch (e) {
      throw Exception("Failed to fetch expenses: $e");
    }
  }

  // delete expense
  Future<void> deleteExpense(int id) async {
    final db = await _databaseInstance.database;
    await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
