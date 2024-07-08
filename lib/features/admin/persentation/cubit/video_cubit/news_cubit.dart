import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';
import 'package:el_erinat/features/admin/domain/admin_use_cases/admin_upload_and_get_news.dart';
import 'package:el_erinat/features/admin/domain/repo/admin_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required this.adminRepo}) : super(NewsInitial());

  AdminRepo adminRepo;

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
      (news) async {
        // Emit success state
        final uploadNews = news as UploadImageAndVideoModel;
        emit(UploadNewsSuccess(news: uploadNews));
        print(
            'News added successfully to Firebase and local database: ${uploadNews.createdAt}');
      },
    );
  }

  List<UploadImageAndVideoModel> newsDataList = [];

  Future<void> fetchNewsData() async {
    try {
      emit(GetNewsLoading());
      final newsList = await adminRepo.getAllnews();
      if (newsList.isNotEmpty) {
        newsDataList = newsList;
        emit(GetNewsSuccess(news: newsList));
      } else {
        emit(const GetNewsError(failure: 'No news found'));
      }
    } catch (e) {
      emit(GetNewsError(failure: e.toString()));
      print(e.toString());
    }
  }

  void addNewsItem(UploadImageAndVideoModel news) {
    newsDataList.add(news);
    emit(GetNewsSuccess(news: newsDataList));
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
