import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/core/helpers/show_my_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggetionScreen extends StatefulWidget {
  const SuggetionScreen({super.key});

  @override
  State<SuggetionScreen> createState() => _SuggetionScreenState();
}

class _SuggetionScreenState extends State<SuggetionScreen> {
  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBarAndDaynamicBody(
        alignmentTitle: Alignment.center,
        titleName: MStrings.suggestionChoise,
        yourBodyOfScreen: Positioned.fill(
          top: 120.h,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 200, //
              padding: EdgeInsets.all(20.w),
              child: Column(
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
                    height: 130.h,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: BottonClick(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          onTap: () {
                            setState(() {
                              showMyDialog(context);
                            });
                          },
                          text: MStrings.submit),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
