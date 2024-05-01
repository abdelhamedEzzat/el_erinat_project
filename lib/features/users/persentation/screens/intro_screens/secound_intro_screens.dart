import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/intro_widgets/second_screen_widget/animated_text_secound_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecoundIntroScreens extends StatefulWidget {
  const SecoundIntroScreens({super.key});

  @override
  State<SecoundIntroScreens> createState() => _SecoundIntroScreensState();
}

class _SecoundIntroScreensState extends State<SecoundIntroScreens>
    with TickerProviderStateMixin {
  late AnimationController _animationTitleController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationTitleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationTitleController)
      ..addListener(() {
        setState(() {}); // Rebuild the widget when animation value changes
      });
    //
    //

    //
    //

    _animationTitleController
        .forward()
        .whenComplete(() => Future.delayed(const Duration(seconds: 4), () {
              Navigator.pushNamed(
                  context, ConstantsRouteString.thirdIntroScreens);
            }));
  }

  @override
  void dispose() {
    _animationTitleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimtedTextSecoundScreen(
                animationTitleController: _animationTitleController,
                animation: _animation),
          ],
        ),
      ),
    ));
  }
}
