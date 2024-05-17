import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/core/helpers/show_my_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminAddSuggetionsScreen extends StatefulWidget {
  const AdminAddSuggetionsScreen({super.key});

  @override
  State<AdminAddSuggetionsScreen> createState() =>
      _AdminAddSuggetionsScreenState();
}

class _AdminAddSuggetionsScreenState extends State<AdminAddSuggetionsScreen> {
  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBarAndDaynamicBody(
      alignmentTitle: Alignment.center,
      titleName: MStrings.suggestions,
      yourBodyOfScreen: Positioned.fill(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormField(
                  hintText: MStrings.addressSuggetions,
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomTextFormField(
                  hintText: MStrings.detailsSuggestion,
                  minLines: 4,
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomTextFormField(
                  hintText: MStrings.acceptedSuggetion,
                  minLines: 1,
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextFormField(
                  hintText: MStrings.notAcceptedSuggetion,
                  minLines: 1,
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextFormField(
                  hintText: MStrings.additionchooseSuggetion,
                  minLines: 1,
                ),
                SizedBox(
                  height: 25.h,
                ),
                BottonClick(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    onTap: () {
                      setState(() {
                        showMyDialog(context);
                      });
                    },
                    text: MStrings.submit),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
