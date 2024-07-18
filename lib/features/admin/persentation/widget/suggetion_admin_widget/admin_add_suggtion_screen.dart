import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/core/helpers/show_my_dialog.dart';
import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/suggetions_and_vote/suggtions_and_vote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminAddSuggetionsScreen extends StatefulWidget {
  const AdminAddSuggetionsScreen({super.key});

  @override
  State<AdminAddSuggetionsScreen> createState() =>
      _AdminAddSuggetionsScreenState();
}

class _AdminAddSuggetionsScreenState extends State<AdminAddSuggetionsScreen> {
  SuggetionModel suggetionModel = SuggetionModel();
  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBarAndDaynamicBody(
      alignmentTitle: Alignment.center,
      titleName: MStrings.suggestions,
      yourBodyOfScreen: Positioned.fill(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                    onChanged: (suggetion) {
                      setState(() {
                        suggetionModel.suggetionTitle = suggetion;
                      });
                    },
                    hintText: MStrings.addressSuggetions,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextFormField(
                    onChanged: (suggetionDetails) {
                      setState(() {
                        suggetionModel.suggetionDescription = suggetionDetails;
                      });
                    },
                    hintText: MStrings.detailsSuggestion,
                    minLines: 4,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextFormField(
                    onChanged: (firstChoise) {
                      setState(() {
                        suggetionModel.firstChoise = firstChoise;
                      });
                    },
                    hintText: MStrings.acceptedSuggetion,
                    minLines: 1,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextFormField(
                    onChanged: (secoundChoise) {
                      setState(() {
                        suggetionModel.secoundChoise = secoundChoise;
                      });
                    },
                    hintText: MStrings.notAcceptedSuggetion,
                    minLines: 1,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextFormField(
                    onChanged: (thirdChoise) {
                      setState(() {
                        suggetionModel.thirdChoise = thirdChoise;
                      });
                    },
                    hintText: MStrings.additionchooseSuggetion,
                    minLines: 1,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  BottonClick(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      onTap: () {
                        suggetionModel.role = 'admin';
                        BlocProvider.of<SuggtionsAndVoteCubit>(context)
                            .uploadSuggetions(
                                suggtions: suggetionModel, role: "admin");
                        setState(() {
                          //  showMyDialog(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                                  content: Text(
                                    MStrings.aleartlistBodyInSuggetions,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white),
                                    textAlign: TextAlign.end,
                                  ),
                                  duration: const Duration(
                                    seconds: 2,
                                  )))
                              .closed;
                          Navigator.of(context).pop("Success upload suggetion");
                        });
                      },
                      text: MStrings.submit),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
