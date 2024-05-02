import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedCountry extends StatelessWidget {
  const SelectedCountry({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      height: 45.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorManger.logoColor.withOpacity(0.6),
          borderRadius: BorderRadius.all(Radius.circular(7.w))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.arrow_drop_down,
            size: 25.h,
          ),
          Text(
            textAlign: TextAlign.right,
            MStrings.countryName,
            style: TextStyle(
              fontSize: 14.w,
            ),
          ),
        ],
      ),
    );
  }
}
