import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';

abstract class UserRepo {
  Future<Either<Failure, AddDetailsUser>> addDetailsUser(UserModel user);
}
