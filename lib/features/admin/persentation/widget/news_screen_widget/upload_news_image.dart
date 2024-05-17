import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadNewsImage extends StatelessWidget {
  const UploadNewsImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        child: Row(
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
        ),
      ),
    );
  }
}
