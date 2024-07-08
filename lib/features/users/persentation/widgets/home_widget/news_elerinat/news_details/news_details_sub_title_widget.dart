import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsDetailsSubTitleWidget extends StatelessWidget {
  const NewsDetailsSubTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: EdgeInsets.only(top: 5.h, right: 15.w, left: 15.w),
      width: MediaQuery.of(context).size.width,
      child: Text(
        textAlign: TextAlign.end,
        maxLines: 60,
        overflow: TextOverflow.ellipsis,
        " تم اضافه كتاب الي المكتبه يمكنكم الاستمتاع بالقراءه وتصفح المزيد من الكتب الموجوده ",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: ColorManger.subScreenscontainerColor, fontSize: 12.h),
      ),
    );
  }
}
