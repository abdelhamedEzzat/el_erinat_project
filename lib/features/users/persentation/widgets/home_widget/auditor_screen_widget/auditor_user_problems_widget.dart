import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/users/data/model/user_problems_model.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/problems_cubit/problems_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/admin_auditor_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProblemsWidget extends StatefulWidget {
  const UserProblemsWidget({
    super.key,
  });

  @override
  State<UserProblemsWidget> createState() => _UserProblemsWidgetState();
}

class _UserProblemsWidgetState extends State<UserProblemsWidget> {
  @override
  void initState() {
    BlocProvider.of<ProblemsCubit>(context).getWattingproblemsForAuditors();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProblemsCubit, ProblemsState>(
        listener: (context, state) {
      if (state is UploadProblemsSuccess) {
        BlocProvider.of<ProblemsCubit>(context)
            .addSuggetionItem(state.userProblemsModel);
      } else if (state is UpdateProblemsSuccess) {
        BlocProvider.of<ProblemsCubit>(context).getWattingproblemsForAuditors();
      }
    }, builder: (context, state) {
      if (state is GetProblemsLoading || state is UpdateProblemsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is GetProblemsSuccess) {
        return SingleChildScrollView(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.news.length,
              itemBuilder: (BuildContext context, int index) {
                UserProblemsModel userProblemsModel = state.news[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: 20.w,
                        left: 20.w,
                      ),
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      color: ColorManger.subScreenscontainerColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // AdminAuditorAndVoteText(
                          //   text: "احمد محمد ابراهيم العرجاني",
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .bodySmall!
                          //       .copyWith(color: Colors.white),
                          // ),
                          SizedBox(
                            height: 5.h,
                          ),
                          AdminAuditorAndVoteText(
                            text: userProblemsModel.problemTitle.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          AdminAuditorAndVoteText(
                            text:
                                userProblemsModel.problemDescription.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          AdminAuditorAndVoteText(
                            text: userProblemsModel.actionNeded.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                userProblemsModel.createdAt.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                              ),
                              Text(
                                userProblemsModel.statusOfProblem.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              String acceptedStatus = "تم حل الشكوي بنجاح";
                              await BlocProvider.of<ProblemsCubit>(context)
                                  .updateProblemsStatus(
                                      userProblemsModel.id!, acceptedStatus);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: Text(
                                MStrings.finishedProblems,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: ColorManger.logoColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                );
              }),
        );
      } else {
        return Container(
          padding: EdgeInsets.only(bottom: 200.h),
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Text(
              textAlign: TextAlign.end,
              " لا يوجد اي شكاوي الي الان ",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: ColorManger.subScreenscontainerColor),
            ),
          ),
        );
      }
    });
  }
}
