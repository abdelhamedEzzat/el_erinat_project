import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';

class IntroTextWidgets extends StatelessWidget {
  const IntroTextWidgets({
    super.key,
    required this.text,
    required this.opacityAnimation,
    required this.animationSubTitleController,
  });
  final String text;
  final Animation opacityAnimation;
  final AnimationController animationSubTitleController;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationSubTitleController,
      builder: (context, child) {
        return Opacity(
          opacity: opacityAnimation.value,
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: ColorManger.logoColor),
          ),
        );
      },
    );
  }
}
