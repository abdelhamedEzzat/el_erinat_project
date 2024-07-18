import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/admin/persentation/widget/suggetion_admin_widget/choose_suggetuions_widget.dart';
import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/suggetions_and_vote/suggtions_and_vote_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/admin_auditor_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetFinishedSuggetionsToAuditor extends StatefulWidget {
  const GetFinishedSuggetionsToAuditor({super.key});

  @override
  State<GetFinishedSuggetionsToAuditor> createState() =>
      _GetFinishedSuggetionsToAuditorState();
}

class _GetFinishedSuggetionsToAuditorState
    extends State<GetFinishedSuggetionsToAuditor> {
  @override
  void initState() {
    BlocProvider.of<SuggtionsAndVoteCubit>(context).getFinishedSuggetions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuggtionsAndVoteCubit, SuggtionsAndVoteState>(
      listener: (context, state) {
        if (state is UpdateSuggestionSuccess) {
          BlocProvider.of<SuggtionsAndVoteCubit>(context)
              .getFinishedSuggetions();
        } else if (state is UpdateSuggestionLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UpdateSuggestionError) {
          print(Text(" UpdateSuggestionError      ${state.failure}"));
        } else if (state is GetFinishedSuggestionError) {
          print(Text(" GetFinishedSuggestionError      ${state.failure}"));
        }
      },
      builder: (context, state) {
        if (state is GetFinishedSuggestionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetFinishedSuggestionSuccess) {
          return SingleChildScrollView(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.suggetion.length,
              itemBuilder: (BuildContext context, int index) {
                SuggetionModel suggetionModel = state.suggetion[index];
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          right: 20.w, left: 20.w, top: 10.h, bottom: 10.h),
                      padding: EdgeInsets.only(
                          left: 15.h, right: 15.h, bottom: 15.h),
                      width: MediaQuery.of(context).size.width,
                      color: ColorManger.subScreenscontainerColor,
                      child: Column(
                        children: [
                          SizedBox(height: 15.h),
                          Container(
                            margin: EdgeInsets.only(
                              right: 20.w,
                              left: 20.w,
                            ),
                            color: ColorManger.logoColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                AdminAuditorAndVoteText(
                                  text:
                                      suggetionModel.suggetionTitle.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(height: 5.h),
                                AdminAuditorAndVoteText(
                                  text: suggetionModel.suggetionDescription
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(height: 5.h),
                                AdminAuditorAndVoteText(
                                  text: MStrings.sugetionChosses,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(height: 5.h),
                                ChoosesSuggetions(
                                  text: suggetionModel.firstChoise.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(height: 2.h),
                                ChoosesSuggetions(
                                  text: suggetionModel.secoundChoise.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(height: 10.h),
                                if (suggetionModel.thirdChoise != null)
                                  ChoosesSuggetions(
                                    text: suggetionModel.thirdChoise.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: Colors.white),
                                  )
                                else
                                  Container(),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 10.h,
                                        bottom: 10.h,
                                        right: 30.w,
                                      ),
                                      child: Text(
                                        suggetionModel.createdAt.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      width: 110.w,
                                      padding: EdgeInsets.only(
                                        top: 10.h,
                                        bottom: 10.h,
                                        left: 30.w,
                                      ),
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: true,
                                        suggetionModel.statusOfProblem
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    )
                  ],
                );
              },
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  " لا يوجد اقتراحات الي الان ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: ColorManger.subScreenscontainerColor),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
