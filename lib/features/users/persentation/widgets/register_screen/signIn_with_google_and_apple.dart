import 'package:el_erinat/core/config/images_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/or_sign_in_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInWithGoogleAndAppleAccount extends StatelessWidget {
  const SignInWithGoogleAndAppleAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OrSignInIcon(
          onTap: () {},
          image: ImagesStrings.appleLogo,
        ),
        SizedBox(width: 40.w),
        OrSignInIcon(
          onTap: () {},
          image: ImagesStrings.googleLogo,
        ),
      ],
    );
  }
}
