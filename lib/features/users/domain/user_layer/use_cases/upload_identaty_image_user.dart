import 'dart:io';
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
      UploadImage path, String image) {
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

class SaveCallDataFromAuditor {
  final UserRepo userRepo;

  SaveCallDataFromAuditor({required this.userRepo});

  Future<Either<Failure, GetCallFromAuditorEntityes>> call(
      GetCallModel getCallModel, String getCall) {
    return userRepo.uploadAndSaveGetCall(getCallModel, getCall);
  }
}

class GetICallFromAuditor {
  final UserRepo userRepo;

  GetICallFromAuditor({required this.userRepo});

  Future<GetCallModel?> call(String uID, GetCallModel getCallModelForUser) {
    return userRepo.getCallFromAuditor(uID, getCallModelForUser);
  }
}
