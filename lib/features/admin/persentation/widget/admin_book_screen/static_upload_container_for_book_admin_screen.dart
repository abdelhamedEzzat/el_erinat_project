import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaticUploadContainerForBookAdminScreen extends StatelessWidget {
  const StaticUploadContainerForBookAdminScreen({
    super.key,
    required this.containerColor,
    required this.iconColor,
    required this.textColor,
    required this.icon,
    required this.titleText,
  });

  final Color containerColor;
  final Color iconColor;
  final Color textColor;
  final String titleText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 165.h,
      decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorManger.logoColor, width: 1.w)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 35.w,
              color: iconColor,
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              titleText,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: textColor, fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
