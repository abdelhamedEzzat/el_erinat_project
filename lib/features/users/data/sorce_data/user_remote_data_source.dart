import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/data/model/upload_image.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/data/model/user_problems_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/analitics.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/upload_identaty_image.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/work_details_user_entityes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UserRemoteDataSource {
  //
  //!
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<dynamic> addUserData(AddPersonalDetailsUser user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    user.uID = FirebaseAuth.instance.currentUser!.uid;
    await firestore
        .collection('users')
        .doc(user.uID)
        .set({"personalDetails": user.toJson()}, SetOptions(merge: true));
  }

  Future<void> deleteUserDataFormFireStore(
      String userId, UserModel user) async {
    try {
      // Delete the user document from Firestore
      await firestore.collection('users').doc(userId).delete();
      print('User document deleted successfully.');
    } catch (e) {
      print('Error deleting user document: $e');
    }
  }
  //!sssssssssssssssssssssssssssssssssssss

  Future<List<UserModel>> getWattingUsersFireStore() async {
    final querySnapshot = await firestore
        .collection('users')
        .where("statusOfUser", isEqualTo: "قيد المراجعه")
        .get();
    return querySnapshot.docs.map((doc) {
      return UserModel.fromJson(doc.data());
    }).toList();
  }

  Future<void> updateUsersStatusInFirestore(int id, String newStatus) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Update the statusOfUser field within the personalDetails map
      await firestore.collection('users').doc(userId).update({
        'personalDetails.statusOfUser': newStatus,
      });
      print('User status updated successfully.');
    } catch (e) {
      print('Error updating user status: $e');
    }
  }

  Future<List<UserModel>> getFinishedAcceptedUsers() async {
    final querySnapshot = await firestore
        .collection('users')
        .where("statusOfUser", isNotEqualTo: "قيد المراجعه")
        .get();
    return querySnapshot.docs.map((doc) {
      return UserModel.fromJson(doc.data());
    }).toList();
  }

  //!sssssssssssssssssssssssssssssssssssss
  Future<Map<String, dynamic>> getUserDataByIdFromFirestore() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot snapshot = await users.doc(user).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getUserDataForAuditorByIdFromFirestore(
      String uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user = uid;
    final DocumentSnapshot snapshot = await users.doc(user).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getUserWorkInfoByIdFromFirestore(
      String uID) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user = uID;
    final DocumentSnapshot snapshot = await users.doc(user).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<void> updateUserRoleInPersonalDetails(
      String newRole, AddPersonalDetailsUser user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;

    // Fetch the document first
    DocumentSnapshot snapshot =
        await firestore.collection('users').doc(currentUserID).get();

    if (snapshot.exists) {
      // Extract the personalDetails map
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> personalDetails = data['personalDetails'];

      // Ensure the uID inside personalDetails matches the current user ID
      if (personalDetails['uID'] == user.uID) {
        // Update the role within the personalDetails
        personalDetails['role'] = newRole;

        // Update only the role field within personalDetails
        await firestore.collection('users').doc(currentUserID).update({
          'personalDetails.role': newRole,
        });

        print('Updated role in Firebase for user with uID: $currentUserID');
      } else {
        print('uID inside personalDetails does not match current user ID.');
      }
    } else {
      print('User document does not exist.');
    }
  }

  Future<String?> getUploadedIdentityImageFromUserData() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final user = FirebaseAuth.instance.currentUser!.uid;
      final DocumentSnapshot snapshot = await users.doc(user).get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        return data['uploadedIdentityImage'] as String?;
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

//
//!

  Future<dynamic> addWorkPersonalDetails(WorkDetailsUserEntityes user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    user.uID = FirebaseAuth.instance.currentUser!.uid;
    await firestore
        .collection('users')
        .doc(user.uID)
        .set({"workDetails": user.toJson()}, SetOptions(merge: true));
  }

  Future<String> uploadIdentityImageToStorage(
      String uid, Uint8List image) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('identityImages/$uid');
    final uploadTask = storageRef.putData(image);
    final snapshot = await uploadTask;
    final imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<String> saveIdentityImageDataToFirebase({
    required Uint8List image,
    int? id,
  }) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final imagePath = await uploadIdentityImageToStorage(uid, image);

      final uploadImageEntity = UploadImageEntityes(
        id: id,
        uID: uid,
        imagePath: imagePath,
      );

      await firestore.collection('users').doc(uid).set({
        'identityImage': uploadImageEntity.toJson(),
      }, SetOptions(merge: true));

      return imagePath;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> saveCallUserDataTOfirebase(
      {required GetCallModel getCall, required String getCallMassage}) async {
    try {
      getCall.uID = FirebaseAuth.instance.currentUser!.uid;
      final getCallModel = GetCallModel(
        id: getCall.id,
        uID: getCall.uID,
        getCall: getCall.getCall,
      );
      await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'identityImage': getCallModel.toJson(),
      }, SetOptions(merge: true));
      return getCallModel.getCall.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<UploadImage> getImageFromStorage(String uID) async {
    UploadImage uploadImage;
    final firebaseStorage = FirebaseStorage.instance;
    final ref = firebaseStorage.ref().child('identityImage $uID');
    try {
      final url = await ref.getDownloadURL();
      final response = await http.get(Uri.parse(url));
      uploadImage = UploadImage(
        uID: uID,
        imagePath: url,
      );

      // Convert UploadImage to UploadImageEntityes
      final uploadImageEntity = UploadImageEntityes(
          id: uploadImage.id,
          uID: uploadImage.uID,
          imagePath: uploadImage.imagePath);

      // Add data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'identityImage': uploadImageEntity.toJson(),
      }, SetOptions(merge: true));

      print('Image data added to Firestore for uID: $uID');
      return uploadImage;
    } catch (e) {
      print(
          'Error getting image from Firebase Storage or saving to Firestore: $e');
      rethrow;
    }
  }

  Future<UploadImage> getImageFromStorageForAuditor(String uID) async {
    UploadImage uploadImage;
    final firebaseStorage = FirebaseStorage.instance;
    final ref = firebaseStorage.ref().child('identityImage $uID');
    try {
      final url = await ref.getDownloadURL();
      final response = await http.get(Uri.parse(url));
      uploadImage = UploadImage(
        uID: uID,
        imagePath: url,
      );

      // Convert UploadImage to UploadImageEntityes
      final uploadImageEntity = UploadImageEntityes(
          id: uploadImage.id,
          uID: uploadImage.uID,
          imagePath: uploadImage.imagePath);

      // Add data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(uID).set({
        'identityImage': uploadImageEntity.toJson(),
      }, SetOptions(merge: true));

      print('Image data added to Firestore for uID: $uID');
      return uploadImage;
    } catch (e) {
      print(
          'Error getting image from Firebase Storage or saving to Firestore: $e');
      rethrow;
    }
  }

  Future<GetCallModel> getCallForUserFromFireStore(
      String uID, GetCallModel getCallModelForUser) async {
    GetCallModel getCallToUserModel = GetCallModel();
    try {
      final getCallModel = GetCallModel(
          id: getCallToUserModel.id,
          uID: getCallToUserModel.uID,
          getCall: getCallToUserModel.getCall);
      await FirebaseFirestore.instance.collection('users').doc(uID).set({
        'identityImage': getCallModel.toJson(),
      }, SetOptions(merge: true));
      return getCallToUserModel;
    } catch (e) {
      print(
          'Error getting Call from Firebase FireStore or saving to Firestore: $e');
      rethrow;
    }
  }

  Future<void> uploadproblemsFromUser({
    required UserProblemsModel userProblemsModel,
  }) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    final String formattedDate = formatter.format(DateTime.now());

    // Save URLs to Firestore
    final docRef = firestore.collection('userProblems').doc();
    final userProblemsData = UserProblemsModel(
            id: userProblemsModel.id,
            uID: FirebaseAuth.instance.currentUser!.uid,
            actionNeded: userProblemsModel.actionNeded,
            problemDescription: userProblemsModel.problemDescription,
            problemTitle: userProblemsModel.problemTitle,
            createdAt: formattedDate,
            statusOfProblem: userProblemsModel.statusOfProblem)
        .toJson();

    await docRef.set(userProblemsData);
  }

  Future<List<UserProblemsModel>> getProblemsUser(String uid) async {
    final querySnapshot = await firestore
        .collection('userProblems')
        .where('uID', isEqualTo: uid)
        .get();
    return querySnapshot.docs.map((doc) {
      return UserProblemsModel.fromJson(doc.data());
    }).toList();
  }

  Future<List<UserProblemsModel>> getWattingProblemsAuditor() async {
    final querySnapshot = await firestore
        .collection('userProblems')
        .where("statusOfProblem", isEqualTo: "قيد المراجعه")
        .get();
    return querySnapshot.docs.map((doc) {
      return UserProblemsModel.fromJson(doc.data());
    }).toList();
  }

  Future<void> updateProblemStatusInFirestore(int id, String newStatus) async {
    final querySnapshot = await firestore
        .collection('userProblems')
        .where('id', isEqualTo: id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docRef = querySnapshot.docs.first.reference;
      await docRef.update({'statusOfProblem': newStatus});
    } else {
      throw Exception("No document found with id: $id");
    }
  }

  Future<List<UserProblemsModel>> getFinishedproblemsAuditor() async {
    final querySnapshot = await firestore
        .collection('userProblems')
        .where("statusOfProblem", isNotEqualTo: "قيد المراجعه")
        .get();
    return querySnapshot.docs.map((doc) {
      return UserProblemsModel.fromJson(doc.data());
    }).toList();
  }

  Future<void> uploadSuggetionFromUser({
    required SuggetionModel suggetionModel,
  }) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    final String formattedDate = formatter.format(DateTime.now());

    // Save URLs to Firestore
    final docRef = firestore.collection('Suggetions').doc();
    final suggetionModelData = SuggetionModel(
            id: suggetionModel.id,
            uID: FirebaseAuth.instance.currentUser!.uid,
            suggetionTitle: suggetionModel.suggetionTitle,
            suggetionDescription: suggetionModel.suggetionDescription,
            firstChoise: suggetionModel.firstChoise,
            secoundChoise: suggetionModel.secoundChoise,
            thirdChoise: suggetionModel.thirdChoise,
            createdAt: formattedDate,
            statusOfProblem: "قيد المراجعه",
            role: suggetionModel.role)
        .toJson();

    await docRef.set(suggetionModelData);
  }

  Future<List<SuggetionModel>> getSuggetionsUser(String uid) async {
    final querySnapshot = await firestore
        .collection('Suggetions')
        .where('uID', isEqualTo: uid)
        .get();
    return querySnapshot.docs.map((doc) {
      return SuggetionModel.fromJson(doc.data());
    }).toList();
  }

  Future<List<SuggetionModel>> getWattingSuggetionsAuditor() async {
    final querySnapshot = await firestore
        .collection('Suggetions')
        .where("statusOfProblem", isEqualTo: "قيد المراجعه")
        .get();
    return querySnapshot.docs.map((doc) {
      return SuggetionModel.fromJson(doc.data());
    }).toList();
  }

  Future<List<SuggetionModel>> getFinishedSuggetionsAuditor() async {
    final querySnapshot = await firestore
        .collection('Suggetions')
        .where("statusOfProblem", isNotEqualTo: "قيد المراجعه")
        .get();
    return querySnapshot.docs.map((doc) {
      return SuggetionModel.fromJson(doc.data());
    }).toList();
  }

  Future<List<SuggetionModel>> getRemoteVoteToUsers() async {
    final querySnapshot = await firestore
        .collection('Suggetions')
        .where("statusOfProblem", isEqualTo: "تم الموافقه علي الاقتراح")
        .get();
    return querySnapshot.docs.map((doc) {
      return SuggetionModel.fromJson(doc.data());
    }).toList();
  }

  Future<void> updateStatusInFirestore(int id, String newStatus) async {
    final querySnapshot = await firestore
        .collection('Suggetions')
        .where('id', isEqualTo: id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docRef = querySnapshot.docs.first.reference;
      await docRef.update({'statusOfProblem': newStatus});
    } else {
      throw Exception("No document found with id: $id");
    }
  }

  Future<void> saveTotalLiveAndDead(int totalLive, int totalDead) async {
    await firestore.collection('totals').doc('liveAndDead').set({
      'totalLive': totalLive,
      'totalDead': totalDead,
    });
  }

  Future<Map<String, int>> getTotalLiveAndDead() async {
    final doc = await firestore.collection('totals').doc('liveAndDead').get();
    if (doc.exists) {
      final data = doc.data()!;
      return {
        'totalLive': data['totalLive'],
        'totalDead': data['totalDead'],
      };
    }
    return {'totalLive': 0, 'totalDead': 0};
  }

  Future<void> saveStatisticsToFirebase(Statistics statistics) async {
    await FirebaseFirestore.instance
        .collection('statistics')
        .doc('stats')
        .set(statistics.toJson());
  }

  Future<Statistics> fetchStatisticsFromFirebase() async {
    final doc = await FirebaseFirestore.instance
        .collection('statistics')
        .doc('stats')
        .get();
    if (doc.exists) {
      return Statistics.fromJson(doc.data()!);
    } else {
      return Statistics();
    }
  }

  Future<void> saveJopStatisticsToFirebase(JobAnalitics jobstatistics) async {
    await FirebaseFirestore.instance
        .collection('jobstatistics')
        .doc('jobstats')
        .set(jobstatistics.toJson());
  }

  Future<JobAnalitics> fetchJobStatisticsFromFirebase() async {
    final doc = await FirebaseFirestore.instance
        .collection('jobstatistics')
        .doc('jobstats')
        .get();
    if (doc.exists) {
      return JobAnalitics.fromJson(doc.data()!);
    } else {
      return JobAnalitics();
    }
  }
}










//  PlatformFile? platformFile;
 // Future uploadFile() async {
  //   final path = 'uploadBookImage/${platformFile!.name}';
  //   final file = File(platformFile!.path!);
  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   final res = await ref.putFile(file);

  //   print(res);
  // }

  // Future selectedFile() async {
  //   final result = await FilePicker.platform.pickFiles();
  //   if (result == null) return;

  //     platformFile = result.files.first;
  //     print(platformFile!.name);

  // }