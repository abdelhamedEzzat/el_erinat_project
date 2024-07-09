import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/data/model/upload_image.dart';
import 'package:el_erinat/features/users/data/model/user_problems_model.dart';
import 'package:el_erinat/features/users/data/model/work_user_model.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/suggetion_entity.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/upload_identaty_image.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/work_details_user_entityes.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepoImplementation implements UserRepo {
  final LocalDatabaseHelper localDatabaseHelper;
  final UserRemoteDataSource userRemoteDataSource;

  UserRepoImplementation({
    required this.localDatabaseHelper,
    required this.userRemoteDataSource,
  });

//
//! this is for addPersonalDetailsUser upload and get data

  @override
  Future<Either<Failure, AddPersonalDetailsUser>> addPersonalDetailsUser(
      UserModel user) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      user.uID = uid;
      // Save to local database
      final localDetailsUser = await localDatabaseHelper.insertUser(user);

      user.id = localDetailsUser.id;
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

//
//! this is for addWorkPersonalDetails upload and get data

  @override
  Future<Either<Failure, WorkDetailsUserEntityes>> addWorkPersonalDetails(
      WorkModel work) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      work.uID = uid;
      // Save to localDatabase database
      final localWork =
          await localDatabaseHelper.addworkPersonalDetailsUser(work);

      work.id = localWork.id;

      // Save to remote database
      await userRemoteDataSource.addWorkPersonalDetails(work);

      return Right(work);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<List<WorkModel>> getWorkOfUser() async {
    final localUsers = await localDatabaseHelper.getWorkUsers();
    if (localUsers.isNotEmpty) {
      print("get from local database");
      return localUsers;
    } else {
      // Fetch users from the remote data source
      final data = await userRemoteDataSource.getUserData();
      final personalDetails = data['workDetails'] as Map<String, dynamic>;

      print("Get from remote database");

      final user = WorkModel.fromJson(personalDetails);
      await localDatabaseHelper.addworkPersonalDetailsUser(user);
      return [user];
    }
  }

//
//! this is for uploadAndSaveIdentatyImage upload and get data

  @override
  Future<Either<Failure, UploadImageEntityes>> uploadAndSaveIdentatyImage(
      UploadImage uploadImage, image) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      uploadImage.uID = uid;
      uploadImage.bytes = image as Uint8List?; // Ensure bytes is set

      // Save to localDatabase database
      final localWork = await localDatabaseHelper
          .uploadIdentityImageToLocalDatabase(uploadImage);
      uploadImage.id = localWork.id;
      print(uploadImage.id);
      print(localWork.id);

      print(
          "---------------------Uploaded image to Local Database-------------------");

      await userRemoteDataSource.saveIdentityImageDataTOfirebase(
          image: image as Uint8List, id: uploadImage.id);

      print(
          "---------------------Uploaded image to Firebase Database-------------------");

      // Save to remote database

      return Right(uploadImage);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<UploadImage?> getIdentityImages(String uID) async {
    //UploadImage Image = UploadImage();
    // Try to get the image from the local data source
    final localImage = await localDatabaseHelper.getImagefromLocalDatabase(uID);
    if (localImage != null) {
      print('Image found in local database for uID: $uID');
      return localImage;
    }

    // If not available locally, get it from the remote data source
    print(
        'Image not found in local database for uID: $uID, fetching from remote source');
    final remoteImage = await userRemoteDataSource.getImageFromStorage(uID);
    // Save the image locally for future use
    await localDatabaseHelper.uploadIdentityImageToLocalDatabase(remoteImage);
    print(
        'Fetched image from remote source and saved to local database for uID: $uID');
    return remoteImage;
  }

//
//! this is for uploadAndSaveProblemOfUser upload and get data

  @override
  Future<Either<Failure, UserProblemsModel>> uploadAndSaveProblemOfUser(
      {required userProblemsModel}) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      userProblemsModel.uID = uid;

      final localWork =
          await localDatabaseHelper.insertProblemsUser(userProblemsModel);
      userProblemsModel.id = localWork.id;

      print(localWork.id);
      print(localWork.actionNeded);
      print(localWork.createdAt);
      print(localWork.problemDescription);
      print(localWork.problemTitle);
      //  print(localWork.createdAt);

      await userRemoteDataSource.uploadproblemsFromUser(
          userProblemsModel: userProblemsModel);

      return Right(userProblemsModel);
    } catch (e) {
      print(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<List<UserProblemsModel>> getProblemsOfUser(String uID) async {
    final localProblems = await localDatabaseHelper.getAllProblems(uID);
    if (localProblems.isNotEmpty) {
      print('Problem found in local database for uID: $uID');
      print('Local Problems: ${localProblems.map((e) => e.toJson())}');
      return localProblems;
    }

    // If not available locally, get it from the remote data source
    print(
        'Problem not found in local database for uID: $uID, fetching from remote source');
    final remoteProblems = await userRemoteDataSource.getProblemsUser(uID);
    print('Remote Problems: ${remoteProblems.map((e) => e.toJson())}');

    // Save the problems locally for future use
    for (var problem in remoteProblems) {
      await localDatabaseHelper.insertProblemsUser(problem);
    }
    print(
        'Fetched problems from remote source and saved to local database for uID: $uID');
    return remoteProblems;
  }

  @override
  Future<List<UserProblemsModel>> getProblemsForAuditor() async {
    final localProblems = await localDatabaseHelper.getAllProblemsForAuditor();
    if (localProblems.isNotEmpty) {
      print('Problem found in local database for all problems');
      print('Local Problems: ${localProblems.map((e) => e.toJson())}');
      return localProblems;
    }

    // If not available locally, get it from the remote data source
    print(
        'Problem not found in local database for for all problems, fetching from remote source');
    final remoteProblems = await userRemoteDataSource.getProblemsAuditor();
    print('Remote Problems: ${remoteProblems.map((e) => e.toJson())}');

    // Save the problems locally for future use
    for (var problem in remoteProblems) {
      await localDatabaseHelper.insertProblemsUser(problem);
    }
    print(
        'Fetched problems from remote source and saved to local database for for all problems');
    return remoteProblems;
  }

//
//! this is for uploadSuggetionsOfUser upload and get data

  @override
  Future<Either<Failure, SuggetionEntity>> uploadSuggetionsOfUser(
      {required SuggetionModel suggetionModel}) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      suggetionModel.uID = uid;

      final localWork =
          await localDatabaseHelper.insertUserSuggetion(suggetionModel);
      suggetionModel.id = localWork.id;

      print(localWork.id);
      print(localWork.firstChoise);
      print(localWork.createdAt);
      print(localWork.suggetionTitle);
      print(localWork.suggetionDescription);
      print(localWork.secoundChoise);
      //  print(localWork.createdAt);

      await userRemoteDataSource.uploadSuggetionFromUser(
          suggetionModel: suggetionModel);

      return Right(suggetionModel);
    } catch (e) {
      print(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<List<SuggetionModel>> getSuggetionsToUser(String uID) async {
    final localProblems = await localDatabaseHelper.getuserSuggetions(uID);
    if (localProblems.isNotEmpty) {
      print('Suggetions found in local database for uID: $uID');
      print('Local Suggetions: ${localProblems.map((e) => e.toJson())}');
      return localProblems;
    }

    // If not available locally, get it from the remote data source
    print(
        'Suggetions not found in local database for uID: $uID, fetching from remote source');
    final remoteSuggetions = await userRemoteDataSource.getSuggetionsUser(uID);
    print('Remote Suggetions: ${remoteSuggetions.map((e) => e.toJson())}');

    // Save the problems locally for future use
    for (var suggetion in remoteSuggetions) {
      await localDatabaseHelper.insertUserSuggetion(suggetion);
    }
    print(
        'Fetched Suggetions from remote source and saved to local database for uID: $uID');
    return remoteSuggetions;
  }

  @override
  Future<List<SuggetionModel>> getWattingSuggetionsToAuditor() async {
    final localProblems = await localDatabaseHelper.getAllWattingSuggetions();
    if (localProblems.isNotEmpty) {
      print('Suggetions found in local database for AllSuggetions');
      print('Local Suggetions: ${localProblems.map((e) => e.toJson())}');
      return localProblems;
    }

    // If not available locally, get it from the remote data source
    print(
        'Suggetions not found in local database for  AllSuggetions, fetching from remote source');
    final remoteSuggetions =
        await userRemoteDataSource.getWattingSuggetionsAuditor();
    print('Remote Problems: ${remoteSuggetions.map((e) => e.toJson())}');

    // Save the problems locally for future use
    for (var suggetion in remoteSuggetions) {
      await localDatabaseHelper.insertUserSuggetion(suggetion);
    }
    print(
        'Fetched Suggetions from remote source and saved to local database  for AllSuggetions');
    return remoteSuggetions;
  }

  @override
  Future<List<SuggetionModel>> getFinishedSuggetionsToAuditor() async {
    final localProblems = await localDatabaseHelper.getAllFinishedSuggetions();
    if (localProblems.isNotEmpty) {
      print('Suggetions found in local database for AllSuggetions');
      print('Local Suggetions: ${localProblems.map((e) => e.toJson())}');
      return localProblems;
    }

    // If not available locally, get it from the remote data source
    print(
        'Problem not found in local database for  AllSuggetions, fetching from remote source');
    final remoteSuggetions =
        await userRemoteDataSource.getFinishedSuggetionsAuditor();
    print('Remote Problems: ${remoteSuggetions.map((e) => e.toJson())}');

    // Save the problems locally for future use
    for (var suggetion in remoteSuggetions) {
      await localDatabaseHelper.insertUserSuggetion(suggetion);
    }
    print(
        'Fetched problems from remote source and saved to local database  for AllSuggetions');
    return remoteSuggetions;
  }

  @override
  Future<void> updateFinishedSuggetionsToAuditor(
      int id, String newStatus) async {
    try {
      // String docId = suggetionModel.id
      //     .toString(); // Assuming the Firestore document ID is the same as the SQLite ID

      // Update status in SQLite
      await localDatabaseHelper.updateStatusInSQLite(id, newStatus);
      print('update in local data base ---------------');

      // Update status in Firestore
      await userRemoteDataSource.updateStatusInFirestore(id, newStatus);

      print('update in globel data base ---------------');
    } catch (e) {
      e.toString();
    }
  }

  @override
  Future<List<SuggetionModel>> getVotedToUser() async {
    final localProblems = await localDatabaseHelper.getLocalVotedSuggetions();
    if (localProblems.isNotEmpty) {
      print('Suggetions found in local database for AllSuggetions');
      print('Local Suggetions: ${localProblems.map((e) => e.toJson())}');
      return localProblems;
    }

    // If not available locally, get it from the remote data source
    print(
        'Problem not found in local database for  AllSuggetions, fetching from remote source');
    final remoteSuggetions = await userRemoteDataSource.getRemoteVoteToUsers();
    print('Remote Problems: ${remoteSuggetions.map((e) => e.toJson())}');

    // Save the problems locally for future use
    for (var suggetion in remoteSuggetions) {
      await localDatabaseHelper.insertUserSuggetion(suggetion);
    }
    print(
        'Fetched problems from remote source and saved to local database  for AllSuggetions');
    return remoteSuggetions;
  }
}















 

    // Optional: Show a message or refresh UI
  
















// final userId = FirebaseAuth.instance.currentUser!.uid;

  // // First, try to get data from the local database
  // final localData =
  //     await localDatabaseHelper.getIdentetyImagesfromLocalDatabase(
  //   userId,
  // );

  // // If local data is not empty, return it
  // if (localData != null && localData.isNotEmpty) {
  //   return localData;
  // }

  // // Otherwise, get data from Firebase Firestore
  // final userData = await userRemoteDataSource.getUserData();
  // final identityImagesJson = userData['identityImages'];

  // // Convert the JSON data to a list of UploadImage
  // final identityImages =
  //     identityImagesJson.map((json) => UploadImage.fromJson(json)).toList();

  // // Save the data to the local database
  // await localDatabaseHelper.getIdentetyImagesfromLocalDatabase(
  //   userId,
  // );

  // return identityImages;

  // Future<dynamic> getIdentityImages() async {
  //   try {
  //     final localUsers =
  //         await localDatabaseHelper.getIdentetyImagesfromLocalDatabase(
  //             FirebaseAuth.instance.currentUser!.uid);
  //     if (localUsers != null && localUsers.isNotEmpty) {
  //       print("---------------get from local database--------------------");
  //       return localUsers;
  //     } else {
  //       final data = await userRemoteDataSource.getUserData();
  //       final personalDetails =
  //           data['ideintetyImageDetails'] as Map<String, dynamic>;

  //       print("---------------Get from remote database----------------");

  //       final user = UploadImage.fromJson(personalDetails);
  //       await localDatabaseHelper.uploadIdentityImageToLocalDatabase(user);
  //       return [user]; // Always return a list
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     return Future.error(e.toString());
  //   }
  // }