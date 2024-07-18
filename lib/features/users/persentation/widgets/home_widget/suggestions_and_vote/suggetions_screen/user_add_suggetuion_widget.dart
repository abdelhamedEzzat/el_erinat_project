import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/core/helpers/show_my_dialog.dart';
import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/suggetions_and_vote/suggtions_and_vote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UserAddSuggetionScreen extends StatefulWidget {
  const UserAddSuggetionScreen({super.key});

  @override
  State<UserAddSuggetionScreen> createState() => _UserAddSuggetionScreenState();
}

class _UserAddSuggetionScreenState extends State<UserAddSuggetionScreen> {
  UserRepoImplementation userRepoImplementation = UserRepoImplementation(
      localDatabaseHelper: LocalDatabaseHelper(),
      userRemoteDataSource: UserRemoteDataSource());

  SuggetionModel suggetionModel = SuggetionModel();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
      child: Form(
        key: formKey,
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "حقل مطلوب *";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "حقل مطلوب *";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "حقل مطلوب *";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "حقل مطلوب *";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "حقل مطلوب *";
                    }
                    return null;
                  },
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
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await BlocProvider.of<SuggtionsAndVoteCubit>(context)
                            .uploadSuggetions(
                                suggtions: suggetionModel, role: "user")
                            .whenComplete(() => setState(() {
                                  isLoading = false;
                                  showMyDialog(context);
                                }));
                      }
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
    );
  }
}
