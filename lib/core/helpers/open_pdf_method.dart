import 'dart:io';

import 'package:dio/dio.dart';
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

void openPDF(BuildContext context, String filePath) async {
  try {
    String? tempFilePath;

    // Check if filePath is a URL
    if (filePath.startsWith('http')) {
      // Download the PDF file and save it locally
      final fileName = filePath.split('/').last;
      tempFilePath = '${(await getTemporaryDirectory()).path}/$fileName';

      // Use Dio package to download the file
      await Dio().download(filePath, tempFilePath);
    } else {
      tempFilePath = filePath; // Use provided local file path directly
    }

    // Open the PDF file using OpenFile.open(filePath)
    final result = await OpenFile.open(tempFilePath);

    // Print the relevant details from OpenResult
    print('OpenResult type: ${result.type}');
    print('OpenResult message: ${result.message}');

    // Check if there was an error
    if (result.type == ResultType.error) {
      print('Error opening PDF: ${result.message}');
      // Handle error as needed
    } else {
      // Wait for 60 seconds before showing the dialog
      Future.delayed(const Duration(seconds: 1), () {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          try {
            // Show dialog asking user if they are finished viewing the PDF
            await showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(
                  "تاكيد",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                content: Text(
                  'هل تم الانتهاء من عرض الكتاب؟',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 10.w,
                      ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'نعم',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: ColorManger.logoColor,
                            fontSize: 12.w,
                          ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop(); // Close the dialog
                      // Delete the temporary file after closing PDF viewer
                      await File(tempFilePath!).delete();
                      print('Deleted file: $tempFilePath');
                    },
                  ),
                  TextButton(
                    child: Text(
                      'لا',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: ColorManger.logoColor,
                            fontSize: 12.w,
                          ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              ),
            );
          } catch (e) {
            print('Error deleting file: $e');
            // Handle error deleting file if necessary
          }
        });
      });
    }
  } on PlatformException catch (e) {
    print('Error opening PDF: ${e.message}');
    // Handle platform exceptions (like missing implementation) as needed
  } catch (e) {
    print('Error opening PDF: $e');
    // Handle other exceptions as needed
  }
}
