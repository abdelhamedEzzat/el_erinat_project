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
        uID TEXT,
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

  Future<UserModel> insertUser(UserModel user) async {
    final db = await database;
    final userData = user.toJson();

    // Insert the user data and get the generated id
    int id = await db.insert(
      'userDetails',
      userData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Set the generated id in the user model
    user.id = id;

    // Log the inserted user with id
    print('Inserted user: ${user.toJson()}');

    return user;
  }

  //
  //

  Future<List<UserModel>> getAllUsers() async {
    UserModel userModel = UserModel();
    final db = await database;
    final data = await db
        .query('userDetails', where: 'uID = ?', whereArgs: [userModel.uID]);

    List<UserModel> users = data.map((e) => UserModel.fromJson(e)).toList();
    return users;
  }
}
