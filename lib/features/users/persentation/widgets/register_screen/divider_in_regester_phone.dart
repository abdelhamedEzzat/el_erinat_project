import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DivederBettwenPhoneAndCountPhoneNumber extends StatelessWidget {
  const DivederBettwenPhoneAndCountPhoneNumber({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40.h),
      child: Divider(
        color: ColorManger.logoColor,
        thickness: 2,
      ),
    );
  }
}
