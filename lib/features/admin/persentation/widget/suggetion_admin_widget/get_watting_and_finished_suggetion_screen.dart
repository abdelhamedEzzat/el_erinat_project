import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/admin/persentation/widget/suggetion_admin_widget/choose_suggetuions_widget.dart';
import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/admin_auditor_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetWattingAndFinishedSuggetionsApp extends StatelessWidget {
  const GetWattingAndFinishedSuggetionsApp(
      {super.key, this.future, required this.isWaiting});
  final Future<List<SuggetionModel>>? future;
  final bool isWaiting;

  @override
  Widget build(BuildContext context) {
    UserRepoImplementation userRepoImplementation = UserRepoImplementation(
        localDatabaseHelper: LocalDatabaseHelper(),
        userRemoteDataSource: UserRemoteDataSource());
    return FutureBuilder<List<SuggetionModel>>(
      future: future,
      builder:
          (BuildContext context, AsyncSnapshot<List<SuggetionModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              SuggetionModel suggetionModel = snapshot.data![index];
              return Container(
                margin: EdgeInsets.only(
                  right: 20.w,
                  left: 20.w,
                  top: 20.h,
                ),
                padding: EdgeInsets.only(left: 15.h, right: 15.h, bottom: 15.h),
                width: MediaQuery.of(context).size.width,
                color: ColorManger.subScreenscontainerColor,
                //height: 200.h,
                child: Column(
                  children: [
                    SizedBox(height: 15.h),
                    Container(
                      margin: EdgeInsets.only(right: 20.w, left: 20.w),
                      color: ColorManger.logoColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AdminAuditorAndVoteText(
                            text: suggetionModel.suggetionTitle.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 5.h),
                          AdminAuditorAndVoteText(
                            text:
                                suggetionModel.suggetionDescription.toString(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              isWaiting == true
                                  ? GestureDetector(
                                      onTap: () async {
                                        String finishedStatus = "تم رفضها";
                                        await userRepoImplementation
                                            .updateFinishedSuggetionsToAuditor(
                                                suggetionModel.id!,
                                                finishedStatus);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        color: Colors.black,
                                        child: Text(
                                          MStrings.rajected,
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
                                    )
                                  : Text(
                                      suggetionModel.statusOfProblem.toString(),
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

                                        await userRepoImplementation
                                            .updateFinishedSuggetionsToAuditor(
                                                suggetionModel.id!,
                                                acceptedStatus);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
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
                                                fontWeight: FontWeight.bold,
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
              );
            },
          );
        } else {
          return Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height - 180.h,
            child: const Text(
              "No data available",
              textAlign: TextAlign.center,
            ),
          );
        }
      },
    );
  }
}
