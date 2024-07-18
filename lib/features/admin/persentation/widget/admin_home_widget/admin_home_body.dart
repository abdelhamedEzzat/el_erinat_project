import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/admin/persentation/widget/donations_and_charity/donations_and_charity_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/home_screen_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomeScreenBody extends StatelessWidget {
  const AdminHomeScreenBody({super.key});

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
                    isAuditor: false,
                    isAdmin: true,
                    index: index,
                  );
                },
              ),
            ),
            // GestureDetector(
            //     onTap: () {
            //       Navigator.of(context).pushNamed(
            //           ConstantsRouteString.adminDonationsAndCharityScreen);
            //     },
            //     child: const DonationsAndCharityWidget()),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}
