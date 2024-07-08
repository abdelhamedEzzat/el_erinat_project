import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/suggetion_entity.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';

class InsertSuggetionUser {
  final UserRepo userRepo;

  InsertSuggetionUser({required this.userRepo});

  Future<Either<Failure, SuggetionEntity>> call(SuggetionModel user) {
    return userRepo.uploadSuggetionsOfUser(suggetionModel: user);
  }
}

class GetSuggetionForUser {
  final UserRepo userRepo;

  GetSuggetionForUser({required this.userRepo});

  Future<List<SuggetionModel>> call(String uID) {
    return userRepo.getSuggetionsToUser(uID);
  }
}

class GetWatingSuggetionForAuditor {
  final UserRepo userRepo;

  GetWatingSuggetionForAuditor({required this.userRepo});

  Future<List<SuggetionModel>> call(SuggetionModel user) {
    return userRepo.getWattingSuggetionsToAuditor();
  }
}

class GetFinishedSuggetionForAuditor {
  final UserRepo userRepo;

  GetFinishedSuggetionForAuditor({required this.userRepo});

  Future<List<SuggetionModel>> call(SuggetionModel user) {
    return userRepo.getFinishedSuggetionsToAuditor();
  }
}

class UploadFinishedSuggetionForAuditor {
  final UserRepo userRepo;

  UploadFinishedSuggetionForAuditor({required this.userRepo});

  Future<void> call(int id, String newStatus) {
    return userRepo.updateFinishedSuggetionsToAuditor(id, newStatus);
  }
}

class VotedToUser {
  final UserRepo userRepo;

  VotedToUser({required this.userRepo});

  Future<List<SuggetionModel>> call(SuggetionModel user) {
    return userRepo.getVotedToUser();
  }
}
