import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/data/model/upload_image.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/data/model/user_problems_model.dart';
import 'package:el_erinat/features/users/data/model/work_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseHelper {
  static final LocalDatabaseHelper instance = LocalDatabaseHelper._internal();
  factory LocalDatabaseHelper() => instance;
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

    await db.execute('''
      CREATE TABLE workDetails (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uID TEXT,
        dateOfBirthday TEXT,
        specialization TEXT,
        generalSpecialization TEXT,
        university TEXT,
        dateOfCertificate TEXT,
        employer TEXT,
        city TEXT,
        status TEXT,
        title TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS uploadIdentityImage (
      id INTEGER PRIMARY KEY,
      uID TEXT NOT NULL,
      uploadedIdentityImage TEXT NOT NULL,
      bytes BLOB NOT NULL
    );
    ''');

    await db.execute('''
      CREATE TABLE userProblems (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uID TEXT,
        problemTitle TEXT,
        problemDescription TEXT,
        actionNeded TEXT,
        createdAt TEXT,
        statusOfProblem TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE userSuggetion (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uID TEXT,
        suggetionTitle TEXT,
        suggetionDescription TEXT,
        firstChoise TEXT,
        secoundChoise TEXT,
        thirdChoise TEXT,
        createdAt TEXT,
        statusOfProblem TEXT,
        vote1 INTEGER DEFAULT 0,
        vote2 INTEGER DEFAULT 0,
        vote3 INTEGER DEFAULT 0
        
      )
    ''');
  }

//
  //! here i save data to cache database to personal details
  //

  Future<UserModel> insertUser(UserModel user) async {
    final db = await database;
    final userData = user.toJson();

    // Insert the user data and get the generated id
    int id = await db.insert(
      'userDetails',
      userData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    user.id = id;

    // Log the inserted user with id
    print('Inserted user: ${user.toJson()}');

    return user;
  }

  Future<List<UserModel>> getAllUsers() async {
    UserModel userModel = UserModel();
    final db = await database;
    final data = await db
        .query('userDetails', where: 'uID = ?', whereArgs: [userModel.uID]);

    List<UserModel> users = data.map((e) => UserModel.fromJson(e)).toList();
    return users;
  }

  //
  //! here i save data to cache database to work details
  //

  Future<WorkModel> addworkPersonalDetailsUser(WorkModel work) async {
    final db = await database;
    final userData = work.toJson();

    // Insert the user data and get the generated id
    int id = await db.insert(
      'workDetails',
      userData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    work.id = id;

    // Log the inserted user with id
    print('Inserted user: ${work.toJson()}');

    return work;
  }
//
  //! here i GET data to cache database to work details
  //

  Future<List<WorkModel>> getWorkUsers() async {
    WorkModel workModel = WorkModel();
    final db = await database;
    final data = await db
        .query('workDetails', where: 'uID = ?', whereArgs: [workModel.uID]);

    List<WorkModel> users = data.map((e) => WorkModel.fromJson(e)).toList();

    return users;
  }

//
  //! here i save  AND get data to cache database to identetity pic  details
  //
  // !Future<UploadImage> uploadIdentityImageToLocalDatabase(

  Future<UploadImage> uploadIdentityImageToLocalDatabase(
      UploadImage uploadImage) async {
    try {
      final db = await database;
      uploadImage.uID = FirebaseAuth.instance.currentUser!.uid;

      // Ensure bytes is not null
      if (uploadImage.bytes == null) {
        throw Exception('Bytes cannot be null');
      }

      final userData = uploadImage.toJson();

      int id = await db.insert(
        'uploadIdentityImage',
        userData,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      uploadImage.id = id;

      print('Inserted image: ${uploadImage.toJson()}');
      return uploadImage;
    } catch (e) {
      print('Error inserting image: $e');
      return Future.error(e.toString());
    }
  }

  Future<UploadImage?> getImagefromLocalDatabase(String uID) async {
    final db = await database;
    // final data = await db;
    final List<Map<String, dynamic>> maps = await db
        .query('uploadIdentityImage', where: 'uID = ?', whereArgs: [uID]);

    if (maps.isNotEmpty) {
      print('Retrieved image from local database for uID: $uID');
      return UploadImage.fromJson(maps.first);
    }
    return null;
  }

//
//! this is for problem that user can send
//

  Future<UserProblemsModel> insertProblemsUser(
      UserProblemsModel uploadMap) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    uploadMap.createdAt = formatter.format(DateTime.now());
    uploadMap.statusOfProblem = "قيد المراجعه";

    Database db = await database;
    int id = await db.insert(
      'userProblems',
      uploadMap.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    uploadMap.id = id;
    return uploadMap;
  }

  Future<List<UserProblemsModel>> getAllProblems(String uID) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'userProblems',
      where: 'uID = ?',
      whereArgs: [uID],
    );

    return maps.map((map) => UserProblemsModel.fromJson(map)).toList();
  }

  Future<List<UserProblemsModel>> getAllProblemsForAuditor() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'userProblems',
      // where: 'uID = ?',
      // whereArgs: [uID],
    );

    return maps.map((map) => UserProblemsModel.fromJson(map)).toList();
  }

//
//! this is for suggetions that user can send
//
  Future<SuggetionModel> insertUserSuggetion(SuggetionModel uploadMap) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    uploadMap.createdAt = formatter.format(DateTime.now());
    // uploadMap.statusOfProblem = "قيد المراجعه";

    Database db = await database;
    int id = await db.insert(
      'userSuggetion',
      uploadMap.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    uploadMap.id = id;
    return uploadMap;
  }

  Future<List<SuggetionModel>> getuserSuggetions(String uID) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'userSuggetion',
      where: 'uID = ?',
      whereArgs: [uID],
    );

    return maps.map((map) => SuggetionModel.fromJson(map)).toList();
  }

  Future<List<SuggetionModel>> getAllWattingSuggetions() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'userSuggetion',
      where: 'statusOfProblem = ?',
      whereArgs: ["قيد المراجعه"],
    );

    return maps.map((map) => SuggetionModel.fromJson(map)).toList();
  }

  Future<List<SuggetionModel>> getAllFinishedSuggetions() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'userSuggetion',
      where: 'statusOfProblem IN (?, ?)',
      whereArgs: ["تم الموافقه علي الاقتراح", "تم رفضها"],
    );

    return maps.map((map) => SuggetionModel.fromJson(map)).toList();
  }

  Future<List<SuggetionModel>> getLocalVotedSuggetions() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'userSuggetion',
      where: 'statusOfProblem = ?',
      whereArgs: ["تم الموافقه علي الاقتراح"],
    );

    return maps.map((map) => SuggetionModel.fromJson(map)).toList();
  }

  Future<void> updateStatusInSQLite(int id, String newStatus) async {
    final db =
        await database; // Assuming you have a method to get the database instance
    await db.update(
      'userSuggetion',
      {'statusOfProblem': newStatus},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Future<String?> openFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc'],
//     );

//     if (result != null) {
//       File file = File(result.files.single.path!);
//       return file.path;
//     } else {
//       return null;
//     }
//   }
// class ImageModel2 {
//   int? id;
//   String? uid;
//   String? uploadedIdentityImage;
//   Uint8List? imageBytes;

//   ImageModel2({
//     this.id,
//     this.uid,
//     this.uploadedIdentityImage,
//   });

//   factory ImageModel2.fromJson(Map<String, dynamic> json) {
//     return ImageModel2(
//       id: json['id'],
//       uid: json['uID'],
//       uploadedIdentityImage: json['uploadedIdentityImage'],
//     );
//   }
//   // تحويل البيانات إلى Map لحفظها في Firestore
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'uID': uid,

//       'uploadedIdentityImage': uploadedIdentityImage,
//       // يمكن تحويل البيانات الثنائية إلى صيغة متوافقة مع Firestore إذا لزم الأمر
//       // على سبيل المثال: يمكن تحويلها إلى سلسلة مثل base64
//       // 'imageBytes': base64.encode(imageBytes),
//     };
//   }
// }

// Assuming you have a similar structure for your UploadImage and Failure classes
