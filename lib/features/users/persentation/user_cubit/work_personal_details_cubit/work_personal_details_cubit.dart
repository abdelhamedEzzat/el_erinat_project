import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/users/data/model/upload_image.dart';
import 'package:el_erinat/features/users/data/model/work_user_model.dart';
import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/upload_identaty_image.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/work_details_user_entityes.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';
import 'package:el_erinat/features/users/domain/user_layer/use_cases/upload_identaty_image_user.dart';
import 'package:el_erinat/features/users/domain/user_layer/use_cases/work_details_users.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'work_personal_details_state.dart';

class WorkPersonalDetailsCubit extends Cubit<WorkPersonalDetailsState> {
  WorkPersonalDetailsCubit({required this.userRepo})
      : super(WorkPersonalDetailsInitial());

  String uid = FirebaseAuth.instance.currentUser!.uid;

  final UserRepo userRepo;

  Future<void> saveDataForUser(WorkModel user) async {
    emit(WorkPersonalDetailsLoading());

    final userRepo = UserRepoImplementation(
      localDatabaseHelper: LocalDatabaseHelper(),
      userRemoteDataSource: UserRemoteDataSource(),
    );

    final addUserUseCase = AddWorkDetailsUser(userRepo: userRepo);
    final result = await addUserUseCase.call(user);

    result.fold(
      (failure) {
        // Handle failure case
        emit(WorkPersonalDetailsError(failure: failure.message));
        print('Error adding user: ${failure.message}');
      },
      (user) {
        // Handle success case
        emit(WorkPersonalDetailsSuccess(user: user));
        print(
            'User added successfully to Firebase and local database: ${user.city}');
      },
    );
  }

  Future<void> fetchAllUsers() async {
    try {
      emit(WorkPersonalDetailsLoading());

      final users = await userRepo.getWorkOfUser();

      emit(WorkPersonalDetailsLoaded(users));
    } catch (e) {
      emit(WorkPersonalDetailsError(failure: e.toString()));
    }
  }

  // Future<void> uploadImageDataForUser(UploadImage user, File image) async {
  //   emit(WorkPersonalDetailsLoading());

  //   final userRepo = UserRepoImplementation(
  //     localDatabaseHelper: LocalDatabaseHelper(),
  //     userRemoteDataSource: UserRemoteDataSource(),
  //   );

  //   final addUserUseCase = UploadIdentatyImageUser(userRepo: userRepo);
  //   final result = await addUserUseCase.call(user, image);

  //   result.fold(
  //     (failure) {
  //       // Handle failure case
  //       emit(WorkPersonalDetailsError(failure: failure.message));
  //       print('Error adding user: ${failure.message}');
  //     },
  //     (user) {
  //       // Handle success case
  //       emit(WorkPersonalDetailsSuccessFile(user: user));
  //       print(
  //           'User added successfully to Firebase and local database: ${user.uploadedIdentityImage}');
  //     },
  //   );
  // }
  Future<void> uploadImageDataForUser(
      UploadImage cameraImage, Uint8List image) async {
    emit(WorkPersonalDetailsLoading());

    final userRepo = UserRepoImplementation(
      localDatabaseHelper: LocalDatabaseHelper(),
      userRemoteDataSource: UserRemoteDataSource(),
    );

    final addUserUseCase = UploadIdentatyImageUser(userRepo: userRepo);
    final result = await addUserUseCase.call(cameraImage, image);

    result.fold(
      (failure) {
        emit(WorkPersonalDetailsErrorImage(failure: failure.message));
        print('Error adding user: ${failure.message}');
      },
      (user) async {
        await Future.delayed(const Duration(seconds: 2));
        user.uploadedIdentityImage = base64Encode(image);
        emit(WorkPersonalDetailsSuccessFile(user: user));
        print(
            'User added successfully to Firebase and local database: ${user.uploadedIdentityImage}');
      },
    );
  }

  // Future<List<UploadImage>> getImageIdentity() async {
  //   try {
  //     emit(WorkPersonalDetailsLoading());
  //     final users = await userRepo.getIdentityImages();

  //     emit(WorkPersonalDetailsSuccessIdentety(user: users));
  //     return users; // Add this return statement
  //   } catch (e) {
  //     emit(WorkPersonalDetailsError(failure: e.toString()));
  //     throw e; // Optionally, you can throw the error for further handling
  //   }
  // }
  Future<void> fetchImage(String uID) async {
    try {
      emit(WorkPersonalDetailsLoading());
      final image = await userRepo.getIdentityImages(uID);
      if (image != null) {
        emit(WorkPersonalDetailsSuccessIdentety(user: image));
      } else {
        emit(WorkPersonalDetailsError(failure: 'No image found'));
      }
    } catch (e) {
      emit(WorkPersonalDetailsError(failure: e.toString()));
    }
  }
}
