import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';
import 'package:el_erinat/features/users/domain/user_layer/use_cases/add_users.dart';
import 'package:el_erinat/features/users/persentation/cubit/personal_details_cubit/personal_details_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SaveGetFeatchUserDetailsCubit extends Cubit<PersonalDetailsState> {
  SaveGetFeatchUserDetailsCubit({required this.userRepo})
      : super(PersonalDetailsInitial());

  String uid = FirebaseAuth.instance.currentUser!.uid;

  final UserRepo userRepo;

  Future<void> saveDataForUser(UserModel user) async {
    emit(PersonalDetailsLoading());

    final userRepo = UserRepoImplementation(
      localDatabaseHelper: LocalDatabaseHelper(),
      userRemoteDataSource: UserRemoteDataSource(),
    );

    final addUserUseCase = AddUser(userRepo: userRepo);
    final result = await addUserUseCase.call(user);

    result.fold(
      (failure) {
        // Handle failure case
        emit(PersonalDetailsError(failure: failure.message));
        print('Error adding user: ${failure.message}');
      },
      (user) {
        // Handle success case
        emit(PersonalDetailsSuccess(user: user));
        print(
            'User added successfully to Firebase and local database: ${user.age}');
      },
    );
  }

  Future<void> fetchAllUsers() async {
    try {
      emit(PersonalDetailsLoading());

      final users = await userRepo.getPersonalUsers();

      emit(PersonalDetailsLoaded(users));
    } catch (e) {
      emit(PersonalDetailsError(failure: e.toString()));
    }
  }
}














//  FutureBuilder(
//                 future: BlocProvider.of<SaveGetFeatchUserDetailsCubit>(context)
//                     .fetchAllUsers(),
//                 builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//                   final cubitState =
//                       context.watch<SaveGetFeatchUserDetailsCubit>().state;

//                   if (cubitState is SaveGetFeatchUserDetailsLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (cubitState is SaveGetFeatchUserDetailsError) {
//                     return Center(child: Text('Error: ${cubitState.failure}'));
//                   } else if (cubitState is UserLoaded) {
//                     if (cubitState.users.isEmpty) {
//                       return const Center(child: Text('No users found'));
//                     }
//                     return Container(
//                       width: 150,
//                       height: 150,
//                       child: ListView.builder(
//                         itemCount: cubitState.users.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           UserModel user = cubitState.users[index];
//                           return ListTile(
//                             title: Text(user.firstname ?? 'No name'),
//                           );
//                         },
//                       ),
//                     );
//                   }
//                   return Center(child: Text('No users found.'));
//                 },
//               ),