import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPhontToGetCall extends StatelessWidget {
  const UserPhontToGetCall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManger.logoColor.withOpacity(0.5),
      padding: EdgeInsets.all(10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "96658585898",
              style: Theme.of(context).textTheme.bodySmall!,
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              MStrings.yourphoneNumber,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 12.h),
            ),
          ),
        ],
      ),
    );
  }
}
