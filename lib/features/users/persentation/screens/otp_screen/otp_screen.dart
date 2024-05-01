import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/otp_screen/otp_static_text.dart';
import 'package:el_erinat/features/users/persentation/widgets/otp_screen/pin_put_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                text: "+99685847852",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(
                height: 25.h,
              ),
              const FractionallySizedBox(
                widthFactor: 1,
                child: PinputWidget(),
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
              OtpStaticText(
                text: MStrings.resend,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: ColorManger.logoColor),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
