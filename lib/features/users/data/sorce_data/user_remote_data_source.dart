import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRemoteDataSource {
  Future<dynamic> addUserData(UserModel user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    user.id = FirebaseAuth.instance.currentUser!.uid;
    final userID = user.id;
    await firestore.collection('users').doc(userID).set(user.toJson());
  }
}
