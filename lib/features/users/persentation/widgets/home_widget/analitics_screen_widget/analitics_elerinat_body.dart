import 'package:el_erinat/features/users/persentation/widgets/home_widget/analitics_screen_widget/job_analitics_body.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/analitics_screen_widget/people_analitics_body.dart';
import 'package:flutter/material.dart';

class AnaliticsOfElerinatBody extends StatelessWidget {
  const AnaliticsOfElerinatBody({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const <Widget>[
        Stack(children: [
          PeopleAnaliticsBody(),
        ]),
        Stack(children: [
          JobAnaliticsBody(),
        ])
      ],
    );
  }
}
