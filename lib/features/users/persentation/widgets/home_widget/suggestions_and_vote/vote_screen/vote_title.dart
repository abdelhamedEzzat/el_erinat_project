import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoteTitle extends StatelessWidget {
  const VoteTitle({
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
        maxLines: 15,
        overflow: TextOverflow.ellipsis,
        "يرجي التصويت علي المقترح للوصول لافضل الاختيارات ",
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
