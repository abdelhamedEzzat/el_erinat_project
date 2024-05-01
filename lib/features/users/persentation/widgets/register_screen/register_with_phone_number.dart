import 'package:el_erinat/features/users/persentation/widgets/register_screen/divider_in_regester_phone.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/input_country_and_number.dart';
import 'package:flutter/material.dart';

class RegisterWithPhoneNumber extends StatelessWidget {
  const RegisterWithPhoneNumber({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      Expanded(
        child: Stack(
          children: [
            InputCountryAndNumber(),
            DivederBettwenPhoneAndCountPhoneNumber(),
          ],
        ),
      ),
    ]);
  }
}
