import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/features/admin/persentation/widget/donations_and_charity/danations_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminDonationsAndCharityScreen extends StatefulWidget {
  const AdminDonationsAndCharityScreen({super.key});

  @override
  State<AdminDonationsAndCharityScreen> createState() =>
      _AdminDonationsAndCharityScreenState();
}

class _AdminDonationsAndCharityScreenState
    extends State<AdminDonationsAndCharityScreen> {
  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBarAndDaynamicBody(
        alignmentTitle: Alignment.center,
        titleName: MStrings.donationsAndCharity,
        yourBodyOfScreen: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SwitchToEnableCharitiesAndDonations(
                  charitiesAndDonations: MStrings.charities,
                ),
                SwitchToEnableCharitiesAndDonations(
                  charitiesAndDonations: MStrings.donations,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(
                    hintText: MStrings.addressTocharitiesOrdonations,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(
                    minLines: 5,
                    hintText: MStrings.detailsTocharitiesOrdonations,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(
                    hintText: MStrings.costNeeded,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: BottonClick(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      onTap: () {},
                      text: MStrings.submit),
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ));
  }
}
