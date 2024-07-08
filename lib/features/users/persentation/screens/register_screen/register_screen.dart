import 'package:el_erinat/features/users/persentation/user_cubit/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/or_with_divider.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/phone_auth/get_login_with_phone_number.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/register_logo.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/phone_auth/register_with_phone_number.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/signin_with_google_and_apple.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/sub_title_register_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/title_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneAuthCubit = BlocProvider.of<PhoneAuthCubit>(context);
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
                GetLoginWithPhoneNumber(phoneAuthCubit: phoneAuthCubit),
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
