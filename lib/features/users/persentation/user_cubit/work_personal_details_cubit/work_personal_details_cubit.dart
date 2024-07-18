import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/users/data/model/upload_image.dart';
import 'package:el_erinat/features/users/data/model/work_user_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/analitics.dart';
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

  int? judge;
  int? holdsAdoctorate;
  int? holdsAmaster;
  int? doctor;
  int? engineer;
  int? pharmaceutical;
  int? oficer;
  int? accountant;
  int? teachers;
  int? pilot;
  int? student;
  int? factor;

  final Map<String, WorkModel> _previousUserStates = {};

  Future<void> updateJobAnalysis(WorkModel user) async {
    emit(JobAnaliticsDetailsLoading());
    final previousUser = _previousUserStates[user.uID];

    if (previousUser == null) {
      final currentStatistics = await userRepo.getJobAnalitics();
      judge = currentStatistics.judge ?? 0;
      holdsAdoctorate = currentStatistics.holdsAdoctorate ?? 0;
      holdsAmaster = currentStatistics.holdsAmaster ?? 0;
      doctor = currentStatistics.doctor ?? 0;
      engineer = currentStatistics.engineer ?? 0;
      pharmaceutical = currentStatistics.pharmaceutical ?? 0;
      oficer = currentStatistics.oficer ?? 0;
      accountant = currentStatistics.accountant ?? 0;
      teachers = currentStatistics.teachers ?? 0;
      pilot = currentStatistics.pilot ?? 0;
      student = currentStatistics.student ?? 0;
      factor = currentStatistics.factor ?? 0;
    } else {
      _decrementJobCount(previousUser.jobSelected);
    }

    _incrementJobCount(user.jobSelected.toString());
    _previousUserStates[user.uID.toString()] = user;

    final newStatistics = JobAnalitics(
      judge: judge,
      holdsAdoctorate: holdsAdoctorate,
      holdsAmaster: holdsAmaster,
      doctor: doctor,
      engineer: engineer,
      pharmaceutical: pharmaceutical,
      oficer: oficer,
      accountant: accountant,
      teachers: teachers,
      pilot: pilot,
      student: student,
      factor: factor,
    );

    await userRepo.saveJobAnalitics(newStatistics);
    emit(JobAnaliticsDetailsSuccess(jobAnalitics: newStatistics));
  }

  void _incrementJobCount(String jobSelected) {
    switch (jobSelected) {
      case 'قاضي':
        judge = (judge ?? 0) + 1;
        break;
      case 'حاصل علي الدكتوراة':
        holdsAdoctorate = (holdsAdoctorate ?? 0) + 1;
        break;
      case 'حاصل علي الماجيستير':
        holdsAmaster = (holdsAmaster ?? 0) + 1;
        break;
      case 'طبيب':
        doctor = (doctor ?? 0) + 1;
        break;
      case 'مهندس':
        engineer = (engineer ?? 0) + 1;
        break;
      case 'صيدلي':
        pharmaceutical = (pharmaceutical ?? 0) + 1;
        break;
      case 'ضابط':
        oficer = (oficer ?? 0) + 1;
        break;
      case 'محاسب':
        accountant = (accountant ?? 0) + 1;
        break;
      case 'معلم':
        teachers = (teachers ?? 0) + 1;
        break;
      case 'طيار':
        pilot = (pilot ?? 0) + 1;
        break;
      case 'طالب':
        student = (student ?? 0) + 1;
        break;
      case 'عامل':
        factor = (factor ?? 0) + 1;
        break;
      default:
        break;
    }
  }

  void _decrementJobCount(String? jobSelected) {
    if (jobSelected == null) return;
    switch (jobSelected) {
      case 'قاضي':
        judge = (judge ?? 0) - 1;
        break;
      case 'حاصل علي الدكتوراة':
        holdsAdoctorate = (holdsAdoctorate ?? 0) - 1;
        break;
      case 'حاصل علي الماجيستير':
        holdsAmaster = (holdsAmaster ?? 0) - 1;
        break;
      case 'طبيب':
        doctor = (doctor ?? 0) - 1;
        break;
      case 'مهندس':
        engineer = (engineer ?? 0) - 1;
        break;
      case 'صيدلي':
        pharmaceutical = (pharmaceutical ?? 0) - 1;
        break;
      case 'ضابط':
        oficer = (oficer ?? 0) - 1;
        break;
      case 'محاسب':
        accountant = (accountant ?? 0) - 1;
        break;
      case 'معلم':
        teachers = (teachers ?? 0) - 1;
        break;
      case 'طيار':
        pilot = (pilot ?? 0) - 1;
        break;
      case 'طالب':
        student = (student ?? 0) - 1;
        break;
      case 'عامل':
        factor = (factor ?? 0) - 1;
        break;
      default:
        break;
    }
  }

  Future<void> fetchJobAnalitics() async {
    try {
      emit(GetJobAnaliticsLoading());
      final jobstatistics = await userRepo.getJobAnalitics();
      emit(GetJobAnaliticsLoaded(jobAnalitics: jobstatistics));
    } catch (e) {
      emit(GetJobAnaliticsError(failure: e.toString()));
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
    UploadImage cameraImage,
    String image,
  ) async {
    emit(WorkPersonalDetailsLoading());

    final addUserUseCase = UploadIdentatyImageUser(userRepo: userRepo);
    final result = await addUserUseCase.call(cameraImage, image);

    result.fold(
      (failure) {
        emit(WorkPersonalDetailsErrorImage(failure: failure.message));
        print('Error adding user: ${failure.message}');
      },
      (user) async {
        // Handle case where imagePath might be null
        if (user.imagePath == null) {
          // Handle null case appropriately
          emit(WorkPersonalDetailsErrorImage(failure: 'Image path is null'));
          print('Image path is null');
          return;
        }

        await Future.delayed(const Duration(seconds: 2));
        user.imagePath = image; // Assuming this assignment is correct
        emit(WorkPersonalDetailsSuccessFile(user: user));
        print('User added successfully: ${user.imagePath}');
      },
    );
  }

  Future<void> uploadCallDataForUSER(
      GetCallModel getCall, String callMassage) async {
    emit(UplaodCallToUserLoading());

    final addUserUseCase = SaveCallDataFromAuditor(userRepo: userRepo);
    final result = await addUserUseCase.call(getCall, callMassage);

    result.fold(
      (failure) {
        emit(WorkPersonalDetailsErrorImage(failure: failure.message));
        print('Error adding user: ${failure.message}');
      },
      (user) async {
        await Future.delayed(const Duration(seconds: 2));
        user.getCall = callMassage;
        emit(UplaodCallToUserSuccess(user: user));
        print(
            'User added successfully to Firebase and local database: ${user.getCall}');
      },
    );
  }

  Future<void> fetchCall(String uID, GetCallModel getCall) async {
    try {
      emit(GetCallToUserLoading());
      final call = await userRepo.getCallFromAuditor(uID, getCall);
      if (call != null) {
        emit(GetCallToUserSuccess(user: call));
      } else {
        emit(GetCallToUserError(failure: 'No call found'));
      }
    } catch (e) {
      emit(WorkPersonalDetailsError(failure: e.toString()));
    }
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

  Future<void> fetchImageForAuditor(String uID) async {
    try {
      emit(WorkPersonalDetailsUserDataForAuditorLoading());
      final image = await userRepo.getIdentityImagesForAuditor(uID);
      if (image != null) {
        emit(WorkPersonalDetailsUserDataForAuditorLoaded(image));
      } else {
        emit(WorkPersonalDetailsError(failure: 'No image found'));
      }
    } catch (e) {
      emit(WorkPersonalDetailsUserDataForAuditorError(failure: e.toString()));
    }
  }
}
