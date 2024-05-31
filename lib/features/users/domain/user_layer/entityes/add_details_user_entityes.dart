class AddPersonalDetailsUser {
  int? id;
  String? uID;
  String? firstname;
  String? age;
  String? fatherName;
  String? grandfatherName;
  String? greatGrandfatherName;
  String? fatherLiveORDead;
  String? grandfatherLiveORDead;
  String? greatGrandFatherLiveOrDead;
  String? familyName;
  String? phoneNumber;
  String? countryName;
  String? gender;

  AddPersonalDetailsUser(
      {this.id,
      this.uID,
      this.firstname,
      this.age,
      this.fatherName,
      this.grandfatherName,
      this.greatGrandfatherName,
      this.fatherLiveORDead,
      this.grandfatherLiveORDead,
      this.greatGrandFatherLiveOrDead,
      this.familyName,
      this.phoneNumber,
      this.countryName,
      this.gender});

  factory AddPersonalDetailsUser.fromJson(Map<String, dynamic> fireStore) {
    return AddPersonalDetailsUser(
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

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id ?? '',
      'uID': uID ?? '',
      'name': firstname ?? '',
      'age': age ?? '',
      'fatherName': fatherName ?? '',
      'grandfatherName': grandfatherName ?? '',
      'greatGrandfatherName': greatGrandfatherName ?? '',
      'fatherLiveORDead': fatherLiveORDead ?? '',
      'grandfatherLiveORDead': grandfatherLiveORDead ?? '',
      'greatGrandFatherLiveOrDead': greatGrandFatherLiveOrDead ?? '',
      'familyName': familyName ?? '',
      'phoneNumber': phoneNumber ?? '',
      'countryName': countryName ?? '',
      'gender': gender ?? '',
    };
  }
}
