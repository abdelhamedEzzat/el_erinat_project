class AddDetailsUser {
  String? id;
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

  AddDetailsUser(
      {this.id,
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

  factory AddDetailsUser.fromJson(Map<String, dynamic> fireStore) {
    return AddDetailsUser(
      id: fireStore['id'],
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
      'id': id,
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
