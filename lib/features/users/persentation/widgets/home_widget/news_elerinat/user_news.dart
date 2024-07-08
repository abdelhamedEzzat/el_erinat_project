import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/news_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserNews extends StatelessWidget {
  const UserNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          const NewsItemsWidget(),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}
