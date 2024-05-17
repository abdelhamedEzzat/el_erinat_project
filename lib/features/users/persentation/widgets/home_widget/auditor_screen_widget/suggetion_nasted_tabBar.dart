import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/admin/persentation/widget/suggetion_admin_widget/admin_suggetion_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggetionNastedTabBar extends StatefulWidget {
  const SuggetionNastedTabBar(
    this.outerTab, {
    super.key,
  });
  final String outerTab;
  @override
  State<SuggetionNastedTabBar> createState() => _SuggetionNastedTabBarState();
}

class _SuggetionNastedTabBarState extends State<SuggetionNastedTabBar>
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
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.white,
          labelColor: ColorManger.logoColor,
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
                      AdminSuggetionItem(),
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
