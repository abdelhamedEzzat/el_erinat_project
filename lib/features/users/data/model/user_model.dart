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
      super.gender,
      super.role,
      super.statusOfUser});

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
      role: fireStore['role'],
      statusOfUser: fireStore['statusOfUser'],
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
      'role': role,
      'statusOfUser': statusOfUser
    };
  }

  UserModel copyWith({
    int? id,
    String? firstname,
    String? fatherName,
    String? grandfatherName,
    String? greatGrandfatherName,
    String? age,
    String? countryName,
    String? phoneNumber,
    String? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      fatherName: fatherName ?? this.fatherName,
      grandfatherName: grandfatherName ?? this.grandfatherName,
      greatGrandfatherName: greatGrandfatherName ?? this.greatGrandfatherName,
      age: age ?? this.age,
      countryName: countryName ?? this.countryName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
    );
  }
}
