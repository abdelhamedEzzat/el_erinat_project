// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/features/users/data/model/user_problems_model.dart';
import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/problems_cubit/problems_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/admin_auditor_text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UserAuditorScreen extends StatelessWidget {
  const UserAuditorScreen({
    super.key,
    required this.tabController,
  });
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
            // future: userRepoImplementation
            //     .getProblemsOfUser(FirebaseAuth.instance.currentUser!.uid),
            )
      ],
    );
  }
}

class GetProblemOfUser extends StatefulWidget {
  const GetProblemOfUser({
    super.key,
  });

  @override
  State<GetProblemOfUser> createState() => _GetProblemOfUserState();
}

class _GetProblemOfUserState extends State<GetProblemOfUser> {
  UserProblemsModel userProblemsModel = UserProblemsModel();
  @override
  void initState() {
    BlocProvider.of<ProblemsCubit>(context).getAllProblemsForUserByUID();
    // TODO: implement initState
    super.initState();
  }

//  final Future<List<UserProblemsModel>>? future;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<ProblemsCubit, ProblemsState>(
      builder: (context, state) {
        if (state is GetProblemsUserLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorManger.logoColor,
            ),
          );
        } else if (
            // state is GetProblemsUserSuccess ||
            state is GetProblemsUserSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.news.length,
            itemBuilder: (BuildContext context, int index) {
              UserProblemsModel userProblemsModel = state.news[index];

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
                              userProblemsModel.statusOfProblem ?? 'No Status',
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
    )
        //  FutureBuilder<List<UserProblemsModel>>(
        //   future: future,
        //   builder: (BuildContext context,
        //       AsyncSnapshot<List<UserProblemsModel>> snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     } else if (snapshot.hasError) {
        //       return Center(child: Text(snapshot.error.toString()));
        //     } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        //       return
        //}

        //   },
        // ),
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserProblemsModel userProblemsModel = UserProblemsModel();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 200, //
            padding: EdgeInsets.all(20.w), margin: EdgeInsets.only(top: 20.h),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "حقل مطلوب *";
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "حقل مطلوب *";
                      }
                      return null;
                    },
                    onChanged: (problemDescription) {
                      setState(() {
                        userProblemsModel.problemDescription =
                            problemDescription;
                      });
                    },
                    hintText: MStrings.problemDetails,
                    minLines: 5,
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
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          formKey.currentState!.save();
                          userProblemsModel.statusOfProblem = "قيد المراجعه";

                          await BlocProvider.of<ProblemsCubit>(context)
                              .uploadproblems(problems: userProblemsModel)
                              .whenComplete(
                            () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "(قيد المراجعه)تم ارسال المشكلة بنجاح"),
                                duration: Duration(seconds: 5),
                              ));
                            },
                          ).whenComplete(() {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      width: MediaQuery.of(context).size.width,
                      text: MStrings.submit,
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
