import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/analitics.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';

class AddUser {
  final UserRepo userRepo;

  AddUser({required this.userRepo});

  Future<Either<Failure, AddPersonalDetailsUser>> call(
      UserModel user, String role, String status) {
    return userRepo.addPersonalDetailsUser(user, role, status);
  }
}

class UpdateUser {
  final UserRepo userRepo;

  UpdateUser({required this.userRepo});

  Future<Either<Failure, AddPersonalDetailsUser>> call(UserModel user) {
    return userRepo.updatePersonalDetailsUser(user);
  }
}

class GetUser {
  final UserRepo userRepo;

  GetUser({required this.userRepo});

  Future<List<UserModel>> call(UserModel user) {
    return userRepo.getPersonalUsers();
  }
}

class SaveStatistics {
  final UserRepo userRepo;
  SaveStatistics(this.userRepo);

  Future<void> call(Statistics statistics) {
    return userRepo.saveStatistics(statistics);
  }
}

class UpdateRoleForAnyUser {
  final UserRepo userRepo;
  UpdateRoleForAnyUser(this.userRepo);

  Future<void> call(String newRole, UserModel user) {
    return userRepo.updateUserRole(newRole, user);
  }
}

class UpdateStatusForAnyUser {
  final UserRepo userRepo;
  UpdateStatusForAnyUser(this.userRepo);

  Future<void> call(int id, String newStatus) {
    return userRepo.updateStutsOfUser(id, newStatus);
  }
}

class GetWattingUsers {
  final UserRepo userRepo;
  GetWattingUsers(this.userRepo);

  Future<List<UserModel>> call() {
    return userRepo.getWattingUsers();
  }
}

class GetAcceptedUsers {
  final UserRepo userRepo;
  GetAcceptedUsers(this.userRepo);

  Future<List<UserModel>> call() {
    return userRepo.getAcceptedUsers();
  }
}

class DeleteUnAcceptedUser {
  final UserRepo userRepo;
  DeleteUnAcceptedUser(this.userRepo);

  Future<void> call(String uID, UserModel user) {
    return userRepo.deleteUserWhenUnAccepted(uID, user);
  }
}
