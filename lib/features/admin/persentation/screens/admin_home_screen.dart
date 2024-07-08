import 'package:el_erinat/core/config/images_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/admin/persentation/widget/admin_home_widget/admin_home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBarAndDaynamicBody(
      alignmentTitle: Alignment.centerRight,
      titleName: "الادمن",
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              ItemInDrawer(
                text: "الرئيسيه",
                icon: Icons.home,
                onTap: () {},
              ),
              const Divider(),
              ItemInDrawer(
                text: "معلومات الحساب",
                icon: Icons.account_circle,
                onTap: () {},
              ),
              const Divider(),
              ItemInDrawer(
                text: "تسجيل الخروج",
                icon: Icons.logout,
                onTap: () {},
              ),
              const Divider(),
              const Spacer(),
              Text("انضم الينا ",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Image.asset(ImagesStrings.facebook, width: 50.w),
                    ),
                    GestureDetector(
                      child: Image.asset(ImagesStrings.instgram, width: 35.w),
                    ),
                    GestureDetector(
                      child: Image.asset(ImagesStrings.twitter, width: 30.w),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      yourBodyOfScreen: const AdminHomeScreenBody(),
    );
  }
}

class ItemInDrawer extends StatelessWidget {
  const ItemInDrawer({
    super.key,
    this.onTap,
    this.icon,
    required this.text,
  });
  final void Function()? onTap;
  final IconData? icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(9.h),
        margin: EdgeInsets.only(right: 9.h, left: 9.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 21.w,
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(text,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
