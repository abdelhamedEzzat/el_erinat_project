import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/admin/data/model/upload_book_model.dart';
import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';
import 'package:el_erinat/features/admin/data/model/upload_tree_model.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/admin_local_data_base_helper.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/remote_data_base_helper.dart';
import 'package:el_erinat/features/admin/domain/admin_entityes/upload_book_entity.dart';
import 'package:el_erinat/features/admin/domain/admin_entityes/upload_image_video_news_entity.dart';
import 'package:el_erinat/features/admin/domain/admin_entityes/upload_tree_entity.dart';
import 'package:el_erinat/features/admin/domain/repo/admin_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:workmanager/workmanager.dart';

class AdminRepoImplementation extends AdminRepo {
  AdminLocalDatabaseHelper adminLocalDatabaseHelper;
  AdminRemoteDataBaseHelper adminRemoteDataBaseHelper;

  AdminRepoImplementation({
    required this.adminLocalDatabaseHelper,
    required this.adminRemoteDataBaseHelper,
  }){
    // _initStream();
  }

  //   final StreamController<List<UploadImageAndVideoModel>> _newsStreamController = StreamController<List<UploadImageAndVideoModel>>.broadcast();

  // Stream<List<UploadImageAndVideoModel>> get newsStream => _newsStreamController.stream;



//   Future<void> _initStream() async {
//   // Listen to combined local and remote data stream
//   getAllnews().listen((newsData) {
//     // Print statements to log data source
//     if (newsData.isEmpty) {
//       print('No news data available');
//     } else if (newsData.first.path != null && newsData.isNotEmpty) {
//       print('Data received from local database');
//     } else {
//       print('Data received from global (remote)');
//     }
    
//     // Add data to stream controller
//     _newsStreamController.add(newsData);
//   });
// }

  @override
  Future<Either<Failure, UploadBookEntity>> uploadAndSaveBook({
    required UplaodBookModel uploadBookModel,
  }) async {
    try {
      await adminRemoteDataBaseHelper.uploadFilesToStorage(
          imagePath: uploadBookModel.localImagePath!,
          pdfPath: uploadBookModel.localPdFPath!,
          uploadBookModel: uploadBookModel);

      final uid = FirebaseAuth.instance.currentUser!.uid;
      uploadBookModel.uID = uid;

      final localWork =
          await adminLocalDatabaseHelper.insertBook(uploadBookModel);
      uploadBookModel.id = localWork.id;

      await adminRemoteDataBaseHelper.saveBookDataToFirestore(uploadBookModel);

      return Right(uploadBookModel);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<List<UplaodBookModel>> getBookLibrary() async {
    // Try to get the books from the local data source
    final localBooks = await adminLocalDatabaseHelper.getBookFromLocal();
    if (localBooks.isNotEmpty) {
      print('Books found in local database ');
      print("-------------------------$localBooks-------------------------");
      return localBooks;
    }

    // If not available locally, get it from the remote data source
    print('Books not found in local database for fetching from remote source');
    final remoteBooks = await adminRemoteDataBaseHelper.getBooks();

    // Save the books locally in batches
    const batchSize = 10;
    for (var i = 0; i < remoteBooks.length; i += batchSize) {
      final batch = remoteBooks.sublist(
          i,
          i + batchSize > remoteBooks.length
              ? remoteBooks.length
              : i + batchSize);

      await Future.wait(batch.map((book) async {
        try {
          if (book.remoteImageUrl != null && book.remotepdfUrl != null) {
            book.localImagePath = await downloadFile(
                book.remoteImageUrl!, 'image_${book.id}.png');
            // book.localPdFPath =
            //     await downloadFile(book.remotepdfUrl!, 'pdf_${book.id}.pdf');
          }

          // Save the updated book model to the local database
          await adminLocalDatabaseHelper.insertBook(book);
        } catch (e) {
          print('Failed to download or save file: $e');
        }
      }));
    }

    print('Fetched books from remote source and saved to local database for ');
    return remoteBooks;
  }

  @override
  Future<Either<Failure, UploadImageAndVideoEntity>> uploadAndSavenews(
      {required UploadImageAndVideoModel uploadImageAndVideoModel}) async {
    try {
      
 await adminRemoteDataBaseHelper.uploadNewsVedioAndImageToStorage(
          newsPath:  uploadImageAndVideoModel.path.toString(),
          uploadImageAndVideoModel: uploadImageAndVideoModel, 
          );

      final uid = FirebaseAuth.instance.currentUser!.uid;
      uploadImageAndVideoModel.uID = uid;

      final localWork =
          await adminLocalDatabaseHelper.insertNewsUpload(uploadImageAndVideoModel);
      uploadImageAndVideoModel.id = localWork.id;

      await adminRemoteDataBaseHelper.uploadNewsVedioAndImagetofirestore(uploadImageAndVideoModel: uploadImageAndVideoModel);
    

      return Right(uploadImageAndVideoModel);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }


  // Workmanager().registerOneOffTask(
      //   "1",
      //   "uploadTask",
      //   inputData: <String, dynamic>{
      //     'filePath': uploadImageAndVideoModel.path,
      //     'fileType': uploadImageAndVideoModel.type,
      //     'title': uploadImageAndVideoModel.newsTitle,
      //     'subTitle': uploadImageAndVideoModel.newsSubTitle,
      //   },
      //   initialDelay: Duration(seconds: 5)
      // );

      
//   Future<List<UploadImageAndVideoModel>> getAllnews() async {
  
//   Workmanager().registerOneOffTask("fetchNewsTask", "fetchNewsTask");

//   return [];
// }
  @override
Future<List<UploadImageAndVideoModel>> getAllnews() async {
  // // Yield local database stream first
   
    final localBooks = await adminLocalDatabaseHelper.getAllNewsUploads();
  if (localBooks.isNotEmpty) {
    print('Books found in local database ');
    return localBooks;
  }

  // If not available locally, get it from the remote data source
  print(
      'Books not found in local database and, fetching from remote source');
  final remoteBooks = await adminRemoteDataBaseHelper.getNews();

  // Batch size for processing
  const batchSize = 5; // Adjust batch size as per your requirements

  // Process in batches
  for (int i = 0; i < remoteBooks.length; i += batchSize) {
    final batch = remoteBooks.sublist(
        i,
        i + batchSize < remoteBooks.length
            ? i + batchSize
            : remoteBooks.length);
    await Future.wait(batch.map((book) async {
      try {
        if (book.url != null) {
          if (book.type == 'IMAGE') {
            book.path = await downloadFile(book.url!, 'image_${book.id}.png');

            // Save the updated book model to the local database
            await adminLocalDatabaseHelper.insertNewsUpload(book);
          }
        }
      } catch (e) {
        print('Failed to download or save file: $e');
      }
    }));
  }

  print(
      'Fetched books from remote source and saved to local database ');
  return remoteBooks;
}

  // final localNews = await adminLocalDatabaseHelper.getAllNewsUploads();

  // if (localNews.isNotEmpty) {
  //   print('Data received from local database');
  //   yield localNews;
  // } else {
  //   print('No news data available locally. Fetching from remote...');
  //   try {
  //     final remoteNews = await adminRemoteDataBaseHelper.getNews();

  //     for (final news in remoteNews) {
  //       if (news.url != null && news.type == 'IMAGE') {
  //         try {
  //           news.path = await downloadFile(news.url!, 'image_${news.id}.png');
  //           await adminLocalDatabaseHelper.insertNewsUpload(news);
  //           print('Data fetched from global (remote) and saved locally');
  //         } catch (e) {
  //           print('Failed to download or save file: $e');
  //         }
  //       }
  //     }

  //     // Fetch updated local data after saving remote data
  //     await adminLocalDatabaseHelper.getAllNewsUploads();
  //     yield remoteNews;
  //   } catch (e) {
  //     print('Failed to fetch remote news: $e');
  //   }
  

// void dispose() {
//   _newsStreamController.close();
// }
 

  @override
  Future<Either<Failure, UploadTreeEntity>> uploadAndSavetree(
      {required UploadTreeModel uploadTreeModel}) async {
    try {
      // Upload and get pdfUrl
      await adminRemoteDataBaseHelper.uploadFamilyTreePdftOnStorage(
        pdfPath: uploadTreeModel.pdfPath!,
        uploadTreeModel: uploadTreeModel,
      );

      final uid = FirebaseAuth.instance.currentUser!.uid;
      uploadTreeModel.uID = uid;

      // Insert into local database
      final localWork =
          await adminLocalDatabaseHelper.insertFamilyTrees(uploadTreeModel);
      uploadTreeModel.id = localWork.id;

      // Save to Firestore
      await adminRemoteDataBaseHelper.saveTreeDataToFirestore(uploadTreeModel);

      return Right(uploadTreeModel);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<List<UploadTreeModel>> getAlltrees() async {
    final localProblems = await adminLocalDatabaseHelper.getAllFamilyTrees();
    if (localProblems.isNotEmpty) {
      print('----------------------all tree found in local database for trees');
      print('-------Local Suggetions: ${localProblems.map((e) => e.toMap())}');
      return localProblems;
    }

    // If not available locally, get it from the remote data source
    print(
        ' -----all tree not found in local database for  trees, fetching from remote source');
    final remoteSuggetions = await adminRemoteDataBaseHelper.getAllTrees();
    print('Remote Problems: ${remoteSuggetions.map((e) => e.toRemoteMap())}');

    // Save the problems locally for future use
    for (var suggetion in remoteSuggetions) {
      await adminLocalDatabaseHelper.insertFamilyTrees(suggetion);
    }
    print(
        ' -----Fetched all tree from remote source and saved to local database  for tree');
    return remoteSuggetions;
  }

  @override
  Future<List<UploadTreeModel>> getAuditortrees(
    String uid,
  ) async {
    UploadTreeModel uploadTreeModel = UploadTreeModel();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    uploadTreeModel.uID = uid;
    final localProblems =
        await adminLocalDatabaseHelper.getAuditorFamilyTrees(uid);
    if (localProblems.isNotEmpty) {
      print('tree found in local database for trees');
      print('Local Suggetions: ${localProblems.map((e) => e.toMap())}');
      return localProblems;
    }

    // If not available locally, get it from the remote data source
    print(
        'tree not found in local database for  trees, fetching from remote source');
    final remoteSuggetions = await adminRemoteDataBaseHelper.getAuditorTrees();
    print('Remote Problems: ${remoteSuggetions.map((e) => e.toRemoteMap())}');

    // Save the problems locally for future use
    for (var suggetion in remoteSuggetions) {
      await adminLocalDatabaseHelper.insertFamilyTrees(suggetion);
    }
    print(
        'Fetched tree from remote source and saved to local database  for tree');
    return remoteSuggetions;
  }

  @override
  Future<void> updateTreeData(
      {required UploadTreeModel uploadTreeModel, required int id}) async {
    // Update the local database
    try {
      // Update in local database
      await adminLocalDatabaseHelper.updateTreeDataInLocalDatabase(
          uploadTreeModel, id);
      // Update in Firestore
      await adminRemoteDataBaseHelper.updateTreeDataInFirestore(
          uploadTreeModel, id);

      // Both updates succeeded
      print(
          'Tree data updated successfully in both Firestore and local database!');
    } catch (e) {
      print('Error updating tree data: $e');
      throw Exception('Failed to update tree data');
    }
  }
}
 Future<String> downloadFile(String url, String fileName) async {
    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String filePath = '${appDocDir.path}/$fileName';

      // Download the file
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;

      // Save the file locally
      final File file = File(filePath);
      await file.writeAsBytes(bytes);

      return filePath;
    } catch (e) {
      print('Error downloading file: $e');
      throw e;
    }
  }