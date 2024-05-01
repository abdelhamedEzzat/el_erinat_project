// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottonClick extends StatelessWidget {
  const BottonClick(
      {super.key,
      required this.alignment,
      required this.width,
      required this.onTap,
      required this.text,
      this.margin,
      this.colorBotton,
      this.borderRadius,
      this.height});
  final double width;
  final void Function()? onTap;
  final AlignmentGeometry? alignment;
  final String text;
  final EdgeInsetsGeometry? margin;
  final Color? colorBotton;
  final BorderRadiusGeometry? borderRadius;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: alignment,
          margin: margin,
          decoration: BoxDecoration(
              color: colorBotton ?? ColorManger.logoColor,
              borderRadius: borderRadius),
          width: width,
          height: height ?? 43.h,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.w,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
