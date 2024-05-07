import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

class NewsItemsWidget extends StatelessWidget {
  const NewsItemsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(bottom: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.h),
          color: ColorManger.logoColor.withOpacity(0.5),
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

class NewsDate extends StatelessWidget {
  const NewsDate({super.key});

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
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          "13-03-2024",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white, fontSize: 12.h, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class NewsSubTitle extends StatelessWidget {
  const NewsSubTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        alignment: Alignment.topRight,
        padding: EdgeInsets.only(top: 5.h, right: 15.w, left: 15.w),
        width: MediaQuery.of(context).size.width,
        child: Text(
          textAlign: TextAlign.end,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          " تم اضافه كتاب الي المكتبه يمكنكم الاستمتاع بالقراءه وتصفح المزيد من الكتب الموجوده ",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white, fontSize: 12.h),
        ),
      ),
    );
  }
}

class NewsTitle extends StatelessWidget {
  const NewsTitle({
    super.key,
  });

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
          "تم اضافه كتاب الي المكتبه ",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class PicOfNewsItem extends StatelessWidget {
  const PicOfNewsItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 9,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Hero(
          tag: "news_image",
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.h), topRight: Radius.circular(5.h)),
            child: Image.asset(
              "assets/photo/bookCover2.jpg",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
