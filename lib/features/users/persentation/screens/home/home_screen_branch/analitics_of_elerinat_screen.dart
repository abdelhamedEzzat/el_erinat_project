import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/analitics_screen_widget/analitics_elerinat_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnaliticsOfElerinatScreen extends StatefulWidget {
  const AnaliticsOfElerinatScreen({super.key});

  @override
  State<AnaliticsOfElerinatScreen> createState() =>
      _AnaliticsOfElerinatScreenState();
}

class _AnaliticsOfElerinatScreenState extends State<AnaliticsOfElerinatScreen>
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
    return BackGroundAndAppBarAndDaynamicBody(
      alignmentTitle: Alignment.center,
      titleName: MStrings.analiticsOfElerinat,
      yourBodyOfScreen: AnaliticsOfElerinatBody(
        tabController: _tabController,
      ),
      appBarbottom: TabBar(
        indicatorColor: Colors.white,
        unselectedLabelColor: Colors.white,
        labelColor: Colors.white,
        controller: _tabController,
        tabs: <Widget>[
          Tab(
            child: Text(MStrings.analiticsPeople,
                style: TextStyle(fontSize: 12.h, fontWeight: FontWeight.bold)),
          ),
          Tab(
            child: Text(MStrings.analiticsJob,
                style: TextStyle(fontSize: 12.h, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
