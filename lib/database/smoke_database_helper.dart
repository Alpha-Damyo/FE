import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class SmokeDatabaseHelper {
  static final SmokeDatabaseHelper _instance = SmokeDatabaseHelper._internal();
  factory SmokeDatabaseHelper() => _instance;
  SmokeDatabaseHelper._internal();

  static Database? _database;

  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('HH').format(dateTime);
  }

  static String formatWeekday(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'smokeInfo_database.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE smokeInfo ('
        'autoId INTEGER PRIMARY KEY AUTOINCREMENT, '
        'id TEXT, '
        'name TEXT, '
        'date TEXT, '
        'weekday TEXT, '
        'time INTEGER)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await db.execute('DROP TABLE IF EXISTS smokeInfo');
      await _onCreate(db, newVersion);
    }
  }

  Future<void> insertSmokeInfo(
      String id, String name, DateTime dateInfo) async {
    String date = formatDate(dateInfo);
    int time = int.parse(formatTime(dateInfo));
    String weekday = formatWeekday(dateInfo);

    final db = await database;

    await db.insert(
      'smokeInfo',
      {'id': id, 'name': name, 'date': date, 'weekday': weekday, 'time': time},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getSmokeInfo() async {
    final db = await database;
    return await db.query('smokeInfo');
  }

  Future<List<Map<String, dynamic>>> getSmokeInfoGroupedByColumn(
      String column) async {
    final db = await database;
    return await db.rawQuery(
      'SELECT $column, name, COUNT($column) as count FROM smokeInfo GROUP BY $column HAVING COUNT($column) > 1 ORDER BY COUNT($column) DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getSmokeInfoGroupedByColumnNOName(
      String column) async {
    final db = await database;
    return await db.rawQuery(
      'SELECT $column, COUNT($column) as count FROM smokeInfo GROUP BY $column HAVING COUNT($column) > 1',
    );
  }

  Future<List<Map<String, dynamic>>> getSmokeInfoInWeekDayRange(
      DateTime startDate, DateTime endDate) async {
    final db = await database;
    final startDateString = formatDate(startDate);
    final endDateString = formatDate(endDate);

    return await db.rawQuery(
      'SELECT weekday, COUNT(weekday) as count FROM smokeInfo WHERE date BETWEEN ? AND ? GROUP BY weekday',
      [startDateString, endDateString],
    );
  }

  Future<List<Map<String, dynamic>>> getSmokeInfoInWeeksRange(
      DateTime startDate, DateTime endDate) async {
    final db = await database;
    final startDateString = formatDate(startDate);
    final endDateString = formatDate(endDate);

    return await db.rawQuery(
      'SELECT COUNT(*) as count FROM smokeInfo WHERE date BETWEEN ? AND ? ',
      [startDateString, endDateString],
    );
  }
}
