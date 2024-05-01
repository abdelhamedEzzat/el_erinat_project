import 'package:el_erinat/core/config/images_strings.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      ImagesStrings.splash,
      semanticsLabel: MStrings.appName,
    );
  }
}
