import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/admin/data/model/upload_book_model.dart';
import 'package:el_erinat/features/admin/domain/admin_entityes/upload_book_entity.dart';
import 'package:el_erinat/features/admin/domain/repo/admin_repo.dart';

class AddBookLibrary {
  final AdminRepo adminRepo;

  AddBookLibrary({required this.adminRepo});

  Future<Either<Failure, UploadBookEntity>> call(
    UplaodBookModel uploadBookModel,
  ) async {
    return await adminRepo.uploadAndSaveBook(
      uploadBookModel: uploadBookModel,
    );
  }
}

class GetBookLibrary {
  final AdminRepo adminRepo;

  GetBookLibrary({required this.adminRepo});

  Future<List<UplaodBookModel>> call() async {
    return await adminRepo.getBookLibrary();
  }
}
