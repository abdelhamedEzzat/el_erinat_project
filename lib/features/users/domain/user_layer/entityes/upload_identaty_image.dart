import 'dart:io';

class UploadImageEntityes {
  int? id;
  String? uID;
  String? imagePath; // Updated to String

  UploadImageEntityes({this.id, this.uID, this.imagePath});

  factory UploadImageEntityes.fromJson(Map<String, dynamic> json) {
    return UploadImageEntityes(
      id: json['id'],
      uID: json['uID'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uID': uID,
      'imagePath': imagePath,
    };
  }
}

class GetCallFromAuditorEntityes {
  int? id;
  String? uID;
  String? getCall;

  GetCallFromAuditorEntityes({
    this.id,
    this.uID,
    this.getCall,
  });

  factory GetCallFromAuditorEntityes.fromJson(Map<String, dynamic> json) {
    return GetCallFromAuditorEntityes(
      id: json['id'] as int?,
      uID: json['uID'] as String?,
      getCall: json['getCall'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'uID': uID ?? "",
      'getCall': getCall ?? "",
    };
  }
}
