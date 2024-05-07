import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/news_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsOfElerinatScreen extends StatelessWidget {
  const NewsOfElerinatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBarAndDaynamicBody(
        alignmentTitle: Alignment.center,
        titleName: MStrings.newsOfElerinat,
        yourBodyOfScreen: Positioned.fill(
            top: 150.h,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  children: [
                    const NewsItemsWidget(),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              ),
            )));
  }
}
