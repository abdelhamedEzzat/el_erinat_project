import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/news_date.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/news_sub_title.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/news_title.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/pic_of_news_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsItemsWidget extends StatelessWidget {
  const NewsItemsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ConstantsRouteString.newsDetails);
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.h),
          color: ColorManger.subScreenscontainerColor.withOpacity(0.8),
        ),
        height: 300.h,
        width: MediaQuery.of(context).size.width,
        child: const Column(
          children: [PicOfNewsItem(), NewsTitle(), NewsSubTitle(), NewsDate()],
        ),
      ),
    );
  }
}
