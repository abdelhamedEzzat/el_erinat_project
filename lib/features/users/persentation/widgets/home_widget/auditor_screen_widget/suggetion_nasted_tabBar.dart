import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/admin/persentation/widget/suggetion_admin_widget/admin_suggetion_items.dart';
import 'package:el_erinat/features/admin/persentation/widget/suggetion_admin_widget/get_watting_and_finished_suggetion_screen.dart';
import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  UserRepoImplementation userRepoImplementation = UserRepoImplementation(
      localDatabaseHelper: LocalDatabaseHelper(),
      userRemoteDataSource: UserRemoteDataSource());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
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
                        AdminSuggetionItem(),
                      ],
                    ),
                  ),
                ),

                GetWattingAndFinishedSuggetionsApp(
                  isWaiting: false,
                  future:
                      userRepoImplementation.getFinishedSuggetionsToAuditor(),
                ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
