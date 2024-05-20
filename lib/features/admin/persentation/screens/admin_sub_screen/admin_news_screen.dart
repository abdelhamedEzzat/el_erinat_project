import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/user_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminNewsScreen extends StatelessWidget {
  const AdminNewsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ConstantsRouteString.adminUploadNews);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 19.h, vertical: 20.h),
            padding: EdgeInsets.symmetric(horizontal: 19.h, vertical: 20.h),
            color: ColorManger.subScreenscontainerColor,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.newspaper,
                  size: 25.h,
                  color: Colors.white,
                ),
                Text(
                  MStrings.uplaodNews,
                  textAlign: TextAlign.end,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const UserNews(),
      ],
    );
  }
}
