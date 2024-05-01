import 'package:el_erinat/features/users/persentation/widgets/intro_widgets/first_screen_widget/sub_title_first_intro_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/intro_widgets/first_screen_widget/title_first_intro_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstIntroWidget extends StatelessWidget {
  const FirstIntroWidget({
    super.key,
    required AnimationController animationTitleController,
    required Animation<double> animation2,
    required AnimationController animationSubTitleController,
    required this.animation,
  })  : _animationTitleController = animationTitleController,
        _animation = animation2,
        _animationSubTitleController = animationSubTitleController;

  final AnimationController _animationTitleController;
  final Animation<double> _animation;
  final AnimationController _animationSubTitleController;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationTitleController,
              builder: (context, child) {
                return TitleFirstIntroWidget(animation: _animation);
              },
            ),
            SizedBox(height: 20.h),
            AnimatedBuilder(
              animation: _animationSubTitleController,
              builder: (context, child) {
                return SubTitleFirstIntroWidget(animation: animation);
              },
            ),
          ],
        ),
      ),
    );
  }
}
