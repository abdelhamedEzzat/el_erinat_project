import 'dart:convert';
import 'dart:typed_data';

import 'package:el_erinat/features/users/data/model/upload_image.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickImage(ImageSource imageSource) async {
  final ImagePicker picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: imageSource);

  if (file != null) {
    return await file.readAsBytes();
  }
  print("No Image Selected");
  return null;
}

Future openCameraTotakeImage(UploadImage uploadImage) async {
  Uint8List? img = await pickImage(ImageSource.camera);

  try {
    if (img != null) {
      String imgString = base64Encode(img);
      uploadImage.uploadedIdentityImage = imgString;
    } else {
      return;
    }
  } catch (e) {
    e.toString();
  }
}
