import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';

class OrWithDevider extends StatelessWidget {
  const OrWithDevider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: ColorManger.logoColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            MStrings.or,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
          child: Divider(
            color: ColorManger.logoColor,
          ),
        ),
      ],
    );
  }
}
