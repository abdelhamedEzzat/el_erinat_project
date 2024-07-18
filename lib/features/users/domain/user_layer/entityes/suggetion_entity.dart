class SuggetionEntity {
  int? id;
  String? uID;
  String? suggetionTitle;
  String? suggetionDescription;
  String? firstChoise;
  String? secoundChoise;
  String? thirdChoise;
  String? createdAt;
  String? statusOfProblem;
  int? vote1;
  int? vote2;
  int? vote3;
  String? role;

  SuggetionEntity(
      {this.id,
      this.uID,
      this.suggetionTitle,
      this.suggetionDescription,
      this.firstChoise,
      this.secoundChoise,
      this.thirdChoise,
      this.createdAt,
      this.statusOfProblem,
      this.vote1,
      this.vote2,
      this.vote3,
      this.role});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uID': uID,
      'suggetionTitle': suggetionTitle,
      'suggetionDescription': suggetionDescription,
      'firstChoise': firstChoise,
      'secoundChoise': secoundChoise,
      'thirdChoise': thirdChoise,
      'createdAt': createdAt,
      'statusOfProblem': statusOfProblem,
      'vote1': vote1,
      'vote2': vote2,
      'vote3': vote3
    };
  }

  SuggetionEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uID = json['uID'];
    suggetionTitle = json['suggetionTitle'];
    suggetionDescription = json['suggetionDescription'];
    firstChoise = json['firstChoise'];
    secoundChoise = json['secoundChoise'];
    thirdChoise = json['thirdChoise'];
    createdAt = json['createdAt'];
    statusOfProblem = json['statusOfProblem'];
    vote1 = json['vote1'];
    vote2 = json['vote2'];
    vote3 = json['vote3'];
  }
}
