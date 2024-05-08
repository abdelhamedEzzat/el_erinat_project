import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/suggestions_and_vote/vote_screen/animated_vote_container.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/suggestions_and_vote/vote_screen/vote_number_and_date.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/suggestions_and_vote/vote_screen/vote_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoteScreen extends StatelessWidget {
  const VoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBarAndDaynamicBody(
      alignmentTitle: Alignment.center,
      titleName: MStrings.voteChoise,
      yourBodyOfScreen: Positioned.fill(
        top: 120.h,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: ColorManger.logoColor.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(8.h)),
                  ),
                  padding: EdgeInsets.all(25.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const VoteTitle(),
                      SizedBox(
                        height: 15.h,
                      ),
                      const AnimatedVoteContainer(),
                      SizedBox(
                        height: 15.h,
                      ),
                      const AnimatedVoteContainer(
                        textOfVote: "رفض",
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const VoteNumberAndDate(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
