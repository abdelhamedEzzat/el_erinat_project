import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';

class SignUpTextTitle extends StatelessWidget {
  const SignUpTextTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: Text(
          MStrings.register,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorManger.logoColor),
        ));
  }
}
