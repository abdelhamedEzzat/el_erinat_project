import 'package:el_erinat/core/config/list_manger.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/Subtitle_In_user_details_screen.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/all_slides_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/selected_country.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/selected_gender.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/text_field_for_user_detatils.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/title_in_user_details_screen.dart';

class UserDitailsScreen extends StatefulWidget {
  const UserDitailsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserDitailsScreenState createState() => _UserDitailsScreenState();
}

class _UserDitailsScreenState extends State<UserDitailsScreen> {
  final formKey = GlobalKey<FormState>();
  UserModel user = UserModel();
  bool countrySelected = false;
  bool fathercolorChange = false;
  bool grandfathercolorChange = false;
  bool greatgrandfathercolorChange = false;
  LocalDatabaseHelper localDatabaseHelper = LocalDatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: AllSlidesWidget(
                colors1: ColorManger.logoColor,
                colors3: ColorManger.logoColor.withOpacity(0.5),
                colors2: ColorManger.logoColor.withOpacity(0.5),
              ),
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: BlocConsumer<PersonalDetailsCubit, PersonalDetailsState>(
                  listener: (context, state) {
                    // Handle state changes if necessary
                  },
                  builder: (context, state) {
                    return Form(
                      key: formKey,
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

                          //! FirstNameAndAge

                          FirstNameAndAge(user: user),

                          SizedBox(height: 15.h),

                          //! fathersNameAndStatus

                          fathersNameAndStatus(),

                          SizedBox(height: 15.h),

                          //! grandFatherNameAndStatus

                          grandFatherNameAndStatus(),

                          SizedBox(height: 15.h),

                          //! grandFatherNameAndStatus

                          greatGrandFatherName(),

                          SizedBox(height: 15.h),

                          //! familyName

                          familyName(context),

                          SizedBox(height: 15.h),

                          //! phoneNumber

                          phoneNumber(context),

                          SizedBox(height: 15.h),

                          //! selectedCountry

                          selectedCountry(),

                          SizedBox(height: 15.h),

                          //! SelectedGender

                          SelectedGender(
                            value: user.gender == null
                                ? gender.first
                                : "${user.gender}",
                            onChanged: (gender) {
                              setState(() {
                                user.gender = gender;
                              });
                            },
                          ),

                          //!

                          SizedBox(height: 15.h),

                          //!

                          BottonClick(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            onTap: () {
                              final cubit =
                                  context.read<PersonalDetailsCubit>();

                              // print(cubit.getDataForUser(user));

                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                // if (user.id == null) {
                                cubit
                                    .saveDataForUser(
                                        user, "user", "قيد المراجعه")
                                    .whenComplete(() {
                                  cubit.updateStatistics(user);
                                }).then((value) =>
                                        Navigator.of(context).pushNamed(
                                          ConstantsRouteString.workUserDetails,
                                          // arguments: user.age
                                        ));
                                // } else {
                                //   cubit.updateDataForUser(user).then((value) =>
                                //       Navigator.of(context).pushNamed(
                                //         ConstantsRouteString
                                //             .analiticsOfElerinatScreen,
                                //         // arguments: user.age
                                //       ));
                                // }
                              }
                            },
                            text: MStrings.next,
                          ),

                          //!

                          SizedBox(height: 20.h),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//! selected Contry widget

  SelectedCountry selectedCountry() {
    return SelectedCountry(
      countryText: countrySelected == false
          ? MStrings.selectedCountry
          : "${user.countryName}",
      onSelect: (country) {
        setState(() {
          countrySelected = true;
          user.countryName = country.name;
        });
      },
    );
  }

//! phoneNumber  widget

  CustomTextFormField phoneNumber(BuildContext context) {
    return CustomTextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "حقل مطلوب * ";
        }
        return null;
      },
      onChanged: (phoneNumberByUser) {
        user.phoneNumber = phoneNumberByUser;
      },
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      labelText: Text(MStrings.phoneNumber),
      width: MediaQuery.of(context).size.width,
    );
  }

//! familyName  widget

  CustomTextFormField familyName(BuildContext context) {
    return CustomTextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "حقل مطلوب * ";
        }
        return null;
      },
      onChanged: (familyNameByUser) {
        user.familyName = familyNameByUser;
      },
      keyboardType: TextInputType.name,
      labelText: Text(MStrings.familyName),
      width: MediaQuery.of(context).size.width,
    );
  }

//! greatGrandFatherName  widget

  TextFieldForUserDetatils greatGrandFatherName() {
    return TextFieldForUserDetatils(
      validatorText1: (value) {
        if (value == null || value.isEmpty) {
          return "حقل مطلوب * ";
        }
        return null;
      },
      isTextField: false,
      text1: MStrings.greatgrandfathersName,
      text2: MStrings.greatgrandfathersName,
      color: greatgrandfathercolorChange ? Colors.black : Colors.grey,
      onChangedDropDownValue: (String? value) {
        setState(() {
          greatgrandfathercolorChange = true;
          user.greatGrandFatherLiveOrDead = value!;
        });
      },
      onChangedText1: (greatGrandFatherByUser) {
        user.greatGrandfatherName = greatGrandFatherByUser;
      },
      valueDropDownValue:
          user.greatGrandFatherLiveOrDead ?? liveOrDeadList.first,
    );
  }

//! grandFatherNameAndStatus  widget

  TextFieldForUserDetatils grandFatherNameAndStatus() {
    return TextFieldForUserDetatils(
      validatorText1: (value) {
        if (value == null || value.isEmpty) {
          return "حقل مطلوب * ";
        }
        return null;
      },
      isTextField: false,
      text1: MStrings.grandfatherName,
      text2: MStrings.grandfatherName,
      onChangedText1: (grandfatherByUser) {
        user.grandfatherName = grandfatherByUser;
      },
      color: grandfathercolorChange ? Colors.black : Colors.grey,
      onChangedDropDownValue: (String? value) {
        setState(() {
          grandfathercolorChange = true;
          user.grandfatherLiveORDead = value ?? liveOrDeadList.first;
        });
      },
      valueDropDownValue: user.grandfatherLiveORDead ?? liveOrDeadList.first,
    );
  }

//! fathersNameAndStatus  widget

  TextFieldForUserDetatils fathersNameAndStatus() {
    return TextFieldForUserDetatils(
      //  dropdownValidationError: dropdownValidationError,
      validatorText1: (value) {
        if (value == null || value.isEmpty) {
          return "حقل مطلوب * ";
        }
        return null;
      },
      onChangedDropDownValue: (String? value) {
        setState(() {
          fathercolorChange = true;
          user.fatherLiveORDead = value!;
        });
      },
      valueDropDownValue: user.fatherLiveORDead ?? liveOrDeadList.first,
      color: fathercolorChange ? Colors.black : Colors.grey,
      isTextField: false,
      text1: MStrings.parentname,
      text2: MStrings.parentname,
      onChangedText1: (fatherByUser) {
        user.fatherName = fatherByUser;
      },
    );
  }
}

//! FirstNameAndAge  widget

class FirstNameAndAge extends StatelessWidget {
  const FirstNameAndAge({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return TextFieldForUserDetatils(
      validatorText2: (value) {
        if (value == null || value.isEmpty) {
          return "حقل مطلوب * ";
        }
        return null;
      },
      validatorText1: (value) {
        if (value == null || value.isEmpty) {
          return "حقل مطلوب * ";
        }
        return null;
      },
      isTextField: true,
      text1: MStrings.yourFirstName,
      text2: MStrings.age,
      onChangedText1: (firstNameByUser) {
        user.firstname = firstNameByUser;
      },
      onChangedText3: (ageByUser) {
        user.age = ageByUser;
      },
    );
  }
}
