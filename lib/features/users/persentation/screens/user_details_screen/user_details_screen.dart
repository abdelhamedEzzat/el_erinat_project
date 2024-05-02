import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/Subtitle_In_user_details_screen.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/all_slides_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/selected_country.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/text_field_for_user_detatils.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/title_in_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              const SelectedCountry(),

              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: BottonClick(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ConstantsRouteString.userDetailsIdentaty);
                      },
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
