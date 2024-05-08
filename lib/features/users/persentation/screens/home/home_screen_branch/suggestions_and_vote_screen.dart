import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestionsandVoteScreen extends StatelessWidget {
  const SuggestionsandVoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBarAndDaynamicBody(
        alignmentTitle: Alignment.center,
        titleName: MStrings.suggestions,
        yourBodyOfScreen: Positioned.fill(
          top: 120.h,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 130, //
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  BottonSuggetionText(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ConstantsRouteString.suggetionScreen);
                    },
                    chooseText: MStrings.suggestionChoise,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  BottonSuggetionText(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ConstantsRouteString.voteScreen);
                    },
                    chooseText: MStrings.voteChoise,
                  ),
                  SizedBox(
                    height: 130.h,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class BottonSuggetionText extends StatelessWidget {
  const BottonSuggetionText({
    super.key,
    required this.chooseText,
    this.onTap,
  });
  final String chooseText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200.w,
        height: 130.h,
        decoration: BoxDecoration(
          color: ColorManger.logoColor.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(8.h)),
        ),
        padding: EdgeInsets.all(25.h),
        child: Center(
          child: Text(
            chooseText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontSize: 18.h,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}




// Positioned.fill(
//           top: 120.h,
//           child: SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.all(20.w),
//               child: Column(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       color: ColorManger.logoColor.withOpacity(0.5),
//                       borderRadius: BorderRadius.all(Radius.circular(8.h)),
//                     ),
//                     padding: EdgeInsets.all(25.h),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         const VoteTitle(),
//                         SizedBox(
//                           height: 15.h,
//                         ),
//                         const AnimatedVoteContainer(),
//                         SizedBox(
//                           height: 15.h,
//                         ),
//                         const AnimatedVoteContainer(
//                           textOfVote: "رفض",
//                         ),
//                         SizedBox(
//                           height: 15.h,
//                         ),
//                         const VoteNumberAndDate(),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         )