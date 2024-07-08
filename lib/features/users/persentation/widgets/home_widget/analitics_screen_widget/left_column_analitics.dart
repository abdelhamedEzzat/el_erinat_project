import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeftColumnAnalitics extends StatelessWidget {
  const LeftColumnAnalitics({
    super.key,
    required this.leftNumber,
    required this.leftText,
  });
  final String leftNumber;
  final String leftText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: 120.w,
          height: 25.h,
          child: Text(
            textAlign: TextAlign.center,
            leftNumber,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorManger.subScreenscontainerColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.h),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          alignment: Alignment.center,
          width: 120.w,
          height: 25.h,
          child: Text(
            leftText,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorManger.subScreenscontainerColor,
                fontWeight: FontWeight.bold,
                fontSize: 12.w),
          ),
        )
      ],
    );
  }
}
