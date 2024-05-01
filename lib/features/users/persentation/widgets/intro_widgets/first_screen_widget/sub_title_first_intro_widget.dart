import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';

class SubTitleFirstIntroWidget extends StatelessWidget {
  const SubTitleFirstIntroWidget({
    super.key,
    required this.animation,
  });

  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: Text(
          textAlign: TextAlign.center,
          MStrings.firstSubTitleIntroScreens,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: ColorManger.logoColor)),
    );
  }
}
