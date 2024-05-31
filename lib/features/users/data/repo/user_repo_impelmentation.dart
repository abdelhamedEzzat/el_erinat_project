import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';

class UserRepoImplementation implements UserRepo {
  final LocalDatabaseHelper localDatabaseHelper;
  final UserRemoteDataSource userRemoteDataSource;

  UserRepoImplementation({
    required this.localDatabaseHelper,
    required this.userRemoteDataSource,
  });

  @override
  Future<Either<Failure, AddPersonalDetailsUser>> addPersonalDetailsUser(
      UserModel user) async {
    try {
      // Save to local database
      await localDatabaseHelper.insertUser(user);
      // Save to remote database
      await userRemoteDataSource.addUserData(user);

      return Right(user);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<List<UserModel>> getPersonalUsers() async {
    final localUsers = await localDatabaseHelper.getAllUsers();
    if (localUsers.isNotEmpty) {
      print("get from local database");
      return localUsers;
    } else {
      // Fetch users from the remote data source
      final data = await userRemoteDataSource.getUserData();
      final personalDetails = data['personalDetails'] as Map<String, dynamic>;

      print("Get from remote database");

      final user = UserModel.fromJson(personalDetails);
      await localDatabaseHelper.insertUser(user);
      return [user];
    }
  }
}
