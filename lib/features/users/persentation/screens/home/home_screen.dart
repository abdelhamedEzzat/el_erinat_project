// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/home_screen_body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGroundAndAppBarAndDaynamicBody(
      alignmentTitle: Alignment.topRight,
      titleName: "الحميدان",
      yourBodyOfScreen: HomeScreenBody(),
      drawer: Drawer(),
    );
  }
}
