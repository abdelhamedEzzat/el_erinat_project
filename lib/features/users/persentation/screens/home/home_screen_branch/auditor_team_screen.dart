import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuditorTeamScreen extends StatelessWidget {
  const AuditorTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBarAndDaynamicBody(
        alignmentTitle: Alignment.center,
        titleName: MStrings.auditorTeam,
        yourBodyOfScreen: Positioned.fill(
          top: 130.h,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 200, //
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: MStrings.problem,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextFormField(
                    hintText: MStrings.problemDetails,
                    minLines: 5,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextFormField(
                    hintText: MStrings.actionNeeded,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.bottomCenter,
                    child: BottonClick(
                      alignment: Alignment.center,
                      onTap: () {},
                      width: MediaQuery.of(context).size.width,
                      text: MStrings.submit,
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
