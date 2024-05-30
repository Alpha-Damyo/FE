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
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE smokeInfo ('
      'autoId INTEGER PRIMARY KEY AUTOINCREMENT, '
      'id INTEGER, '
      'date TEXT, '
      'weekday TEXT'
      'time INTEGER)',
    );
  }

  Future<void> insertSmokeInfo(
      int id, DateTime dateInfo) async {
    
    String date = formatDate(dateInfo);
    int time = int.parse(formatTime(dateInfo));
    String weekday = formatWeekday(dateInfo);

    final db = await database;

    await db.insert(
      'smokeInfo',
      {'id': id, 'date': date, 'weekday': weekday, 'time': time},
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
      'SELECT * FROM smokeInfo GROUP BY $column HAVING COUNT($column) > 1',
    );
  }

  
}
