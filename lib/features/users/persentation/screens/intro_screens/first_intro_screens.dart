import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/intro_widgets/first_screen_widget/first_intro_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstintroScreens extends StatefulWidget {
  const FirstintroScreens({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FirstintroScreensState createState() => _FirstintroScreensState();
}

class _FirstintroScreensState extends State<FirstintroScreens>
    with TickerProviderStateMixin {
  late AnimationController _animationTitleController;
  late Animation<double> _animation;

  late AnimationController _animationSubTitleController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    _animationTitleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationSubTitleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    //
    //

    animation =
        Tween(begin: 0.0, end: 1.0).animate(_animationSubTitleController)
          ..addListener(() {
            setState(() {}); // Rebuild the widget when animation value changes
          });

    //
    //
    _animation =
        Tween<double>(begin: 10.w, end: 25.w).animate(_animationTitleController)
          ..addListener(() {
            setState(() {}); // Rebuild the widget when animation value changes
          });
    _animationTitleController
        .forward()
        .whenComplete(() => _animationSubTitleController.forward())
        .whenComplete(() => Future.delayed(const Duration(seconds: 4), () {
              Navigator.pushNamed(
                  context, ConstantsRouteString.secoundIntroScreens);
            }));
  }

  @override
  void dispose() {
    _animationTitleController.dispose();
    //  logoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstIntroWidget(
          animationTitleController: _animationTitleController,
          animation2: _animation,
          animationSubTitleController: _animationSubTitleController,
          animation: animation),
    );
  }
}
