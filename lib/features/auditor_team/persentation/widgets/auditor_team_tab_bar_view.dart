import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/auditor_team/persentation/widgets/auditor_accepted_or_rejected_users_nasted_tabbar.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/auditor_user_nasted_tab_bar.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/problem_nasted_tabbar.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/suggetion_nasted_tabBar.dart';
import 'package:flutter/material.dart';

class AuditorTabBarView extends StatelessWidget {
  const AuditorTabBarView({
    super.key,
    required TabController auditortabController,
  }) : _auditortabController = auditortabController;

  final TabController _auditortabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _auditortabController,
      children: <Widget>[
        // Column(
        //   children: [

        SafeArea(
          child: ProblemNastedTabBar(
            MStrings.analiticsPeople,
          ),
        ),
        //     // PeopleAnaliticsBody(),

        SafeArea(
          child: SuggetionNastedTabBar(
            MStrings.auditorSuggetions,
          ),
        ),

        SafeArea(
          child: AuditorAcceptedOrRejectedUsersNastedTabBar(
            MStrings.auditorUsers,
          ),
        ),
        // SafeArea(
        //   child: AuditorUsersNastedTabBar(
        //     MStrings.auditorUsers,
        //   ),
        // ),
      ],
    );
  }
}
