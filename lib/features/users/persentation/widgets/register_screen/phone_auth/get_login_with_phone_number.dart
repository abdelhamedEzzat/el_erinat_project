import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/cubit/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetLoginWithPhoneNumber extends StatelessWidget {
  const GetLoginWithPhoneNumber({
    super.key,
    required this.phoneAuthCubit,
  });

  final PhoneAuthCubit phoneAuthCubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
      listener: (context, state) {
        if (state is PhoneCodeSentState) {
          Navigator.pushNamed(context, ConstantsRouteString.otpScreen,
              arguments: phoneAuthCubit.phone);
        } else if (state is PhoneAuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg),
              duration: const Duration(milliseconds: 600),
              backgroundColor: Colors.red,
            ),
          );
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is PhoneAuthLoading) {
          return CircularProgressIndicator(
            color: ColorManger.colorProgressIndecator,
          );
        }
        return BottonClick(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 30.w,
            onTap: () {
              phoneAuthCubit.verificationPhoneNumber(phoneAuthCubit.phone);
            },
            text: MStrings.sendOtpCode);
      },
    );
  }
}
