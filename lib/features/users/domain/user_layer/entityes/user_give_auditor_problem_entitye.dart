class UserGiveAuditorProblemEntitye {
  int? id;
  String? uID;
  String? problemTitle;
  String? problemDescription;
  String? actionNeded;
  String? createdAt;
  String? statusOfProblem;

  UserGiveAuditorProblemEntitye(
      {this.id,
      this.uID,
      this.problemTitle,
      this.problemDescription,
      this.actionNeded,
      this.createdAt,
      this.statusOfProblem});

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

  UserGiveAuditorProblemEntitye.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uID = json['uID'];
    problemTitle = json['problemTitle'];
    problemDescription = json['problemDescription'];
    actionNeded = json['actionNeded'];
    createdAt = json['createdAt'];
    statusOfProblem = json['statusOfProblem'];
  }
}
