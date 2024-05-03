// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:el_erinat/core/back_ground_app/back_ground_widget.dart';
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
    return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        drawer: const Drawer(),
        appBar: CustomAppBar(
          alignmentTitle: Alignment.topRight,
          title: Text("الحميدان",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white)
                  .copyWith(fontSize: 15.h)),
        ),
        body: Stack(
          children: [
            const BackgroundWidget(),
            HomeScreenBody(itemsicons: itemsicons, itemsList: itemsList),
          ],
        ));
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    super.key,
    required this.itemsicons,
    required this.itemsList,
  });

  final List<IconData> itemsicons;
  final List<String> itemsList;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: kToolbarHeight,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 95.w,
                  mainAxisSpacing: 40.h,
                ),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return HomeScreenItem(
                    itemsicons: itemsicons,
                    itemsList: itemsList,
                    index: index,
                  );
                },
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenItem extends StatelessWidget {
  const HomeScreenItem({
    super.key,
    required this.itemsicons,
    required this.itemsList,
    required this.index,
  });

  final List<IconData> itemsicons;
  final List<String> itemsList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToScreen(context, index),
      child: Container(
        decoration: BoxDecoration(
            color: ColorManger.logoColor,
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
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 11.h, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToScreen(BuildContext context, int index) {
    String routeName;
    switch (index) {
      case 0:
        routeName = ConstantsRouteString.bookOfElerinatScreen;
        break;
      case 1:
        routeName = ConstantsRouteString.treeOfElerinatScreen;
        break;
      case 2:
        routeName = ConstantsRouteString.analiticsOfElerinatScreen;
        break;
      case 3:
        routeName = ConstantsRouteString.newsOfElerinatScreen;
        break;
      case 4:
        routeName = ConstantsRouteString.auditorTeamScreen;
        break;
      case 5:
        routeName = ConstantsRouteString.suggestionsScreen;
        break;
      default:
        return; // Return if index is out of bounds
    }
    Navigator.of(context).pushNamed(routeName);
  }
}
