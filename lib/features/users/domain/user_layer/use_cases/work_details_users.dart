import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/users/data/model/work_user_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/analitics.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/work_details_user_entityes.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';

class AddWorkDetailsUser {
  final UserRepo userRepo;

  AddWorkDetailsUser({required this.userRepo});

  Future<Either<Failure, WorkDetailsUserEntityes>> call(WorkModel work) {
    return userRepo.addWorkPersonalDetails(work);
  }
}

class GetWorkDetailsUser {
  final UserRepo userRepo;

  GetWorkDetailsUser({required this.userRepo});

  Future<List<dynamic>> call() {
    return userRepo.getWorkOfUser();
  }
}

class SaveJobStatistics {
  final UserRepo userRepo;
  SaveJobStatistics(this.userRepo);

  Future<void> call(JobAnalitics jopstatistics) {
    return userRepo.saveJobAnalitics(jopstatistics);
  }
}

class GetJobStatistics {
  final UserRepo userRepo;
  GetJobStatistics(this.userRepo);

  Future<void> call() {
    return userRepo.getJobAnalitics();
  }
}

class GetWorkInfoByUid {
  final UserRepo userRepo;
  GetWorkInfoByUid(this.userRepo);

  Future<void> call(String uid) {
    return userRepo.fetchWorkUsersinfoByID(uid);
  }
}
