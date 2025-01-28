import 'package:expenses_tracker/model/expense_model.dart';
import 'package:sqflite/sqflite.dart';
import '../services/AppDatabase.dart';

/*
** ExpenseRepository class
* - Repository class to manage expense data
* - Fetch, save and delete expenses
*/

class ExpenseRepository {
  // Database? _database;
  final AppDatabase _databaseInstance = AppDatabase.instance;

  /*
  ** Get all expenses
  * @param null
  * @return List<Expense>
  */
  Future<List<Expense>> get() async {
    try {
      final db = await _databaseInstance.database;
      final maps = await db.query('expenses');
      return maps.map((map) => Expense.fromMap(map)).toList();
    } catch (e) {
      throw Exception("Failed to fetch expenses: $e");
    }
  }

  /*
  ** Save expense
  * @param expense
  * @return null
  */
  Future<void> save(expense) async {
    try {
      final db = await _databaseInstance.database;
      await db.insert(
        'expenses',
        expense,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception("Failed to add expense: $e");
    }
  }

  /*
  ** Delete expense
  * @param id
  * @return null
  */
  Future<void> delete(int id) async {
    final db = await _databaseInstance.database;
    await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }

  /*
  ** Get expenses by date
  * @param date
  * @return List<Expense>
  */
  Future<List<Expense>> getByDate(String date) async {
    try {
      final db = await _databaseInstance.database;
      final maps = await db.query(
        'expenses',
        where: 'date = ?', // Filter by date
        whereArgs: [date], // Pass the date as an argument
      );
      return maps.map((map) => Expense.fromMap(map)).toList();
    } catch (e) {
      throw Exception("Failed to fetch expenses: $e");
    }
  }
}
