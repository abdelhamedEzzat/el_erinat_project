import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';
import 'package:el_erinat/features/admin/domain/admin_use_cases/admin_upload_and_get_news.dart';
import 'package:el_erinat/features/admin/domain/repo/admin_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required this.adminRepo}) : super(NewsInitial());

  AdminRepo adminRepo;

  
  
 final StreamController<List<UploadImageAndVideoModel>> _newsStreamController = StreamController<List<UploadImageAndVideoModel>>.broadcast();

  Stream<List<UploadImageAndVideoModel>> get newsStream => _newsStreamController.stream;
Future<void> uploadNewsDataForAdmin(UploadImageAndVideoModel news) async {
  // Emit loading state
  emit(UploadNewsLoading());

  // Call the use case to upload the news data
  final addUserUseCase = AddNewsLibrary(adminRepo: adminRepo);
  final result = await addUserUseCase.call(news);

  // Handle the result of the upload
  return await result.fold(
    (failure) {
      // Emit error state
      emit(UploadNewsError(failure: failure.message));
      print('Error adding news: ${failure.message}');
      return null;
    },
    // ignore: void_checks
    (news)async  {
      // Emit success state
      final uploadNews = news as UploadImageAndVideoModel;
      emit(UploadNewsSuccess(news: uploadNews));
      print('News added successfully to Firebase and local database: ${uploadNews.createdAt}');
      // Return the UploadImageAndVideoModel
     // await fetchNewsData();
     
    },);}
  
List<UploadImageAndVideoModel> newsDataList = [];


   Future<void> fetchNewsData() async {
    try {
      emit(GetNewsLoading());
      final newsList = await adminRepo.getAllnews();
      if (newsList.isNotEmpty) { newsDataList = newsList;
        emit(GetNewsSuccess(news: newsList));
       // _newsStreamController.add(newsList);
      } else {
        emit(const GetNewsError(failure: 'No news found'));
      //  _newsStreamController.add([]);
      }
    } catch (e) {
      emit(GetNewsError(failure: e.toString()));
      print(e.toString());
     // _newsStreamController.add([]);
    }
  }



  void addNewsItem(UploadImageAndVideoModel news) {
    newsDataList.add(news);
    emit(GetNewsSuccess(news: newsDataList));
  }




  @override
  Future<void> close() {
    _newsStreamController.close();
    return super.close();
  }
}


class TaskStatusNotifier {
  static final TaskStatusNotifier _singleton = TaskStatusNotifier._internal();
  factory TaskStatusNotifier() => _singleton;

  TaskStatusNotifier._internal();

  final _statusController = StreamController<String>.broadcast();
  Stream<String> get statusStream => _statusController.stream;

  void notifyStatus(String status) {
    print("Notifying status: $status");
    _statusController.sink.add(status);
  }

  void dispose() {
    _statusController.close();
  }
}



//  Future<void> uploadNewsDataForAdmin(UploadImageAndVideoModel news) async {
//     emit(UploadNewsLoading());

    // Call the use case to upload the news data
    // final addUserUseCase = AddNewsLibrary(adminRepo: adminRepo);
    // final result = await addUserUseCase.call(news);

    // Handle the result of the upload
    // result.fold(
    //   (failure) {
    //     // Emit error state
    //     emit(UploadNewsError(failure: failure.message));
    //     print('Error adding news: ${failure.message}');
    //     return null;
    //   },
    //   (news) async {

    // Workmanager().registerOneOffTask(
    //   "1",
    //   "uploadTask",
    //   inputData: <String, dynamic>{
    //     'filePath': news.path,
    //     'fileType': news.type,
    //     'title': news.newsTitle,
    //     'subTitle': news.newsSubTitle,
       
    //   },  initialDelay: const Duration(seconds: 5),
    // );
    //     // Emit progress state
    //     emit(UploadNewsInProgress());
    //     print('News added successfully to Firebase and local database: ${news.createdAt}');

    //     // Register a WorkManager task to upload the image
     

    //     // Listen to the task status
    //     TaskStatusNotifier().statusStream.listen((status) {
    //       if (status == "completed") {
    //         emit(UploadNewsSuccess(news: news as UploadImageAndVideoModel));
    //       }
    //     });
    
  
//  }
 