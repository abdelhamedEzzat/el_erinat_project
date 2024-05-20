import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/navigate_to_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenItem extends StatelessWidget {
  const HomeScreenItem({
    super.key,
    required this.index,
    this.onTap,
    required this.isAdmin,
    required this.isAuditor,
  });
  final bool isAdmin;
  final bool isAuditor;
  final int index;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    List<String> itemsList = [
      MStrings.bookOfElerinat,
      MStrings.treeOfElerinat,
      MStrings.analiticsOfElerinat,
      MStrings.newsOfElerinat,
      MStrings.auditorTeam,
      MStrings.suggestions,
    ];

    List<IconData> itemsicons = [
      Icons.book,
      Icons.people,
      Icons.analytics,
      Icons.newspaper,
      Icons.support_agent,
      Icons.settings_suggest,
    ];
    return GestureDetector(
      onTap: () => isAuditor == true
          ? navigateToScreen(context, index, false, true)
          : isAdmin == true
              ? navigateToScreen(context, index, true, false)
              : navigateToScreen(context, index, false, false),
      child: Container(
        decoration: BoxDecoration(
            color: ColorManger.mainScreencontainerColor,
            borderRadius: BorderRadius.all(Radius.circular(15.w))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                itemsicons[index],
                size: 30.h,
                color: Colors.white,
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                itemsList[index],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 10.h,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
