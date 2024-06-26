import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/users/data/model/upload_image.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/upload_identaty_image.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';

class UploadIdentatyImageUser {
  final UserRepo userRepo;

  UploadIdentatyImageUser({required this.userRepo});

  Future<Either<Failure, UploadImageEntityes>> call(
      UploadImage path, Uint8List image) {
    return userRepo.uploadAndSaveIdentatyImage(path, image);
  }
}

class GetIdentityImagesUser {
  final UserRepo userRepo;

  GetIdentityImagesUser({required this.userRepo});

  Future<UploadImage?> call(String uID) {
    return userRepo.getIdentityImages(uID);
  }
}
