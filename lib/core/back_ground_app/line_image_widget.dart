import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/config/images_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LineImageWidget extends StatelessWidget {
  const LineImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(ColorManger.logoColor, BlendMode.srcIn),
        child: SvgPicture.asset(
          fit: BoxFit.fill,
          ImagesStrings.backgroundLine,
        ),
      ),
    );
  }
}
