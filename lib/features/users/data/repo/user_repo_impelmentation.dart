import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';

class UserRepoImplementation implements UserRepo {
  final LocalDatabaseHelper localDatabaseHelper;
  final UserRemoteDataSource userRemoteDataSource;

  UserRepoImplementation({
    required this.localDatabaseHelper,
    required this.userRemoteDataSource,
  });

  @override
  Future<Either<Failure, AddDetailsUser>> addDetailsUser(UserModel user) async {
    try {
      // Save to remote database
      await userRemoteDataSource.addUserData(user);

      // Save to local database
      await localDatabaseHelper.insertUser(user);

      return Right(user);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
