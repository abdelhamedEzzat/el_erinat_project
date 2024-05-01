import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';

class AnimtedTextSecoundScreen extends StatelessWidget {
  const AnimtedTextSecoundScreen({
    super.key,
    required AnimationController animationTitleController,
    required Animation animation,
  })  : _animationTitleController = animationTitleController,
        _animation = animation;

  final AnimationController _animationTitleController;
  final Animation _animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationTitleController,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Text(
              textAlign: TextAlign.center,
              MStrings.secoundTitleIntroScreens,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: ColorManger.logoColor)),
        );
      },
    );
  }
}
