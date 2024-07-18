
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/work_details_user_entityes.dart';
import 'package:el_erinat/features/users/data/model/work_user_model.dart'; 
import 'package:el_erinat/features/users/domain/user_layer/entityes/upload_identaty_image.dart';
import 'package:el_erinat/features/users/data/model/upload_image.dart';
import 'dart:typed_data';
import 'package:el_erinat/features/users/data/model/user_problems_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/user_give_auditor_problem_entitye.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/suggetion_entity.dart';
import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/analitics.dart';
abstract class UserRepo {
  Future<Either<Failure, AddPersonalDetailsUser>> addPersonalDetailsUser(UserModel user , String role,String status);
   
  Future<void> updateUserRole(String newRole , UserModel user );
  Future<List<UserModel>> getPersonalUsers();
  Future<Either<Failure, AddPersonalDetailsUser>> updatePersonalDetailsUser(UserModel user);
  Future<List<UserModel>> getWattingUsers();
  Future<List<UserModel>> getAcceptedUsers();
  Future<void> updateStutsOfUser(int id, String newStatus);

 Future<List<UserModel>> getPersonalUsersDataByUidToAuditor(String uid);
  Future<void> deleteUserWhenUnAccepted(String uid , UserModel user);



  Future<void> saveStatistics(Statistics statistics);
  Future<Statistics> getStatistics();
       // 
       //! work user repo 

  Future<Either<Failure, WorkDetailsUserEntityes>> addWorkPersonalDetails(WorkModel work);

  Future<List<WorkModel>> getWorkOfUser();

  Future<void> saveJobAnalitics(JobAnalitics statistics);
  Future<JobAnalitics> getJobAnalitics();
  Future<List<WorkModel>> fetchWorkUsersinfoByID(String uid);
       //
       //! upload identity image 


  Future<Either<Failure, UploadImageEntityes>> uploadAndSaveIdentatyImage(UploadImage uploadImage ,String  image );

  Future<UploadImage?> getIdentityImages(String uID);

 Future<UploadImage?> getIdentityImagesForAuditor(String uID);

 Future<Either<Failure, GetCallFromAuditorEntityes>> uploadAndSaveGetCall(GetCallModel getCallModel ,String getCall );
   Future<GetCallModel?> getCallFromAuditor (String uID , GetCallModel getCallModelForUser);

  //
       //! upload problem user 

 Future<Either<Failure, UserGiveAuditorProblemEntitye>> uploadAndSaveProblemOfUser({
    required UserProblemsModel userProblemsModel,
  });

  Future<List<UserProblemsModel>> getProblemsOfUser(String uID);

   Future<List<UserProblemsModel>> getWattingProblemsForAuditor();

   Future<List<UserProblemsModel>> getFinishedProblemsForAuditor();

  Future<void> updateFinishedProblemsToAuditor(int id, String newStatus);

 //
       //! upload suggetions user
       //
        
   Future<Either<Failure, SuggetionEntity>> uploadSuggetionsOfUser({
    required SuggetionModel suggetionModel, required String role
  });

  Future<List<SuggetionModel>> getSuggetionsToUser(String uID);

    Future<List<SuggetionModel>> getWattingSuggetionsToAuditor();
    Future<List<SuggetionModel>> getFinishedSuggetionsToAuditor();

      Future<List<SuggetionModel>> getVotedToUser();

     Future<void> updateFinishedSuggetionsToAuditor(int id, String newStatus);
  
}
