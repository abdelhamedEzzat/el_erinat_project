import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAuditorScreen extends StatelessWidget {
  const UserAuditorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height - 200, //
        padding: EdgeInsets.all(20.w), margin: EdgeInsets.only(top: 20.h),
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
    );
  }
}
