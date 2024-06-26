import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/users/data/model/user_problems_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/user_give_auditor_problem_entitye.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';

class UploadIdentatyImageUser {
  final UserRepo userRepo;

  UploadIdentatyImageUser({required this.userRepo});

  Future<Either<Failure, UserGiveAuditorProblemEntitye>> call(
      UserProblemsModel userProblemsModel) {
    return userRepo.uploadAndSaveProblemOfUser(
      userProblemsModel: userProblemsModel,
    );
  }
}

class GetIdentityImagesUser {
  final UserRepo userRepo;

  GetIdentityImagesUser({required this.userRepo});

  Future<List<UserProblemsModel>> call(String uID) {
    return userRepo.getProblemsOfUser(uID);
  }
}
