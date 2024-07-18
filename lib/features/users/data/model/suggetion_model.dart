import 'package:el_erinat/features/users/domain/user_layer/entityes/suggetion_entity.dart';

class SuggetionModel extends SuggetionEntity {
  SuggetionModel(
      {super.id,
      super.uID,
      super.suggetionTitle,
      super.suggetionDescription,
      super.firstChoise,
      super.secoundChoise,
      super.thirdChoise,
      super.createdAt,
      super.statusOfProblem,
      super.vote1,
      super.vote2,
      super.vote3,
      super.role});

  @override
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
      'vote1': vote1 ?? 0,
      'vote2': vote2 ?? 0,
      'vote3': vote3 ?? 0,
      'role': role
    };
  }

  SuggetionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uID = json['uID'];
    suggetionTitle = json['suggetionTitle'];
    suggetionDescription = json['suggetionDescription'];
    firstChoise = json['firstChoise'];
    secoundChoise = json['secoundChoise'];
    thirdChoise = json['thirdChoise'];
    createdAt = json['createdAt'];
    statusOfProblem = json['statusOfProblem'];
    vote1 = json['vote1'] ?? 0;
    vote2 = json['vote2'] ?? 0;
    vote3 = json['vote3'] ?? 0;
    role = json['role'];
  }
}
