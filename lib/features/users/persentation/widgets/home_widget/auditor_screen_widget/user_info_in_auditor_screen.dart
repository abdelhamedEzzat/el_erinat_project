import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/helpers/custom_app_bar.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/finished_user_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/get_identity_details_auditor.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/get_personal_details_for_auditor.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/get_personal_work_details_auditor_screem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInformationInAuditorScreen extends StatelessWidget {
  const UserInformationInAuditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String userUID = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: CustomAppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop("refresh");
          },
        ),
        alignmentTitle: Alignment.center,
        title: Text(
          "معلومات الحساب",
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            GetpersonalDetailsForAuditor(
              userUID: userUID,
            ),
            Divider(
              color: ColorManger.logoColor,
              indent: 20.w,
              endIndent: 20.w,
            ),

            GetPersonalWorkDetails(
              userUID: userUID,
            ),
            Divider(
              color: ColorManger.logoColor,
              indent: 20.w,
              endIndent: 20.w,
            ),
            SizedBox(
              height: 10.h,
            ),
            GetIDentityDetailsForAuditor(
              userUID: userUID,
            ),
            Divider(
              color: ColorManger.logoColor,
              indent: 20.w,
              endIndent: 20.w,
            ),
            SizedBox(
              height: 10.h,
            ),
            // GetIdentityDetails()
            //getWorkOfUser
          ],
        ),
      )),
    );
  }
}
