import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';
import 'package:el_erinat/features/admin/data/repo_admin/admin_repo_impelment.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/admin_local_data_base_helper.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/remote_data_base_helper.dart';
import 'package:el_erinat/features/admin/persentation/cubit/video_cubit/news_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      //! this is for admin upload news

      case "uploadTask":
        bool success = await callbackForUploadNews(inputData);
        if (success) {
          print("Task completed successfully");
          return Future.value(true);
        } else {
          print("Task not completed");
          return Future.value(false);
        }

      //! this is for admin get news

      case "fetchNewsTask":
        bool getNews = await callbackGetNews();
        if (getNews) {
          print("Task get successfully");
          return Future.value(true);
        } else {
          print("Task not get  completed");
          return Future.value(false);
        }
      default:
        print("Unknown task: $task");
        return Future.value(false);
    }
  });
}

AdminRemoteDataBaseHelper adminRemoteDataBaseHelper =
    AdminRemoteDataBaseHelper();

AdminLocalDatabaseHelper adminLocalDatabaseHelper = AdminLocalDatabaseHelper();
AdminRepoImplementation adminRepoImplementation = AdminRepoImplementation(
  adminLocalDatabaseHelper: AdminLocalDatabaseHelper(),
  adminRemoteDataBaseHelper: AdminRemoteDataBaseHelper(),
);
Future<bool> callbackForUploadNews(
  Map<String, dynamic>? inputData,
) async {
  try {
    await Firebase.initializeApp();
    String filePath = inputData!['filePath'];
    String fileType = inputData['fileType'];
    String title = inputData['title'];
    String subTitle = inputData['subTitle'];

    UploadImageAndVideoModel uploadImageAndVideoModel =
        UploadImageAndVideoModel(
      path: filePath,
      type: fileType,
      newsTitle: title,
      newsSubTitle: subTitle,
    );
    await NewsCubit(adminRepo: adminRepoImplementation)
        .uploadNewsDataForAdmin(uploadImageAndVideoModel);

    return true;
  } catch (e) {
    print("Error in background task: $e");
    return false;
  }
}

Future<bool> callbackGetNews() async {
  try {
    await Firebase.initializeApp();

    // Fetch data from the remote source
    final localBooks = await adminLocalDatabaseHelper.getAllNewsUploads();
    if (localBooks.isNotEmpty) {
      print('Books found in local database');
      return true; // Return true for success
    }

    // If not available locally, get it from the remote data source
    print('Books not found in local database, fetching from remote source');
    final remoteBooks = await adminRemoteDataBaseHelper.getNews();

    // Batch size for processing
    const batchSize = 5; // Adjust batch size as per your requirements

    // Process in batches
    for (int i = 0; i < remoteBooks.length; i += batchSize) {
      final batch = remoteBooks.sublist(
        i,
        i + batchSize < remoteBooks.length ? i + batchSize : remoteBooks.length,
      );
      await Future.wait(batch.map((book) async {
        try {
          if (book.url != null && book.type == 'IMAGE') {
            book.path = await downloadFile(book.url!, 'image_${book.id}.png');

            // Save the updated book model to the local database
            await adminLocalDatabaseHelper.insertNewsUpload(book);
          }
        } catch (e) {
          print('Failed to download or save file: $e');
        }
      }));
    }

    print('Background data fetching and saving completed.');
    return true; // Return true for success
  } catch (e) {
    print('Background task failed: $e');
    return false; // Return false for failure
  }
}
