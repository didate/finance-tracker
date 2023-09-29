import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  Database? _db;

  final categoryCreate = "";

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    String path = join(await getDatabasesPath(), "finance.db");
    var theDb = await openDatabase(path, version: 2, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db
        .execute("CREATE TABLE Token(id INTEGER PRIMARY KEY, id_token TEXT , "
            "societeid INTEGER, societename TEXT, expiration TEXT, "
            "telephone TEXT, addresse TEXT)");
  }
}
