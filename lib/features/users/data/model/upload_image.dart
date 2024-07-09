import 'dart:convert';
import 'dart:typed_data';
import 'package:el_erinat/features/users/domain/user_layer/entityes/upload_identaty_image.dart';

class UploadImage extends UploadImageEntityes {
  Uint8List? bytes;
  UploadImage({
    this.bytes,
    super.id,
    super.uID,
    super.uploadedIdentityImage, // Corrected name
  });

  factory UploadImage.fromJson(Map<String, dynamic> json) {
    return UploadImage(
      id: json['id'],
      uID: json['uID'],
      uploadedIdentityImage: json['uploadedIdentityImage'],
      bytes: json['bytes'] != null ? base64Decode(json['bytes']) : null,
    ); // Corrected name
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uID': uID,
      'uploadedIdentityImage': uploadedIdentityImage,
      'bytes': bytes != null ? base64Encode(bytes!) : null,
    };
  }
}
