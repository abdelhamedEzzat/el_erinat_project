import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/admin/persentation/widget/admin_home_widget/admin_home_body.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGroundAndAppBarAndDaynamicBody(
      alignmentTitle: Alignment.centerRight,
      titleName: "الادمن",
      drawer: Drawer(),
      yourBodyOfScreen: AdminHomeScreenBody(),
    );
  }
}
