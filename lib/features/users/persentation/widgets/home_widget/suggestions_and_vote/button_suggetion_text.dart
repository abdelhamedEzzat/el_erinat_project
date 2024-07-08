import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottonSuggetionText extends StatelessWidget {
  const BottonSuggetionText({
    super.key,
    required this.chooseText,
    this.onTap,
  });
  final String chooseText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200.w,
        height: 130.h,
        decoration: BoxDecoration(
          color: ColorManger.logoColor.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(8.h)),
        ),
        padding: EdgeInsets.all(25.h),
        child: Center(
          child: Text(
            chooseText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontSize: 18.h,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
