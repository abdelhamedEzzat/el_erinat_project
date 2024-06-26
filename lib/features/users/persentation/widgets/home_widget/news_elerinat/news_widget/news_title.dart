import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsTitle extends StatelessWidget {
  const NewsTitle({
    super.key,
    this.title,
  });
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.topRight,
        padding: EdgeInsets.only(top: 5.h, right: 15.w, left: 15.w),
        width: MediaQuery.of(context).size.width,
        child: Text(
          textAlign: TextAlign.end,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          title!,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
