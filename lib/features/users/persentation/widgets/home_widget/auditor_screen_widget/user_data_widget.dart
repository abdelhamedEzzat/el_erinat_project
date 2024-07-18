import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({
    super.key,
    required this.detailsText,
    required this.userDetails,
  });

  final String detailsText;
  final String userDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            textAlign: TextAlign.end,
            userDetails,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorManger.subScreenscontainerColor,
                fontSize: 12.h,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 3.w),
        Text(
          ":",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: ColorManger.subScreenscontainerColor,
              fontSize: 14.h,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 3.w),
        Text(
          detailsText,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: ColorManger.subScreenscontainerColor,
              fontSize: 12.h,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
