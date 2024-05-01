import 'package:el_erinat/core/config/images_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TreeImageWidget extends StatelessWidget {
  const TreeImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: ColorFiltered(
        colorFilter:
            const ColorFilter.mode(Colors.transparent, BlendMode.srcATop),
        child: Container(
          padding: EdgeInsets.only(right: 30.w),
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            ImagesStrings.backgroundTreeImages,
            fit: BoxFit.contain,
            width: 100.w,
            height: 50.h,
          ),
        ),
      ),
    );
  }
}
