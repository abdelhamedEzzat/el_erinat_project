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

class AdminRepoImplementation extends AdminRepo {
  AdminLocalDatabaseHelper adminLocalDatabaseHelper;
  AdminRemoteDataBaseHelper adminRemoteDataBaseHelper;

  AdminRepoImplementation({
    required this.adminLocalDatabaseHelper,
    required this.adminRemoteDataBaseHelper,
  });

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
      final uid = FirebaseAuth.instance.currentUser!.uid;
      uploadImageAndVideoModel.uID = uid;

      final localWork = await adminLocalDatabaseHelper
          .insertNewsUpload(uploadImageAndVideoModel);
      uploadImageAndVideoModel.id = localWork.id;

      print(localWork.id);
      print(localWork.path);
      print(localWork.type);
      print(localWork.uID);
      print(localWork.url);
      //  print(localWork.createdAt);

      await adminRemoteDataBaseHelper.uploadNewsVedioAndImage(
          newsPath: uploadImageAndVideoModel.path!,
          uploadImageAndVideoModel: uploadImageAndVideoModel);

      return Right(uploadImageAndVideoModel);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<List<UploadImageAndVideoModel>> getAllnews() async {
    final uID = FirebaseAuth.instance.currentUser!.uid;
    final localBooks = await adminLocalDatabaseHelper.getAllNewsUploads(uID);
    if (localBooks.isNotEmpty) {
      print('Books found in local database for uID: $uID');
      return localBooks;
    }

    // If not available locally, get it from the remote data source
    print(
        'Books not found in local database for uID: $uID, fetching from remote source');
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
            } else if (book.type == 'VIDEO') {
              book.path = await downloadFile(book.url!, 'video_${book.id}.mp4');
            }

            // Save the updated book model to the local database
            await adminLocalDatabaseHelper.insertNewsUpload(book);
          }
        } catch (e) {
          print('Failed to download or save file: $e');
        }
      }));
    }

    print(
        'Fetched books from remote source and saved to local database for uID: $uID');
    return remoteBooks;
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

  @override
  Future<Either<Failure, UploadTreeEntity>> uploadAndSavetree(
      {required UploadTreeModel uploadTreeModel}) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      uploadTreeModel.uID = uid;

      final localWork =
          await adminLocalDatabaseHelper.insertFamilyTrees(uploadTreeModel);
      uploadTreeModel.id = localWork.id;

      print(localWork.id);
      print(localWork.familyLineage);
      print(localWork.familyName);
      print(localWork.uID);

      //  print(localWork.createdAt);

      await adminRemoteDataBaseHelper.uploadFamilyTreePdf(
          pdfPath: uploadTreeModel.pdfPath!, uploadTreeModel: uploadTreeModel);

      return Right(uploadTreeModel);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<List<UploadTreeModel>> getAlltrees() async {
    final localProblems = await adminLocalDatabaseHelper.getAllFamilyTrees();
    if (localProblems.isNotEmpty) {
      print('tree found in local database for trees');
      print('Local Suggetions: ${localProblems.map((e) => e.toMap())}');
      return localProblems;
    }

    // If not available locally, get it from the remote data source
    print(
        'tree not found in local database for  trees, fetching from remote source');
    final remoteSuggetions = await adminRemoteDataBaseHelper.getAllTrees();
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
  Future<List<UploadTreeModel>> getAuditortrees(String uid) async {
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
}
