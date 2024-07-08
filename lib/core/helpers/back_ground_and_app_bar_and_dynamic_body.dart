import 'package:el_erinat/core/back_ground_app/back_ground_widget.dart';
import 'package:el_erinat/core/helpers/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackGroundAndAppBarAndDaynamicBody extends StatelessWidget {
  const BackGroundAndAppBarAndDaynamicBody({
    super.key,
    required this.alignmentTitle,
    required this.titleName,
    required this.yourBodyOfScreen,
    this.drawer,
    this.appBarbottom,
  });
  final AlignmentGeometry alignmentTitle;
  final String titleName;
  final Widget yourBodyOfScreen;
  final Widget? drawer;
  final PreferredSizeWidget? appBarbottom;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        drawer: drawer,
        appBar: CustomAppBar(
          bottom: appBarbottom,
          alignmentTitle: alignmentTitle,
          title: Text(titleName,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white)
                  .copyWith(fontSize: 14.h, fontWeight: FontWeight.bold)),
        ),
        body: Stack(
          children: [
            const BackgroundWidget(),
            yourBodyOfScreen,
          ],
        ));
  }
}
