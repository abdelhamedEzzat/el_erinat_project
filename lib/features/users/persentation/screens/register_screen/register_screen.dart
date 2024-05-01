import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/or_with_divider.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/register_logo.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/register_with_phone_number.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/signIn_with_google_and_apple.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/sub_title_register_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/title_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const RegisterLogo(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              children: [
                const SignUpTextTitle(),
                SizedBox(
                  height: 10.h,
                ),
                const SignUpTextSubTitle(),
                SizedBox(
                  height: 25.h,
                ),
                const RegisterWithPhoneNumber(),
                SizedBox(
                  height: 30.h,
                ),
                BottonClick(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 30.w,
                    onTap: () {
                      Navigator.pushNamed(
                          context, ConstantsRouteString.otpScreen);
                    },
                    text: MStrings.sendOtpCode),
                SizedBox(
                  height: 20.h,
                ),
                const OrWithDevider(),
                SizedBox(
                  height: 15.h,
                ),
                const SignInWithGoogleAndAppleAccount()
              ],
            ),
          ),
        ]),
      ),
    ));
  }
}
