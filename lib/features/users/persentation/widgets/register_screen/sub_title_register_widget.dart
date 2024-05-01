import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';

class SignUpTextSubTitle extends StatelessWidget {
  const SignUpTextSubTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: Text(
          textAlign: TextAlign.center,
          MStrings.enterYourPhoneNumberAndWeWillSendOtp,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.grey.shade700),
        ));
  }
}
