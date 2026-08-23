import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static final String tableName = 'leave_applications';

  static final String columnId = 'id';
  static final String columnSelectedDate = 'selected_date';
  static final String columnRange = 'range';
  static final String columnApplication = 'application';

  static Future<void> initializeDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'app_database.db');

    _database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnSelectedDate TEXT,
            $columnRange TEXT,
            $columnApplication TEXT
          )
          ''',
        );
      },
    );
  }

  static Future<void> insertLeaveApplication(
    String selectedDate,
    String range,
    String application,
  ) async {
    await _database!.insert(
      tableName,
      {
        columnSelectedDate: selectedDate,
        columnRange: range,
        columnApplication: application,
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getLeaveApplications() async {
    return await _database!.query(tableName);
  }
}
