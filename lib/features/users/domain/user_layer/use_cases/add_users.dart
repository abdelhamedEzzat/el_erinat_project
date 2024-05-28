import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.dart';

class AddUser {
  final UserRepo userRepo;

  AddUser({required this.userRepo});

  Future<Either<Failure, AddDetailsUser>> call(UserModel user) {
    return userRepo.addDetailsUser(user);
  }
}
