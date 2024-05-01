import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrSignInIcon extends StatelessWidget {
  const OrSignInIcon({
    super.key,
    required this.image,
    required this.onTap,
  });
  final String image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: ColorManger.logoColor.withOpacity(0.13)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: ColorManger.logoColor,
                  blurRadius: 5,
                  offset: const Offset(0, 4))
            ]),
        padding: EdgeInsets.all(6.h),
        child: Image.asset(
          image,
          height: 35.h,
          width: 35.w,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
