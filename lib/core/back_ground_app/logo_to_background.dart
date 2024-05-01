import 'package:el_erinat/core/config/images_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        ImagesStrings.backgroundLogo,
        fit: BoxFit.contain,
        height: 100.h,
        width: 150.w,
      ),
    );
  }
}
