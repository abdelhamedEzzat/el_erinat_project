import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/config/images_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RegisterLogo extends StatelessWidget {
  const RegisterLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40.h),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(ColorManger.logoColor, BlendMode.srcIn),
        child: SvgPicture.asset(
            width: MediaQuery.of(context).size.width - 100.w,
            ImagesStrings.backgroundLogoSvg,
            fit: BoxFit.scaleDown),
      ),
    );
  }
}
