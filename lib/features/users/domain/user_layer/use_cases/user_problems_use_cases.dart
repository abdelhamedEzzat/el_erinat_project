import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/users/data/model/user_problems_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/user_give_auditor_problem_entitye.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';

class UploadProblemsImageUser {
  final UserRepo userRepo;

  UploadProblemsImageUser({required this.userRepo});

  Future<Either<Failure, UserGiveAuditorProblemEntitye>> call(
      UserProblemsModel userProblemsModel) {
    return userRepo.uploadAndSaveProblemOfUser(
      userProblemsModel: userProblemsModel,
    );
  }
}

class GetProblemssUser {
  final UserRepo userRepo;

  GetProblemssUser({required this.userRepo});

  Future<List<UserProblemsModel>> call(String uID) {
    return userRepo.getProblemsOfUser(uID);
  }
}

class GetWattingAuditorProblemssUser {
  final UserRepo userRepo;

  GetWattingAuditorProblemssUser({required this.userRepo});

  Future<List<UserProblemsModel>> call() {
    return userRepo.getWattingProblemsForAuditor();
  }
}

class UpdateAuditorProblemssUserStatus {
  final UserRepo userRepo;

  UpdateAuditorProblemssUserStatus({required this.userRepo});

  Future<void> call(int id, String newStatus) {
    return userRepo.updateFinishedProblemsToAuditor(id, newStatus);
  }
}

class GetFinishedAuditorProblemssUser {
  final UserRepo userRepo;

  GetFinishedAuditorProblemssUser({required this.userRepo});

  Future<List<UserProblemsModel>> call() {
    return userRepo.getFinishedProblemsForAuditor();
  }
}
