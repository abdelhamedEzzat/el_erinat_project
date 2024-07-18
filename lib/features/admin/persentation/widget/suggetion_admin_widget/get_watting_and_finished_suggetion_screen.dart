import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/admin/persentation/widget/suggetion_admin_widget/choose_suggetuions_widget.dart';
import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/suggetions_and_vote/suggtions_and_vote_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/admin_auditor_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetWattingAndFinishedSuggetionsApp extends StatelessWidget {
  const GetWattingAndFinishedSuggetionsApp(
      {super.key, required this.isWaiting});
  // final Future<List<SuggetionModel>>? future;
  final bool isWaiting;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuggtionsAndVoteCubit, SuggtionsAndVoteState>(
      listener: (context, state) {
        if (state is UploadSuggestionSuccess) {
          BlocProvider.of<SuggtionsAndVoteCubit>(context).getSuggetions();
        } else if (state is UpdateSuggestionSuccess) {
          BlocProvider.of<SuggtionsAndVoteCubit>(context).getSuggetions();
        }
      },
      builder: (context, state) {
        if (state is GetSuggestionLoading || state is UpdateSuggestionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetSuggestionSuccess) {
          return SingleChildScrollView(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.news.length,
              itemBuilder: (BuildContext context, int index) {
                SuggetionModel suggetionModel = state.news[index];
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
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    isWaiting == true
                                        ? GestureDetector(
                                            onTap: () async {
                                              String finishedStatus =
                                                  "تم رفضها";

                                              await BlocProvider.of<
                                                          SuggtionsAndVoteCubit>(
                                                      context)
                                                  .updateSuggtions(
                                                      suggetionModel.id!,
                                                      finishedStatus);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 10.h,
                                                  bottom: 10.h,
                                                  right: 30.w,
                                                  left: 30.w),
                                              color: Colors.black,
                                              child: Text(
                                                MStrings.rajected,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            suggetionModel.statusOfProblem
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            textAlign: TextAlign.center,
                                          ),
                                    SizedBox(width: 10.w),
                                    isWaiting == true
                                        ? GestureDetector(
                                            onTap: () async {
                                              String acceptedStatus =
                                                  "تم الموافقه علي الاقتراح";
                                              await BlocProvider.of<
                                                          SuggtionsAndVoteCubit>(
                                                      context)
                                                  .updateSuggtions(
                                                      suggetionModel.id!,
                                                      acceptedStatus);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 10.h,
                                                  bottom: 10.h,
                                                  right: 25.w,
                                                  left: 25.w),
                                              color: ColorManger.white,
                                              child: Text(
                                                MStrings.accepted,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                      color: ColorManger
                                                          .subScreenscontainerColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          )
                                        : Text(
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
