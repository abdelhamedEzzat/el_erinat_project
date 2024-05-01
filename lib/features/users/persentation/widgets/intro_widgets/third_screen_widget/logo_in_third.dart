import 'package:el_erinat/core/config/images_strings.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ThirdIntroLogoImage extends StatelessWidget {
  const ThirdIntroLogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      fit: BoxFit.scaleDown,
      width: MediaQuery.of(context).size.width - 100.w,
      ImagesStrings.backgroundLogoSvg,
      semanticsLabel: MStrings.appName,
    );
  }
}
