import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseHelper {
  static final LocalDatabaseHelper _instance = LocalDatabaseHelper._internal();
  factory LocalDatabaseHelper() => _instance;
  static Database? _database;

  LocalDatabaseHelper._internal();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_family_details.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE userDetails (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age TEXT,
        fatherName TEXT,
        grandfatherName TEXT,
        greatGrandfatherName TEXT,
        fatherLiveORDead TEXT,
        grandfatherLiveORDead TEXT,
        greatGrandFatherLiveOrDead TEXT,
        familyName TEXT,
        phoneNumber TEXT,
        countryName TEXT,
        gender TEXT
      )
    ''');
  }

  //! here i save data to cache database

  Future<int> insertUser(UserModel user) async {
    Database db = await database;

    return await db.insert('userDetails', user.toJson());
  }
}
