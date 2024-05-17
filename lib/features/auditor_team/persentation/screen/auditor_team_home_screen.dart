import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/home_screen_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuditorTeamHomeScreen extends StatelessWidget {
  const AuditorTeamHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGroundAndAppBarAndDaynamicBody(
      alignmentTitle: Alignment.centerRight,
      titleName: "الادمن",
      drawer: Drawer(),
      yourBodyOfScreen: AuditorHomeScreenBody(),
    );
  }
}

class AuditorHomeScreenBody extends StatelessWidget {
  const AuditorHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: kToolbarHeight - 20.h,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 95.w,
                  mainAxisSpacing: 40.h,
                ),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return HomeScreenItem(
                    isAuditor: true,
                    isAdmin: false,
                    index: index,
                  );
                },
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}
