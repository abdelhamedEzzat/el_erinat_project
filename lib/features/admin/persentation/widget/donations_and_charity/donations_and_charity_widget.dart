import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationsAndCharityWidget extends StatelessWidget {
  const DonationsAndCharityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.all(15.h),
            decoration: BoxDecoration(
                color: ColorManger.logoColor,
                borderRadius: BorderRadius.all(Radius.circular(15.w))),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.attach_money,
                    size: 30.h,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    MStrings.donationsAndCharity,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 11.h,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
