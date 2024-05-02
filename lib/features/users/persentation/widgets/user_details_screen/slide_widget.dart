import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlideWidget extends StatelessWidget {
  const SlideWidget({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 10.h),
      height: 7.h,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(10.w))),
    ));
  }
}
