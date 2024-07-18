import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

Future<File?> pickImageFile(context) async {
  // Check camera permission status

  try {
    var status = await Permission.storage.status;

    if (status.isDenied) {
      // Request camera permission
      if (await Permission.storage.request().isGranted) {
        // Permission granted, open camera
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'svg'],
        );

        if (result != null && result.files.single.path != null) {
          return File(result.files.single.path!);
        }
      } else {
        // Permission denied, handle accordingly
        print('Camera permission denied');
      }
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, navigate to app settings
      openAppSettings();
    } else {
      // Permission already granted, open camera
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'svg'],
      );

      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
    }
  } catch (e) {
    print("Error picking file: $e");
    extension(e.toString());
  }
  return null;
}

Future<File?> pickPdfFile(context) async {
  // Check camera permission status

  try {
    var status = await Permission.storage.status;

    if (status.isDenied) {
      // Request camera permission
      if (await Permission.storage.request().isGranted) {
        // Permission granted, open camera
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

        if (result != null && result.files.single.path != null) {
          return File(result.files.single.path!);
        }
      } else {
        // Permission denied, handle accordingly
        print('Camera permission denied');
      }
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, navigate to app settings
      openAppSettings();
    } else {
      // Permission already granted, open camera
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
    }
  } catch (e) {
    print("Error picking file: $e");
    extension(e.toString());
  }
  return null;
}

Future<File?> pickNewsFiles(BuildContext context) async {
  // Check camera permission status

  try {
    var status = await Permission.storage.status;

    if (status.isDenied) {
      // Request camera permission
      if (await Permission.storage.request().isGranted) {
        // Permission granted, open camera
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'svg', 'mp4', 'mov', 'avi'],
        );

        if (result != null && result.files.single.path != null) {
          File file = File(result.files.single.path!);
          String? type = getFileType(file);
          if (type != null) {
            return file;
          }
        }
      } else {
        // Permission denied, handle accordingly
        print('Camera permission denied');
      }
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, navigate to app settings
      openAppSettings();
    } else {
      // Permission already granted, open camera
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'svg', 'mp4', 'mov', 'avi'],
      );

      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);
        String? type = getFileType(file);
        if (type != null) {
          return file;
        }
      }
    }
  } catch (e) {
    print("Error picking file: $e");
    extension(e.toString());
  }
  return null;
}

String? getFileType(File file) {
  String extension = file.path.split('.').last.toLowerCase();
  if (['jpg', 'jpeg', 'png', 'svg'].contains(extension)) {
    return 'IMAGE';
  } else if (['mp4', 'mov', 'avi'].contains(extension)) {
    return 'VIDEO';
  }
  return null;
}

void disposeVideoController(VideoPlayerController? controller) {
  controller?.dispose();
}
















// Future<File?> pickNewsFiles(BuildContext context) async {
//   try {
//     var status = await Permission.storage.status;

//     if (!status.isDenied && !status.isPermanentlyDenied) {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['jpg', 'jpeg', 'png', 'svg', 'mp4', 'mov', 'avi'],
//       );

//       if (result != null && result.files.single.path != null) {
//         File file = File(result.files.single.path!);
//         String? type = getFileType(file);
//         if (type != null) {
//           return file;
//         }
//       }
//       // else {
//       //   await showAlertDialog(context);
//       //   return null;
//       // }
//     } else if (status.isDenied ||
//         status.isPermanentlyDenied ||
//         !status.isGranted) {
//       status = await Permission.storage.request();
//       await showAlertDialog(context);
//       return null;
//     }
//   } on PlatformException catch (e) {
//     print("Error picking file: $e");
//   } catch (e) {
//     print("Error picking file: $e");
//   }

//   return null;
// }

// Future showAlertDialog( context) {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Access denied',style: TextStyle(color: Colors.red , fontWeight: FontWeight.bold , fontSize: 18.w),),
//         content: Text('Please allow access to files',style: TextStyle(color: Colors.black , fontWeight: FontWeight.normal , fontSize: 14.w),),
//         actions: [
//            TextButton(
//             child: Container(decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.grey.withOpacity(0.5)),),
//               padding: const EdgeInsets.all(8.0),
//               child:  Text('Settings',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 12.w),),),
//             onPressed:() => openAppSettings(),),
//           TextButton(
//             child:
//             Container(decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.grey.withOpacity(0.5)),),
//               padding: const EdgeInsets.all(8.0),
//               child:  Text('Ok',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 12.w),),),

//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }