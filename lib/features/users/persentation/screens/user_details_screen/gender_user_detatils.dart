import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/all_slides_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/gender_user_detatils/birthday_date.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/subtitle_in_user_details_screen.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/text_field_for_user_detatils.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/title_in_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderUserDetails extends StatefulWidget {
  const GenderUserDetails({super.key});

  @override
  State<GenderUserDetails> createState() => _GenderUserDetailsState();
}

class _GenderUserDetailsState extends State<GenderUserDetails> {
  LocalDatabaseHelper localDatabaseHelper = LocalDatabaseHelper();
  String selectedDate = '';
  bool isHijridate = false;

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
              BithDayDate(
                textIftrue: selectedDate,
                isHijridate: isHijridate,
                onDateSelected: (String date, bool isHijri) {
                  setState(() {
                    selectedDate = date;
                    isHijridate = isHijri;
                  });
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFieldForUserDetatils(
                isTextField: true,
                text1: MStrings.generalSpecialization,
                text2: MStrings.specialization,
                onChangedText1: (p0) {},
                onChangedText3: (p0) {},
              ),
              SizedBox(
                height: 15.h,
              ),
              TextFieldForUserDetatils(
                isTextField: true,
                text1: MStrings.theuniversity,
                text2: MStrings.dateofobtainingthecertificate,
                onChangedText1: (p0) {},
                onChangedText3: (p0) {},
              ),
              SizedBox(
                height: 15.h,
              ),
              TextFieldForUserDetatils(
                isTextField: true,
                text1: MStrings.employer,
                text2: MStrings.city,
                onChangedText1: (p0) {},
                onChangedText3: (p0) {},
              ),
              SizedBox(
                height: 15.h,
              ),
              TextFieldForUserDetatils(
                isTextField: true,
                text1: MStrings.thecondition,
                text2: MStrings.title,
                onChangedText1: (p0) {},
                onChangedText3: (p0) {},
              ),
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: BottonClick(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    onTap: () async {},
                    text: MStrings.next,
                  ),
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
