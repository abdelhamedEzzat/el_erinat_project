import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RightColumnAnalitics extends StatelessWidget {
  const RightColumnAnalitics({
    super.key,
    required this.rightNumber,
    required this.rightText,
  });
  final String rightNumber;
  final String rightText;
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
            rightNumber,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorManger.logoColor,
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
            rightText,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.w),
          ),
        )
      ],
    );
  }
}
