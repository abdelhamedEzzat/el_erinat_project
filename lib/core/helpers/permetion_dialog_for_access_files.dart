 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> showAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Permission Required',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 16.w),),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This app needs storage permission to access files.',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 12.w),),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Deny',style: TextStyle(color: Colors.red , fontWeight: FontWeight.bold , fontSize: 12.w),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Allow',style: TextStyle(color: Colors.red , fontWeight: FontWeight.bold , fontSize: 12.w),),
            onPressed: () async {
              Navigator.of(context).pop();
              await Permission.storage.request();
            },
          ),
        ],
      );
    },
  );
}