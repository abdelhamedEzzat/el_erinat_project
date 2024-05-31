import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';

class AddUser {
  final UserRepo userRepo;

  AddUser({required this.userRepo});

  Future<Either<Failure, AddPersonalDetailsUser>> call(UserModel user) {
    return userRepo.addPersonalDetailsUser(user);
  }
}

class GetUser {
  final UserRepo userRepo;

  GetUser({required this.userRepo});

  Future<List<UserModel>> call(UserModel user) {
    return userRepo.getPersonalUsers();
  }
}

// class GetAllUsers {
//   final UserRepo userRepo;

//   GetAllUsers({required this.userRepo});

//   Future<Either<Failure, List<AddDetailsUser>>> call() {
//     return userRepo.getAllUsers();
//   }
// }
