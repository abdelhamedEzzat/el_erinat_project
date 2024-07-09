import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/admin/data/model/upload_book_model.dart';

import 'package:el_erinat/features/admin/domain/admin_use_cases/admin_and_use_cases.dart';
import 'package:el_erinat/features/admin/domain/repo/admin_repo.dart';
import 'package:equatable/equatable.dart';

part 'upload_book_state.dart';

class UploadBookCubit extends Cubit<UploadBookState> {
  UploadBookCubit({required this.adminRepo}) : super(UploadBookInitial());
  AdminRepo adminRepo;

  Future<void> uploadImageDataForAdmin(UplaodBookModel book) async {
    emit(UploadBookLoading());

    final addUserUseCase = AddBookLibrary(adminRepo: adminRepo);
    final result = await addUserUseCase.call(book);

    result.fold(
      (failure) {
        emit(UploadBookError(failure: failure.message));
        print('Error adding user: ${failure.message}');
      },
      (user) async {
        emit(UploadBookSuccess(book: user as UplaodBookModel));
        print(
            'User added successfully to Firebase and local database: ${user.bookTitle}');
      },
    );
  }

  List<UplaodBookModel> bookDataList = [];

  void addNewsItem(UplaodBookModel news) {
    bookDataList.add(news);
    emit(GetBookSuccess(book: bookDataList));
  }

  Future<List<UplaodBookModel>> fetchBookImage() async {
    try {
      emit(GetBookLoading());
      final image = await adminRepo.getBookLibrary();
      if (image.isNotEmpty) {
        bookDataList = image;
        emit(GetBookSuccess(book: image));
        return image; // Return the image if it's not null
      } else {
        emit(const GetBookError(failure: 'No image found'));
        return []; // Return an empty list if no image is found
      }
    } catch (e) {
      emit(GetBookError(failure: e.toString()));
      return []; // Return an empty list in case of an error
    }
  }
}
