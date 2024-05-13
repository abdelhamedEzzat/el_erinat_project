import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/all_slides_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/subtitle_in_user_details_screen.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/text_field_for_user_detatils.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/title_in_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderUserDetails extends StatelessWidget {
  const GenderUserDetails({super.key});

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
                colors1: ColorManger.logoColor.withOpacity(0.5),
                colors2: ColorManger.logoColor,
                colors3: ColorManger.logoColor.withOpacity(0.5),
              ),
              SizedBox(
                height: 25.h,
              ),

              //!  ArrowBack to Previous Screen

              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: ColorManger.logoColor,
                    )),
              ),

              //!  title in gender screen

              TitleInUserDetailsScreen(
                text: MStrings.userWelcomeInSudiaArabia,
                titleColor: ColorManger.logoColor,
              ),
              SizedBox(
                height: 10.h,
              ),

              //!  subTitle In Gender Screen

              SubTitleInUserDetailsScreen(
                text: MStrings.tellUsMoreAboutYou,
              ),
              SizedBox(
                height: 20.h,
              ),

              //
              //!     التخصص العام والدقيق
              //

              TextFieldForUserDetatils(
                text1: MStrings.generalSpecialization,
                text2: MStrings.specialization,
                onChangedText1: (p0) {},
                onChangedText2: (p0) {},
              ),
              SizedBox(
                height: 15.h,
              ),

              //
              //! الجامعه وتاريخ الحصول علي الشهاده
              //

              TextFieldForUserDetatils(
                text1: MStrings.theuniversity,
                text2: MStrings.dateofobtainingthecertificate,
                onChangedText1: (p0) {},
                onChangedText2: (p0) {},
              ),
              SizedBox(
                height: 15.h,
              ),

              //
              //!جهه العمل والمدينه
              //

              TextFieldForUserDetatils(
                text1: MStrings.employer,
                text2: MStrings.city,
                onChangedText1: (p0) {},
                onChangedText2: (p0) {},
              ),
              SizedBox(
                height: 15.h,
              ),
              TextFieldForUserDetatils(
                text1: MStrings.thecondition,
                text2: MStrings.title,
                onChangedText1: (p0) {},
                onChangedText2: (p0) {},
              ),
              SizedBox(
                height: 15.h,
              ),
              //
              //!   الحاله واللقب
              //

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
