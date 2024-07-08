import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/data/model/upload_image.dart';
import 'package:el_erinat/features/users/data/model/user_problems_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
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

  Future<Map<String, dynamic>> getUserData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot snapshot = await users.doc(user).get();
    return snapshot.data() as Map<String, dynamic>;
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
      String childName, Uint8List image) async {
    Reference ref =
        storage.ref('identityImage').child("identityImage$childName");

    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> saveIdentityImageDataTOfirebase(
      {required Uint8List image, int? id}) async {
    UploadImage uploadImage = UploadImage();
    try {
      uploadImage.uploadedIdentityImage = await uploadIdentityImageToStorage(
          FirebaseAuth.instance.currentUser!.uid, image);
      //uploadImage.id = 1;
      uploadImage.uID = FirebaseAuth.instance.currentUser!.uid;
      final uploadImageEntity = UploadImageEntityes(
        id: id,
        uID: uploadImage.uID,
        uploadedIdentityImage: uploadImage.uploadedIdentityImage,
      );
      await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'identityImage': uploadImageEntity.toJson(),
      }, SetOptions(merge: true));
      return uploadImage.uploadedIdentityImage.toString();
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
        uploadedIdentityImage: url,
        bytes: response.bodyBytes,
      );

      // Convert UploadImage to UploadImageEntityes
      final uploadImageEntity = UploadImageEntityes(
        id: uploadImage.id,
        uID: uploadImage.uID,
        uploadedIdentityImage: uploadImage.uploadedIdentityImage,
      );

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
            statusOfProblem: "قيد المراجعه")
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

  Future<List<UserProblemsModel>> getProblemsAuditor() async {
    final querySnapshot = await firestore.collection('userProblems').get();
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
            statusOfProblem: "قيد المراجعه")
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