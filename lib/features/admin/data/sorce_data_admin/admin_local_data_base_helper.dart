import 'dart:async';

import 'package:el_erinat/features/admin/data/model/upload_book_model.dart';
import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';
import 'package:el_erinat/features/admin/data/model/upload_tree_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AdminLocalDatabaseHelper {
  static final AdminLocalDatabaseHelper adminLocalDatabaseHelper =
      AdminLocalDatabaseHelper._internal();

  factory AdminLocalDatabaseHelper() => adminLocalDatabaseHelper;
  static Database? _database;
// final StreamController<List<UploadImageAndVideoModel>> _newsController = StreamController<List<UploadImageAndVideoModel>>.broadcast();

// Stream<List<UploadImageAndVideoModel>> get newsStream => _newsController.stream;



   AdminLocalDatabaseHelper._internal() {
    //_initializeStream();
  }

  // Future<void> _initializeStream() async {
  //   final List<UploadImageAndVideoModel> initialNewsUploads = await getAllNewsUploads();
  //   _newsController.add(initialNewsUploads);
  // }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'admin_local_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS booksLibrary(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uID TEXT,
        localImagePath TEXT,
        remoteImageUrl TEXT,
        remotepdfUrl TEXT,
        bookTitle TEXT,
        bookdescription TEXT,
        createdAt TEXT
      )
    ''');

    await db.execute('''
          CREATE TABLE IF NOT EXISTS news (
            id INTEGER PRIMARY KEY,
            uID TEXT,
            url TEXT,
            type TEXT,
            path TEXT,
            newsTitle TEXT,
            newsSubTitle TEXT,
            createdAt TEXT
          )
        ''');

    await db.execute('''
          CREATE TABLE IF NOT EXISTS trees (
            id INTEGER PRIMARY KEY,
            uID TEXT,
            familyName TEXT,
            familyLineage TEXT,
            pdfName TEXT,
            pdfUrl TEXT
            
          )
        ''');
  }

  Future<UplaodBookModel> insertBook(UplaodBookModel uploadBook) async {
    final db = await database;

    final adminBookData = uploadBook.toJLocalson();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    uploadBook.createdAt = formatter.format(DateTime.now());

    uploadBook.uID = FirebaseAuth.instance.currentUser!.uid;

    int id = await db.insert(
      'booksLibrary',
      adminBookData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    uploadBook.id = id;
    print('Inserted user: ${uploadBook.toJLocalson()}');
    return uploadBook;
  }

  Future<List<UplaodBookModel>> getBookFromLocal() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'booksLibrary',
      // where: 'uID = ?',
      // whereArgs: [uID],
    );

    return maps.map((map) => UplaodBookModel.fromLocalJson(map)).toList();
  }

 
  Future<UploadImageAndVideoModel> insertNewsUpload(UploadImageAndVideoModel uploadMap) async {
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  uploadMap.createdAt = formatter.format(DateTime.now());

  Database db = await database;
  int id = await db.insert(
    'news',
    uploadMap.toLocalMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  uploadMap.id = id;

  // Update the stream with the new list of news uploads
  // _newsController.add(await getAllNewsUploads());

  return uploadMap;
}

 Future<List<UploadImageAndVideoModel>> getAllNewsUploads() async {
  Database db = await database;
  final List<Map<String, dynamic>> maps = await db.query('news');

  List<UploadImageAndVideoModel> newsUploads = maps
      .map((map) => UploadImageAndVideoModel.fromLocalMap(map))
      .toList();

  return newsUploads;
}

  Future<UploadTreeModel> insertFamilyTrees(UploadTreeModel uploadMap) async {
    Database db = await database;
    int id = await db.insert(
      'trees',
      uploadMap.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    uploadMap.id = id;
    return uploadMap;
  }

  Future<List<UploadTreeModel>> getAllFamilyTrees() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'trees',
      // where: 'uID = ?',
      // whereArgs: [uID],
    );

    return maps.map((map) => UploadTreeModel.fromMap(map)).toList();
  }

  Future<List<UploadTreeModel>> getAuditorFamilyTrees(String uID) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'trees',
      where: 'uID = ?',
      whereArgs: [uID],
    );

    return maps.map((map) => UploadTreeModel.fromMap(map)).toList();
  }

  Future<void> updateTreeDataInLocalDatabase(
      UploadTreeModel updatedTree, int id) async {
    try {
      Database db = await database;
      Map<String, dynamic> updateMap =
          updatedTree.toUpdateMap(); // Adjust as per your model

      // Update local database
      int result = await db.update(
        'trees',
        updateMap,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result > 0) {
        print('Family tree updated successfully in local database!');
      }
    } catch (e) {
      print('Error updating local database: $e');
      throw Exception('Failed to update local database');
    }
  }

  Future<void> adminDeleteOldEntries() async {
    final db = await database;
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    final String oneDayAgo =
        formatter.format(DateTime.now().subtract(const Duration(days: 2)));

    await db.delete(
      'booksLibrary',
      where: 'createdAt < ?',
      whereArgs: [oneDayAgo],
    );

    await db.delete(
      'news',
      where: 'createdAt < ?',
      whereArgs: [oneDayAgo],
    );
  }

//   void dispose() {
//   _newsController.close();
// }
}
