import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  // Private constructor
  AppDatabase._privateConstructor();

  // Singleton instance
  static final AppDatabase instance = AppDatabase._privateConstructor();

  // Database instance
  static Database? _appDatabase;

  // Getter for database instance
  Future<Database> get database async {
    if (_appDatabase != null) return _appDatabase!;

    // If database doesn't exist, initialize it
    _appDatabase = await _initDatabase();
    return _appDatabase!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'app_database.db');
    print("path");
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
     CREATE TABLE expenses(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount DOUBLE,
      description TEXT DEFAULT NULL,
      date TEXT)
      ''');
  }
}
