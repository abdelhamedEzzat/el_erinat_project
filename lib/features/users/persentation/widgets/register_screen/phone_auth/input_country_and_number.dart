import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class InputCountryAndNumber extends StatelessWidget {
  const InputCountryAndNumber({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final phoneAuthCubit = BlocProvider.of<PhoneAuthCubit>(context);
    return Container(
        padding: EdgeInsets.all(8.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: ColorManger.logoColor.withOpacity(0.13)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: ColorManger.logoColor,
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ]),
        child: BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
            builder: (context, state) {
          return IntlPhoneField(
            enabled: true,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            cursorColor: ColorManger.logoColor,
            invalidNumberMessage: MStrings.invalidPhoneNumber,
            autovalidateMode: AutovalidateMode.disabled,
            textAlign: TextAlign.right,
            dropdownTextStyle: Theme.of(context).textTheme.headlineSmall!,
            keyboardType: TextInputType.number,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: ColorManger.logoColor,
              hintText: MStrings.enterYourPhoneNumber,
              hintStyle: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.grey.shade700),
            ),
            initialCountryCode: 'SA',
            countries: const [
              Country(
                  name: 'Saudi Arabia',
                  flag: '🇸🇦',
                  code: "SA",
                  dialCode: '966',
                  nameTranslations: {
                    "en": "Saudi Arabia",
                  },
                  minLength: 9,
                  maxLength: 9),
              Country(
                name: 'United Arab Emirates',
                flag: '🇦🇪',
                code: "AE",
                dialCode: '971',
                nameTranslations: {
                  "en": "United Arab Emirates",
                },
                minLength: 9,
                maxLength: 9,
              ),
              Country(
                name: 'Kuwait',
                flag: '🇰🇼',
                code: "KW",
                dialCode: '965',
                nameTranslations: {
                  "en": "Kuwait",
                },
                minLength: 8,
                maxLength: 8,
              ),
              Country(
                name: 'Iraq',
                flag: '🇮🇶',
                code: "IQ",
                dialCode: '964',
                nameTranslations: {
                  "en": "Iraq",
                },
                minLength: 10,
                maxLength: 10,
              ),
            ],
            onChanged: (phone) {
              phoneAuthCubit.phone = phone.completeNumber;
              print(phone.completeNumber);
            },
          );
        }));
  }
}
