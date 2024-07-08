// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:el_erinat/core/config/color_manger.dart';

class VoteTitle extends StatelessWidget {
  const VoteTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: EdgeInsets.only(top: 5.h, right: 15.w, left: 15.w),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(
            textAlign: TextAlign.end,
            maxLines: 15,
            overflow: TextOverflow.ellipsis,
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white, fontSize: 18.h),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            textAlign: TextAlign.end,
            maxLines: 15,
            overflow: TextOverflow.ellipsis,
            subtitle,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white, fontSize: 14.h),
          ),
        ],
      ),
    );
  }
}
