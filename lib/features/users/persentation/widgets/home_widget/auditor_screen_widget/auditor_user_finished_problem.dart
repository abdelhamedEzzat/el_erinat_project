import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/features/users/data/model/user_problems_model.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/problems_cubit/problems_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/admin_auditor_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserFinishedProblemsWidget extends StatefulWidget {
  const UserFinishedProblemsWidget({
    super.key,
  });

  @override
  State<UserFinishedProblemsWidget> createState() =>
      _UserFinishedProblemsWidgetState();
}

class _UserFinishedProblemsWidgetState
    extends State<UserFinishedProblemsWidget> {
  @override
  void initState() {
    BlocProvider.of<ProblemsCubit>(context).getFinishedProblemForAuditor();
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
        BlocProvider.of<ProblemsCubit>(context).getFinishedProblemForAuditor();
      }
    }, builder: (context, state) {
      if (state is GetFinishedProblemsLoading ||
          state is UpdateProblemsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is GetFinishedProblemsSuccess) {
        return SingleChildScrollView(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.suggetion.length,
              itemBuilder: (BuildContext context, int index) {
                UserProblemsModel userProblemsModel = state.suggetion[index];
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          right: 20.w, left: 20.w, top: 20.h, bottom: 20.h),
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      color: ColorManger.subScreenscontainerColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AdminAuditorAndVoteText(
                            text: "احمد محمد ابراهيم العرجاني",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          ),
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
                            height: 10.h,
                          ),
                        ],
                      ),
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
