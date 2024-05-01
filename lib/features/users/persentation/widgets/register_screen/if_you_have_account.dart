import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';

class IfYouHaveAccount extends StatelessWidget {
  const IfYouHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              //  Navigator.pushNamed(context, ConstantsRouteString.loginScreen);
            },
            child: Text(
              MStrings.register,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: ColorManger.logoColor),
            )),
        Text(
          MStrings.ifYouAlreadyHaveAnAccount,
          style: Theme.of(context).textTheme.headlineLarge,
        )
      ],
    );
  }
}
