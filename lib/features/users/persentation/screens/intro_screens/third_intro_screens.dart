import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/intro_widgets/third_screen_widget/intro_text_widgets.dart';
import 'package:el_erinat/features/users/persentation/widgets/intro_widgets/third_screen_widget/logo_in_third.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThirdIntroScreens extends StatefulWidget {
  const ThirdIntroScreens({super.key});

  @override
  State<ThirdIntroScreens> createState() => _ThirdIntroScreensState();
}

class _ThirdIntroScreensState extends State<ThirdIntroScreens>
    with TickerProviderStateMixin {
  late final AnimationController logoAnimationController;
  late final Animation animation;

  late final Animation animation1;
  late final Animation animation2;
  late final Animation animation3;
  late final Animation animation4;

  late final AnimationController animationSubTitleController1;
  late final AnimationController animationSubTitleController2;
  late final AnimationController animationSubTitleController3;
  late final AnimationController animationSubTitleController4;

  @override
  void initState() {
    super.initState();
    logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animationSubTitleController1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animationSubTitleController2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animationSubTitleController3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animationSubTitleController4 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(logoAnimationController);
    animation1 =
        Tween(begin: 0.0, end: 1.0).animate(animationSubTitleController1);
    animation2 =
        Tween(begin: 0.0, end: 1.0).animate(animationSubTitleController2);
    animation3 =
        Tween(begin: 0.0, end: 1.0).animate(animationSubTitleController3);
    animation4 =
        Tween(begin: 0.0, end: 1.0).animate(animationSubTitleController4);
    logoAnimationController.forward().whenComplete(() =>
        animationSubTitleController1.forward().whenComplete(() =>
            animationSubTitleController2.forward().whenComplete(() =>
                animationSubTitleController3
                    .forward()
                    .whenComplete(() => animationSubTitleController4.forward())
                    .whenComplete(
                        () => Future.delayed(const Duration(seconds: 2), () {
                              Navigator.pushNamed(
                                  context, ConstantsRouteString.registerScreen);
                            })))));
  }

  @override
  void dispose() {
    logoAnimationController.dispose();
    animationSubTitleController1.dispose();
    animationSubTitleController2.dispose();
    animationSubTitleController3.dispose();
    animationSubTitleController4.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 85.h),
              Container(
                margin: EdgeInsets.symmetric(vertical: 40.h),
                width: MediaQuery.of(context).size.width,
                child: ColorFiltered(
                  colorFilter:
                      ColorFilter.mode(ColorManger.logoColor, BlendMode.srcIn),
                  child: AnimatedBuilder(
                    animation: logoAnimationController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: animation.value,
                        child: const ThirdIntroLogoImage(),
                      );
                    },
                  ),
                ),
              ),
              IntroTextWidgets(
                text: MStrings.phrasesOfPoetry1,
                opacityAnimation: animation1,
                animationSubTitleController: animationSubTitleController1,
              ),
              IntroTextWidgets(
                text: MStrings.phrasesOfPoetry2,
                opacityAnimation: animation2,
                animationSubTitleController: animationSubTitleController2,
              ),
              SizedBox(
                height: 15.h,
              ),
              IntroTextWidgets(
                text: MStrings.phrasesOfPoetry3,
                opacityAnimation: animation3,
                animationSubTitleController: animationSubTitleController3,
              ),
              IntroTextWidgets(
                text: MStrings.phrasesOfPoetry4,
                opacityAnimation: animation4,
                animationSubTitleController: animationSubTitleController4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
