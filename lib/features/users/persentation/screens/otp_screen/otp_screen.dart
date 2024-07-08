import 'dart:async';

import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/otp_screen/otp_static_text.dart';
import 'package:el_erinat/features/users/persentation/widgets/otp_screen/pin_put_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late Timer _timer;
  int _start = 50;
  bool _canResend = false;

  void startTimer() {
    _canResend = false;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _canResend = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phone = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
              ),
              OtpStaticText(
                text: MStrings.virfication,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: ColorManger.logoColor),
              ),
              SizedBox(
                height: 25.h,
              ),
              OtpStaticText(
                text: MStrings.enterTheCodeSentToTheNumber,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: 25.h,
              ),
              OtpStaticText(
                text: phone,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(
                height: 25.h,
              ),
              BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
                builder: (context, state) {
                  if (state is PhoneAuthLoading) {
                    return CircularProgressIndicator(
                      color: ColorManger.colorProgressIndecator,
                    );
                  }
                  return const FractionallySizedBox(
                    widthFactor: 1,
                    child: PinputWidget(),
                  );
                },
              ),
              SizedBox(
                height: 50.h,
              ),
              OtpStaticText(
                text: MStrings.didntReceiveTheCode,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: 15.h,
              ),
              timerToWriteOrResendOTPCode(context, phone),
            ],
          ),
        ),
      )),
    );
  }

//!  timer To Write Or Resend OTP Code method

  GestureDetector timerToWriteOrResendOTPCode(
      BuildContext context, String phone) {
    return GestureDetector(
      onTap: _canResend
          ? () {
              BlocProvider.of<PhoneAuthCubit>(context)
                  .verificationPhoneNumber(phone);
              setState(() {
                _start = 50;
                _canResend = false;
              });
              startTimer();
            }
          : null,
      child: OtpStaticText(
        text:
            _canResend ? MStrings.resend : 'ثانية $_start إعاده الارسال خلال ',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: _canResend ? ColorManger.logoColor : Colors.grey,
            ),
      ),
    );
  }
}
