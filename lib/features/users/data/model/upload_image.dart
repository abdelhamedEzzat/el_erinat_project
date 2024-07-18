import 'package:el_erinat/features/users/domain/user_layer/entityes/upload_identaty_image.dart';

class UploadImage extends UploadImageEntityes {
  UploadImage({
    int? id,
    String? uID,
    String? imagePath, // Updated to String
  }) : super(id: id, uID: uID, imagePath: imagePath);

  factory UploadImage.fromJson(Map<String, dynamic> json) {
    return UploadImage(
      id: json['id'],
      uID: json['uID'],
      imagePath: json['imagePath'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uID': uID,
      'imagePath': imagePath,
    };
  }
}

class GetCallModel extends GetCallFromAuditorEntityes {
  GetCallModel({
    super.id,
    super.uID,
    super.getCall,
  });

  factory GetCallModel.fromJson(Map<String, dynamic> json) {
    return GetCallModel(
      id: json['id'],
      uID: json['uID'],
      getCall: json['getCall'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uID': uID,
      'getCall': getCall,
    };
  }
}
