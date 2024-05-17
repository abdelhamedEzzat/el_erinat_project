import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/admin/persentation/widget/suggetion_admin_widget/choose_suggetuions_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/admin_auditor_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminSuggetionItem extends StatelessWidget {
  const AdminSuggetionItem({
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
            text: MStrings.addressSuggetions,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 5.h,
          ),
          AdminAuditorAndVoteText(
            text: MStrings.detailsSuggestion,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 5.h,
          ),
          AdminAuditorAndVoteText(
            text: MStrings.sugetionChosses,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 5.h,
          ),
          ChoosesSuggetions(
            text: "اوافق",
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 2.h,
          ),
          ChoosesSuggetions(
            text: "لا اوافق",
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.black,
                child: Text(
                  MStrings.rajected,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(8.0),
                color: ColorManger.logoColor,
                child: Text(
                  MStrings.accepted,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
