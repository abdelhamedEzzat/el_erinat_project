import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';

class TitleFirstIntroWidget extends StatelessWidget {
  const TitleFirstIntroWidget({
    super.key,
    required Animation<double> animation,
  }) : _animation = animation;

  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      MStrings.firstTitleIntroScreens,
      style: TextStyle(
        color: ColorManger.logoColor,
        fontSize: _animation.value,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
