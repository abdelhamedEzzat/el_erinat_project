import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_details/news_details_sub_title_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_details/news_details_title_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_details/news_image_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({super.key});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBarAndDaynamicBody(
      alignmentTitle: Alignment.center,
      titleName: MStrings.newsDetails,
      yourBodyOfScreen: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              pinned: false,
              floating: false,
              expandedHeight: 300.0.h,
              flexibleSpace: const FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: NewsImageDetailsWidget(),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const NewsDetailsTitleWidget(),
                  SizedBox(
                    height: 25.h,
                  ),
                  const NewsDetailsSubTitleWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
