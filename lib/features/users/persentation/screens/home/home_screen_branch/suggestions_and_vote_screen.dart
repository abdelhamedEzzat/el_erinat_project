import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/suggestions_and_vote/buttom_suggetion_text.dart';
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
