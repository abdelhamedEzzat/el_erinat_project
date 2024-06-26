import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';
import 'package:el_erinat/features/admin/domain/admin_entityes/upload_image_video_news_entity.dart';
import 'package:el_erinat/features/admin/domain/repo/admin_repo.dart';

class AddNewsLibrary {
  final AdminRepo adminRepo;

  AddNewsLibrary({required this.adminRepo});

  Future<Either<Failure, UploadImageAndVideoEntity>> call(
    UploadImageAndVideoModel uploadnewsModel,
  ) async {
    return await adminRepo.uploadAndSavenews(
      uploadImageAndVideoModel: uploadnewsModel,
    );
  }
}

class GetNewsLibrary {
  final AdminRepo adminRepo;

  GetNewsLibrary({required this.adminRepo});

  Future<List<UploadImageAndVideoModel>> call(String id) async {
    return await adminRepo.getAllnews();
  }
}
