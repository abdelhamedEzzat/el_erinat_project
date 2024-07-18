import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/data/model/upload_image.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/work_personal_details_cubit/work_personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/Subtitle_In_user_details_screen.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/add_identity_pic.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/all_slides_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/title_in_user_details_screen.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/user_phone_to_get_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetailsIdentaty extends StatefulWidget {
  const UserDetailsIdentaty({super.key});

  @override
  State<UserDetailsIdentaty> createState() => _UserDetailsIdentatyState();
}

List<String> radioOptions = [MStrings.pic, MStrings.customerServicesCall];

class _UserDetailsIdentatyState extends State<UserDetailsIdentaty> {
  String currentOption = radioOptions[0];
  String currentSelected = "0";
  bool isZeroradioOptions = false;
  bool isOneradioOptions = false;
  UploadImage uploadImage = UploadImage();
  GetCallModel getCall = GetCallModel();
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
                    colors2: ColorManger.logoColor.withOpacity(0.5),
                    colors3: ColorManger.logoColor,
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
                  //!  Title

                  TitleInUserDetailsScreen(
                    text: MStrings.thanksUserForWork,
                    titleColor: ColorManger.logoColor,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  //!  subTitle

                  SubTitleInUserDetailsScreen(
                    text: MStrings.confirmYourWay,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SubTitleInUserDetailsScreen(
                    text: MStrings.toBelongingToTheTribe,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  //!  selected UploadPic

                  RadioListTile(
                      title: Text(MStrings.pic),
                      value: radioOptions[0],
                      groupValue:
                          isZeroradioOptions == true ? currentOption : null,
                      onChanged: (value) {
                        setState(() {
                          currentOption = value.toString();
                          isZeroradioOptions = true;
                          isOneradioOptions = false;
                          // BlocProvider.of<WorkPersonalDetailsCubit>(context)
                          //     .fetchImage(uploadImage.uID.toString());
                        });
                      }),

                  //!  AddIdentityPic

                  isZeroradioOptions == true
                      ? AddIdentityPic(
                          uploadImage: uploadImage,
                        )
                      : Container(),

                  RadioListTile(
                      title: Text(MStrings.customerServicesCall),
                      value: radioOptions[1],
                      groupValue: currentOption == radioOptions[1]
                          ? currentOption
                          : currentSelected,
                      onChanged: (value) {
                        setState(() {
                          currentOption = value.toString();
                          isZeroradioOptions = false;
                          isOneradioOptions = true;
                        });
                      }),

                  SizedBox(
                    height: 10.h,
                  ),
                  isOneradioOptions == true
                      ? const UserPhontToGetCall()
                      : Container(),

                  SizedBox(
                    height: 10.h,
                  ),

                  //! button to navigator to home screen

                  Expanded(
                      child: Container(
                    alignment: Alignment.bottomCenter,
                    child: BottonClick(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        onTap: () {
                          if (isZeroradioOptions == true &&
                              isOneradioOptions == false) {
                            BlocProvider.of<WorkPersonalDetailsCubit>(context)
                                .uploadImageDataForUser(
                                    uploadImage, uploadImage.imagePath!);
                          } else if (isOneradioOptions == true &&
                              isZeroradioOptions == false) {
                            BlocProvider.of<WorkPersonalDetailsCubit>(context)
                                .uploadCallDataForUSER(
                                    getCall, "المستخدم طلب مكالمه هاتفية");
                          }
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            ConstantsRouteString.homeScreen,
                            (route) => false,
                          );
                        },
                        text: MStrings.submit),
                  )),
                  SizedBox(
                    height: 20.h,
                  ),
                ])),
      ),
    );
  }
}
