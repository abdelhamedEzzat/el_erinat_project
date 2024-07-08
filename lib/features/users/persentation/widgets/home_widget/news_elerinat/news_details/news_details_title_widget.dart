import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsDetailsTitleWidget extends StatelessWidget {
  const NewsDetailsTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: EdgeInsets.only(top: 5.h, right: 15.w, left: 15.w),
      width: MediaQuery.of(context).size.width,
      child: Text(
        maxLines: 7,
        textAlign: TextAlign.end,
        overflow: TextOverflow.ellipsis,
        "تم اضافه كتاب الي المكتبه ",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: ColorManger.subScreenscontainerColor,
            ),
      ),
    );
  }
}
