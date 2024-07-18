import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/data/model/work_user_model.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/work_personal_details_cubit/work_personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/all_slides_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/gender_user_detatils/birthday_date.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/subtitle_in_user_details_screen.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/text_field_for_user_detatils.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/title_in_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkUserDetails extends StatefulWidget {
  const WorkUserDetails({super.key});

  @override
  State<WorkUserDetails> createState() => _WorkUserDetailsState();
}

class _WorkUserDetailsState extends State<WorkUserDetails> {
  LocalDatabaseHelper localDatabaseHelper = LocalDatabaseHelper();
  String selectedDate = '';
  bool isHijridate = false;

  String selectedDateForCertifcate = '';
  bool isHijridateForCertifcate = false;

  WorkModel workmodel = WorkModel();
  final List<String> items = [
    "التخصص العام",
    'صيدلي',
    'مهندس',
    'حاصل علي الماجيستير',
    'طبيب',
    'قاضي',
    'حاصل علي الدكتوراة',
    'محاسب',
    'المعلمون',
    "طيار",
    "طالب",
    'عامل'
  ];
  String? selectedValue = "التخصص العام";
  bool isJobSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AllSlidesWidget(
                      colors1: ColorManger.logoColor.withOpacity(0.5),
                      colors2: ColorManger.logoColor,
                      colors3: ColorManger.logoColor.withOpacity(0.5),
                    ),
                    SizedBox(height: 25.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: ColorManger.logoColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          child: Column(
                            children: [
                              TitleInUserDetailsScreen(
                                text: MStrings.userWelcomeInSudiaArabia,
                                titleColor: ColorManger.logoColor,
                              ),
                              SizedBox(height: 10.h),
                              SubTitleInUserDetailsScreen(
                                text: MStrings.tellUsMoreAboutYou,
                              ),
                              SizedBox(height: 20.h),
                              BithDayDate(
                                textIftrue: "${workmodel.dateOfBirthday}",
                                isHijridate: isHijridate,
                                onDateSelected: (String date, bool isHijri) {
                                  setState(() {
                                    workmodel.dateOfBirthday = date;
                                    isHijridate = isHijri;
                                  });
                                },
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                padding: EdgeInsets.all(3.0.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: ColorManger.logoColor)),
                                alignment: Alignment.centerRight,
                                child: DropdownButton<String>(
                                  isDense: true,
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 10.0,
                                      top: 10.0,
                                      bottom: 8.0),
                                  isExpanded: true,
                                  value: selectedValue,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 22.h,
                                  elevation: 16,
                                  style: TextStyle(
                                    color: ColorManger.logoColor,
                                  ),
                                  underline: Container(
                                    height: 1,
                                    color:
                                        ColorManger.logoColor.withOpacity(0.7),
                                  ),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        isJobSelected = true;
                                        selectedValue = newValue;
                                        workmodel.jobSelected = newValue;
                                      });
                                    }
                                  },
                                  items: items.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            color: isJobSelected == false
                                                ? Colors.black.withOpacity(0.3)
                                                : Colors.black,
                                            fontSize: 14.h,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              TextFieldForUserDetatils(
                                isTextField: true,
                                text1: MStrings.jobSpecialization,
                                text2: MStrings.specialization,
                                onChangedText1: (generalSpecialization) {
                                  workmodel.generalSpecialization =
                                      generalSpecialization;
                                },
                                onChangedText3: (specialization) {
                                  workmodel.specialization = specialization;
                                },
                              ),
                              SizedBox(height: 15.h),
                              TextFieldForUserDetatils(
                                isCalenderField: true,
                                isTextField: false,
                                text1: MStrings.theuniversity,
                                text2: MStrings.dateofobtainingthecertificate,
                                onChangedText1: (theuniversity) {
                                  setState(() {
                                    workmodel.university = theuniversity;
                                  });
                                },
                                selectedDate: workmodel.dateOfCertificate,
                                isHijridate: isHijridateForCertifcate,
                                onDateSelected: (String date, bool isHijri) {
                                  setState(() {
                                    workmodel.dateOfCertificate = date;
                                    isHijridateForCertifcate = isHijri;
                                  });
                                },
                              ),
                              SizedBox(height: 15.h),
                              TextFieldForUserDetatils(
                                isTextField: true,
                                text1: MStrings.employer,
                                text2: MStrings.city,
                                onChangedText1: (employer) {
                                  setState(() {
                                    workmodel.employer = employer;
                                  });
                                },
                                onChangedText3: (city) {
                                  setState(() {
                                    workmodel.city = city;
                                  });
                                },
                              ),
                              SizedBox(height: 15.h),
                              TextFieldForUserDetatils(
                                isTextField: true,
                                text1: MStrings.thecondition,
                                text2: MStrings.title,
                                onChangedText1: (thecondition) {
                                  setState(() {
                                    workmodel.status = thecondition;
                                  });
                                },
                                onChangedText3: (title) {
                                  setState(() {
                                    workmodel.title = title;
                                  });
                                },
                              ),
                              SizedBox(height: 15.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: 30.h,
          right: 20.w,
          left: 20.w,
        ),
        child: BottonClick(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          onTap: () async {
            await BlocProvider.of<WorkPersonalDetailsCubit>(context)
                .saveDataForUser(workmodel)
                .whenComplete(() => context
                    .read<WorkPersonalDetailsCubit>()
                    .updateJobAnalysis(workmodel))
                .whenComplete(() => Navigator.of(context)
                    .pushNamed(ConstantsRouteString.userDetailsIdentaty));
          },
          text: MStrings.next,
        ),
      ),
    );
  }
}
