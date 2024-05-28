import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:el_erinat/features/users/domain/user_layer/use_cases/add_users.dart';
import 'package:meta/meta.dart';

part 'save_get_featch_user_details_state.dart';

class SaveGetFeatchUserDetailsCubit
    extends Cubit<SaveGetFeatchUserDetailsState> {
  SaveGetFeatchUserDetailsCubit() : super(SaveGetFeatchUserDetailsInitial());

  Future<void> saveDataForUser(UserModel user) async {
    emit(SaveGetFeatchUserDetailsLoading());

    final userRepo = UserRepoImplementation(
      localDatabaseHelper: LocalDatabaseHelper(),
      userRemoteDataSource: UserRemoteDataSource(),
    );

    final addUserUseCase = AddUser(userRepo: userRepo);
    final result = await addUserUseCase.call(user);

    result.fold(
      (failure) {
        // Handle failure case
        emit(SaveGetFeatchUserDetailsError(failure: failure.message));
        print('Error adding user: ${failure.message}');
      },
      (user) {
        // Handle success case
        emit(SaveGetFeatchUserDetailsSuccess(user: user));
        print(
            'User added successfully to Firebase and local database: ${user.age}');
      },
    );
  }
}
