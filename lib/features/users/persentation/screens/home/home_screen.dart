import 'package:el_erinat/core/back_ground_app/back_ground_widget.dart';
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            Positioned.fill(
              top: kToolbarHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      // height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 95.w,
                          mainAxisSpacing: 40.h,
                        ),
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: ColorManger.logoColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.w))),
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
                                        .copyWith(
                                            fontSize: 11.h,
                                            color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
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
            ),
          ],
        ));
  }
}
