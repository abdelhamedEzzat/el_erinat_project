import 'dart:io';

import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class UploadNewsImage extends StatefulWidget {
  const UploadNewsImage({
    super.key,
    this.onTap,
    this.selectedFile,
    this.fileType,
  });

  final File? selectedFile;
  final String? fileType;
  final void Function()? onTap;

  @override
  State<UploadNewsImage> createState() => _UploadNewsImageState();
}

class _UploadNewsImageState extends State<UploadNewsImage> {
  VideoPlayerController? _videoController;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(25.w),
        height: 200.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: ColorManger.white.withOpacity(0.9),
            border: Border(
                bottom: BorderSide(
                  width: 5.w,
                  color: ColorManger.logoColor,
                ),
                right: BorderSide(
                  width: 5.w,
                  color: ColorManger.logoColor,
                ),
                left: BorderSide(
                  width: 5.w,
                  color: ColorManger.logoColor,
                ),
                top: BorderSide(
                  width: 5.w,
                  color: ColorManger.logoColor,
                )),
            borderRadius: BorderRadius.all(Radius.circular(7.w))),
        child: widget.selectedFile == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload,
                    size: 25.h,
                    color: ColorManger.logoColor,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Text(MStrings.uploadPic,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: ColorManger.logoColor))
                ],
              )
            : widget.fileType == 'IMAGE'
                ? Image.file(
                    widget.selectedFile!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : _videoController != null &&
                        _videoController!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      )
                    : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
