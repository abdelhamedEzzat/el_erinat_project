import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';

Future<File?> pickImageFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'jpeg', 'png', 'svg'],
  );

  if (result != null && result.files.single.path != null) {
    return File(result.files.single.path!);
  }
  return null;
}

Future<File?> pickPdfFile() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

  if (result != null && result.files.single.path != null) {
    return File(result.files.single.path!);
  }
  return null;
}

Future<File?> pickNewsFiles() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'jpeg', 'png', 'svg', 'mp4'],
  );

  if (result != null && result.files.single.path != null) {
    File file = File(result.files.single.path!);
    String? type = getFileType(file);
    if (type != null) {
      return file;
    } else {
      print("Unsupported file type");
    }
  } else {
    print("File selection cancelled or path is null");
  }

  return null;
}

String? getFileType(File file) {
  String extension = file.path.split('.').last.toLowerCase();
  if (['jpg', 'jpeg', 'png', 'svg'].contains(extension)) {
    return 'IMAGE';
  } else if (['mp4'].contains(extension)) {
    return 'VIDEO';
  }
  return null;
}

void disposeVideoController(VideoPlayerController? controller) {
  controller?.dispose();
}
