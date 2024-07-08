import 'package:el_erinat/features/users/domain/user_layer/entityes/user_give_auditor_problem_entitye.dart';

class UserProblemsModel extends UserGiveAuditorProblemEntitye {
  UserProblemsModel(
      {super.id,
      super.uID,
      super.problemTitle,
      super.problemDescription,
      super.actionNeded,
      super.createdAt,
      super.statusOfProblem});

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uID': uID,
      'problemTitle': problemTitle,
      'problemDescription': problemDescription,
      'actionNeded': actionNeded,
      'createdAt': createdAt,
      'statusOfProblem': statusOfProblem
    };
  }

  UserProblemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uID = json['uID'];
    problemTitle = json['problemTitle'];
    problemDescription = json['problemDescription'];
    actionNeded = json['actionNeded'];
    createdAt = json['createdAt'];
    statusOfProblem = json['statusOfProblem'];
  }
}
