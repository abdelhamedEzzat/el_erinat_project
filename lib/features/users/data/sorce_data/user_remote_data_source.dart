import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRemoteDataSource {
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
}
