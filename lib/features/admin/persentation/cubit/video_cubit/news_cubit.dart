import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';
import 'package:el_erinat/features/admin/domain/admin_use_cases/admin_upload_and_get_news.dart';
import 'package:el_erinat/features/admin/domain/repo/admin_repo.dart';
import 'package:equatable/equatable.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required this.adminRepo}) : super(NewsInitial());

  AdminRepo adminRepo;

  Future<void> uploadNewsDataForAdmin(UploadImageAndVideoModel news) async {
    emit(UploadNewsLoading());

    // final userRepo = AdminRepoImplementation(
    //   adminLocalDatabaseHelper: AdminLocalDatabaseHelper(),
    //   adminRemoteDataBaseHelper: AdminRemoteDataBaseHelper(),
    // );

    final addUserUseCase = AddNewsLibrary(adminRepo: adminRepo);
    final result = await addUserUseCase.call(news);

    result.fold(
      (failure) {
        emit(UploadNewsError(failure: failure.message));
        print('Error adding user: ${failure.message}');
      },
      (user) async {
        emit(UploadNewsSuccess(news: user as UploadImageAndVideoModel));
        print(
            'User added successfully to Firebase and local database: ${user.createdAt}');
      },
    );
  }

  Future<List<UploadImageAndVideoModel>> fetchNewsData() async {
    try {
      emit(GetNewsLoading());
      final image = await adminRepo.getAllnews();
      if (image.isNotEmpty) {
        emit(GetNewsSuccess(news: image));
        return image; // Return the image if it's not null
      } else {
        emit(const GetNewsError(failure: 'No image found'));
        return []; // Return an empty list if no image is found
      }
    } catch (e) {
      emit(GetNewsError(failure: e.toString()));
      return []; // Return an empty list in case of an error
    }
  }
}
