import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDitailsScreen extends StatelessWidget {
  const UserDitailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AllSlidesWidget(
                colors1: ColorManger.logoColor,
                colors2: ColorManger.logoColor.withOpacity(0.5),
              ),
              SizedBox(
                height: 25.h,
              ),
              TitleInUserDetailsScreen(
                text: MStrings.userWelcomeInSudiaArabia,
                titleColor: ColorManger.logoColor,
              ),
              SizedBox(
                height: 10.h,
              ),
              SubTitleInUserDetailsScreen(
                text: MStrings.tellUsMoreAboutYou,
              ),
              SizedBox(
                height: 20.h,
              ),

              //
              //! الاسم الاول  واسم الاب
              //

              TextFieldForUserDetatils(
                text1: MStrings.yourFirstName,
                text2: MStrings.parentname,
                onChangedText1: (p0) {},
                onChangedText2: (p0) {},
              ),
              SizedBox(
                height: 15.h,
              ),

              //
              //! الاسم الجد  واسم الوالد للجد
              //

              TextFieldForUserDetatils(
                text1: MStrings.grandfatherName,
                text2: MStrings.grandfathersName,
                onChangedText1: (p0) {},
                onChangedText2: (p0) {},
              ),
              SizedBox(
                height: 15.h,
              ),

              //
              //! اسم  جد الجد  واسم الاسره
              //

              TextFieldForUserDetatils(
                text1: MStrings.greatgrandfathersName,
                text2: MStrings.familyName,
                onChangedText1: (p0) {},
                onChangedText2: (p0) {},
              ),
              SizedBox(
                height: 15.h,
              ),

              //
              //!   رقم الجوال الجد  واسم الدوله
              //

              CustomTextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  labelText: Text(
                    MStrings.phoneNumber,
                  ),
                  width: MediaQuery.of(context).size.width),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                height: 45.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ColorManger.logoColor.withOpacity(0.6),
                    borderRadius: BorderRadius.all(Radius.circular(7.w))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      size: 25.h,
                    ),
                    Text(
                      textAlign: TextAlign.right,
                      MStrings.countryName,
                      style: TextStyle(
                        fontSize: 14.w,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: BottonClick(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      onTap: () {},
                      text: MStrings.next),
                ),
              ),

              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldForUserDetatils extends StatelessWidget {
  const TextFieldForUserDetatils({
    super.key,
    this.onChangedText2,
    required this.text1,
    required this.text2,
    this.onChangedText1,
  });
  final void Function(String)? onChangedText2;
  final void Function(String)? onChangedText1;

  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            keyboardType: TextInputType.name,
            onChanged: onChangedText2,
            labelText: Text(text2),
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: CustomTextFormField(
            keyboardType: TextInputType.name,
            onChanged: onChangedText1,
            labelText: Text(
              text1,
            ),
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
      ],
    );
  }
}

class SubTitleInUserDetailsScreen extends StatelessWidget {
  const SubTitleInUserDetailsScreen({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Colors.grey.shade500),
    );
  }
}

class TitleInUserDetailsScreen extends StatelessWidget {
  const TitleInUserDetailsScreen({
    super.key,
    required this.text,
    required this.titleColor,
  });
  final String text;
  final Color titleColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .labelMedium!
          .copyWith(fontWeight: FontWeight.bold)
          .copyWith(color: titleColor),
    );
  }
}

class AllSlidesWidget extends StatelessWidget {
  const AllSlidesWidget({
    super.key,
    required this.colors1,
    required this.colors2,
  });
  final Color colors1;
  final Color colors2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SlideWidget(
          color: colors1,
        ),
        SizedBox(
          width: 15.w,
        ),
        SlideWidget(
          color: colors2,
        ),
      ],
    );
  }
}

class SlideWidget extends StatelessWidget {
  const SlideWidget({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 10.h),
      height: 7.h,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(10.w))),
    ));
  }
}
