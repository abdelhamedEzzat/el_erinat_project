import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/admin/persentation/screens/admin_sub_screen/auditor_admin_tab_bar_view.dart';
import 'package:el_erinat/features/auditor_team/persentation/widgets/auditor_team_tab_bar_view.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/user_auditor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuditorTeamScreen extends StatefulWidget {
  const AuditorTeamScreen({
    super.key,
  });

  @override
  State<AuditorTeamScreen> createState() => _AuditorTeamScreenState();
}

class _AuditorTeamScreenState extends State<AuditorTeamScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final TabController _auditortabController;
  late final TabController _usertabController;

  bool isAdmin = false;
  bool isAuditor = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _auditortabController = TabController(length: 4, vsync: this);
    _usertabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _auditortabController.dispose();
    _usertabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    isAdmin = arguments['isAdmin'];
    isAuditor = arguments['isAuditor'];

    return BackGroundAndAppBarAndDaynamicBody(
      appBarbottom: isAdmin == true
          ? adminTabBar()
          : isAuditor == true
              ? auditorTabBar()
              : userTabBar(),
      alignmentTitle: Alignment.center,
      titleName: MStrings.auditorTeam,
      yourBodyOfScreen: isAdmin == true
          ? AdminAuditorTabBarView(tabController: _tabController)
          : isAuditor == true
              ? AuditorTabBarView(auditortabController: _auditortabController)
              : UserAuditorScreen(
                  tabController: _usertabController,
                ),
    );
  }

  TabBar auditorTabBar() {
    return TabBar(
      indicatorColor: Colors.white,
      unselectedLabelColor: Colors.white,
      labelColor: ColorManger.balckColor,
      controller: _auditortabController,
      tabs: <Widget>[
        Tab(
          child: Text(MStrings.problems,
              style: TextStyle(fontSize: 10.h, fontWeight: FontWeight.bold)),
        ),
        Tab(
          child: Text(MStrings.auditorSuggetions,
              style: TextStyle(fontSize: 10.h, fontWeight: FontWeight.bold)),
        ),
        Tab(
          child: Text(MStrings.auditorUsers,
              style: TextStyle(fontSize: 10.h, fontWeight: FontWeight.bold)),
        ),
        Tab(
          child: Text(MStrings.auditorUsers,
              style: TextStyle(fontSize: 10.h, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  TabBar adminTabBar() {
    return TabBar(
      indicatorColor: Colors.white,
      indicatorPadding: EdgeInsets.only(bottom: 3.h),
      unselectedLabelColor: ColorManger.white,
      labelColor: ColorManger.white,
      controller: _tabController,
      tabs: <Widget>[
        Tab(
          child: Text(MStrings.problems,
              style: TextStyle(fontSize: 12.h, fontWeight: FontWeight.bold)),
        ),
        Tab(
          child: Text(MStrings.auditorSuggetions,
              style: TextStyle(fontSize: 12.h, fontWeight: FontWeight.bold)),
        ),
        Tab(
          child: Text(MStrings.auditorUsers,
              style: TextStyle(fontSize: 12.h, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  TabBar userTabBar() {
    return TabBar(
      indicatorColor: Colors.white,
      indicatorPadding: EdgeInsets.only(bottom: 3.h),
      unselectedLabelColor: ColorManger.white,
      labelColor: ColorManger.white,
      controller: _usertabController,
      tabs: <Widget>[
        Tab(
          child: Text(MStrings.giveProblems,
              style: TextStyle(fontSize: 12.h, fontWeight: FontWeight.bold)),
        ),
        Tab(
          child: Text(MStrings.meProblems,
              style: TextStyle(fontSize: 12.h, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
