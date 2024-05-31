import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';

class UserModel extends AddPersonalDetailsUser {
  UserModel(
      {super.id,
      super.uID,
      super.firstname,
      super.age,
      super.fatherName,
      super.grandfatherName,
      super.greatGrandfatherName,
      super.fatherLiveORDead,
      super.grandfatherLiveORDead,
      super.greatGrandFatherLiveOrDead,
      super.familyName,
      super.phoneNumber,
      super.countryName,
      super.gender});

  factory UserModel.fromJson(Map<String, dynamic> fireStore) {
    return UserModel(
      id: fireStore['id'],
      uID: fireStore['uID'],
      firstname: fireStore['name'],
      age: fireStore['age'],
      fatherName: fireStore['fatherName'],
      grandfatherName: fireStore['grandfatherName'],
      greatGrandfatherName: fireStore['greatGrandfatherName'],
      fatherLiveORDead: fireStore['fatherLiveORDead'],
      grandfatherLiveORDead: fireStore['grandfatherLiveORDead'],
      greatGrandFatherLiveOrDead: fireStore['greatGrandFatherLiveOrDead'],
      familyName: fireStore['familyName'],
      phoneNumber: fireStore['phoneNumber'],
      countryName: fireStore['countryName'],
      gender: fireStore['gender'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uID': uID,
      'name': firstname,
      'age': age,
      'fatherName': fatherName,
      'grandfatherName': grandfatherName,
      'greatGrandfatherName': greatGrandfatherName,
      'fatherLiveORDead': fatherLiveORDead,
      'grandfatherLiveORDead': grandfatherLiveORDead,
      'greatGrandFatherLiveOrDead': greatGrandFatherLiveOrDead,
      'familyName': familyName,
      'phoneNumber': phoneNumber,
      'countryName': countryName,
      'gender': gender,
    };
  }
}
