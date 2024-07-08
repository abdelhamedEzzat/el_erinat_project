// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/features/users/data/model/user_problems_model.dart';
import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/admin_auditor_text_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/problem_nasted_tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';

class UserAuditorScreen extends StatelessWidget {
  const UserAuditorScreen({
    Key? key,
    required this.tabController,
  }) : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    UserRepoImplementation userRepoImplementation = UserRepoImplementation(
        localDatabaseHelper: LocalDatabaseHelper(),
        userRemoteDataSource: UserRemoteDataSource());
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: tabController,
      children: <Widget>[
        const ProblemsFromUsers(),
        GetProblemOfUser(
          future: userRepoImplementation
              .getProblemsOfUser(FirebaseAuth.instance.currentUser!.uid),
        )
      ],
    );
  }
}

class GetProblemOfUser extends StatelessWidget {
  const GetProblemOfUser({super.key, required this.future});
  final Future<List<UserProblemsModel>>? future;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<UserProblemsModel>>(
        future: future,
        builder: (BuildContext context,
            AsyncSnapshot<List<UserProblemsModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                UserProblemsModel userProblemsModel = snapshot.data![index];

                return Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.w),
                      margin: EdgeInsets.only(right: 20.w, left: 20.w),
                      color: ColorManger.logoColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AdminAuditorAndVoteText(
                            text: userProblemsModel.problemTitle ?? 'No Title',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 5.h),
                          AdminAuditorAndVoteText(
                            text: userProblemsModel.problemDescription ??
                                'No Description',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 5.h),
                          AdminAuditorAndVoteText(
                            text: userProblemsModel.actionNeded ??
                                'No Action Needed',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                userProblemsModel.createdAt ?? 'No Date',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                              ),
                              Text(
                                userProblemsModel.statusOfProblem ??
                                    'No Status',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                );
              },
            );
          } else {
            return Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}

class ProblemsFromUsers extends StatefulWidget {
  const ProblemsFromUsers({
    super.key,
  });

  @override
  State<ProblemsFromUsers> createState() => _ProblemsFromUsersState();
}

class _ProblemsFromUsersState extends State<ProblemsFromUsers> {
  UserRepoImplementation userRepoImplementation = UserRepoImplementation(
      localDatabaseHelper: LocalDatabaseHelper(),
      userRemoteDataSource: UserRemoteDataSource());

  UserProblemsModel userProblemsModel = UserProblemsModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 200, //
          padding: EdgeInsets.all(20.w), margin: EdgeInsets.only(top: 20.h),
          child: Column(
            children: [
              CustomTextFormField(
                onChanged: (problem) {
                  setState(() {
                    userProblemsModel.problemTitle = problem;
                  });
                },
                hintText: MStrings.problem,
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextFormField(
                onChanged: (problemDescription) {
                  setState(() {
                    userProblemsModel.problemDescription = problemDescription;
                  });
                },
                hintText: MStrings.problemDetails,
                minLines: 5,
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextFormField(
                onChanged: (actionNeded) {
                  setState(() {
                    userProblemsModel.actionNeded = actionNeded;
                  });
                },
                hintText: MStrings.actionNeeded,
              ),
              SizedBox(
                height: 25.h,
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.bottomCenter,
                child: BottonClick(
                  alignment: Alignment.center,
                  onTap: () async {
                    userProblemsModel.statusOfProblem = "قيد المراجعه";

                    await userRepoImplementation
                        .uploadAndSaveProblemOfUser(
                            userProblemsModel: userProblemsModel)
                        .whenComplete(
                      () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("(قيد المراجعه)تم ارسال المشكلة بنجاح"),
                          duration: Duration(seconds: 5),
                        ));
                      },
                    ).whenComplete(
                      () => Navigator.of(context).pop(),
                    );
                  },
                  width: MediaQuery.of(context).size.width,
                  text: MStrings.submit,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
