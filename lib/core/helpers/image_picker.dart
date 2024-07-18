import 'dart:io';
import 'package:el_erinat/features/users/data/model/upload_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> openCamera(UploadImage uploadImage) async {
  // Check camera permission status
  var status = await Permission.camera.status;

  if (status.isDenied) {
    // Request camera permission
    if (await Permission.camera.request().isGranted) {
      // Permission granted, open camera
      await _captureImageAndSave(uploadImage);
    } else {
      // Permission denied, handle accordingly
      print('Camera permission denied');
    }
  } else if (status.isPermanentlyDenied) {
    // Permission permanently denied, navigate to app settings
    openAppSettings();
  } else {
    // Permission already granted, open camera
    await _captureImageAndSave(uploadImage);
  }
}

Future<void> _captureImageAndSave(UploadImage uploadImage) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.camera);

  if (image != null) {
    File imageFile = File(image.path);
    uploadImage.imagePath = imageFile.path;
  } else {
    // User canceled the camera
    print('No image selected');
  }
}
