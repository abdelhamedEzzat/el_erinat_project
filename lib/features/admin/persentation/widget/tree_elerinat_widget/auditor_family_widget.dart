import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuditorFamily extends StatelessWidget {
  const AuditorFamily({
    super.key,
    required this.familyLineage,
    required this.familyName,
  });
  final String familyLineage;
  final String familyName;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: ColorManger.logoColor.withOpacity(0.5),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            familyName,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 14.w, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: ColorManger.logoColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    familyLineage,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 14.w),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
