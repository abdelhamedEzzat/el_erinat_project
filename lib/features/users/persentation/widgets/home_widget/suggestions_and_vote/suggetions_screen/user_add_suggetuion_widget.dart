import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/core/helpers/show_my_dialog.dart';
import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
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
              onTap: () async {
                await userRepoImplementation
                    .uploadSuggetionsOfUser(suggetionModel: suggetionModel)
                    .whenComplete(() => setState(() {
                          showMyDialog(context);
                        }));
              },
              text: MStrings.submit),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}
