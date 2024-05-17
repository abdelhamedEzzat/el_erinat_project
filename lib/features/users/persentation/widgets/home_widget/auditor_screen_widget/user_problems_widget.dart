import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/admin_auditor_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProblemsWidget extends StatelessWidget {
  const UserProblemsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.w, left: 20.w, top: 40.h),
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      color: ColorManger.logoColor.withOpacity(0.5),
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
            text: MStrings.problem,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 5.h,
          ),
          AdminAuditorAndVoteText(
            text: MStrings.problemDetails,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 5.h,
          ),
          AdminAuditorAndVoteText(
            text: MStrings.actionNeeded,
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
                "12/12/2022",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                MStrings.problemStatus,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
