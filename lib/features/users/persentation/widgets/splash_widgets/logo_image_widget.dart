import 'package:el_erinat/core/config/images_strings.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Your other widgets here
        Positioned(
          // Adjust the top position as needed
          //  right: 20.w, // Adjust the left position as needed
          child: Container(
            padding: EdgeInsets.only(right: 50.w),
            child: SvgPicture.asset(
              ImagesStrings.splash,
              semanticsLabel: MStrings.appName,
            ),
          ),
        ),
      ],
    );
  }
}
