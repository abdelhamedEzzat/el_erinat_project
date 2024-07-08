import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsSubTitle extends StatelessWidget {
  const NewsSubTitle({
    super.key,
    this.subtitle,
  });
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: EdgeInsets.only(top: 5.h, right: 15.w, left: 15.w),
      width: MediaQuery.of(context).size.width,
      child: Text(
        textAlign: TextAlign.end,
        subtitle!,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white, fontSize: 12.h),
      ),
    );
  }
}
