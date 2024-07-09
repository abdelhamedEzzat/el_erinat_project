import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/user_problems_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProblemNastedTabBar extends StatefulWidget {
  const ProblemNastedTabBar(this.outerTab, {super.key});

  final String outerTab;

  @override
  State<ProblemNastedTabBar> createState() => _ProblemNastedTabBarState();
}

class _ProblemNastedTabBarState extends State<ProblemNastedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: ColorManger.subScreenscontainerColor,
          unselectedLabelColor: ColorManger.subScreenscontainerColor,
          labelColor: ColorManger.subScreenscontainerColor,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              child: Text(MStrings.underReview,
                  style:
                      TextStyle(fontSize: 12.h, fontWeight: FontWeight.bold)),
            ),
            Tab(
              child: Text(MStrings.itHasBeenCompleted,
                  style:
                      TextStyle(fontSize: 12.h, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              const SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      UserProblemsWidget(),
                    ],
                  ),
                ),
              ),
              Container(),
            ],
          ),
        ),
      ],
    );
  }
}
