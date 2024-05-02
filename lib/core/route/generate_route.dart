import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/screens/home/home_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/intro_screens/first_intro_screens.dart';
import 'package:el_erinat/features/users/persentation/screens/intro_screens/secound_intro_screens.dart';
import 'package:el_erinat/features/users/persentation/screens/intro_screens/third_intro_screens.dart';
import 'package:el_erinat/features/users/persentation/screens/otp_screen/otp_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/register_screen/register_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/splash_screen/splach_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/user_details_screen/user_details_identaty.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Map<String, WidgetBuilder> buildRoutes() {
    return {
      ConstantsRouteString.splashScreen: (context) => const SplachScreen(),
      ConstantsRouteString.firstintroScreens: (context) =>
          const FirstintroScreens(),
      ConstantsRouteString.secoundIntroScreens: (context) =>
          const SecoundIntroScreens(),
      ConstantsRouteString.thirdIntroScreens: (context) =>
          const ThirdIntroScreens(),
      ConstantsRouteString.registerScreen: (context) => const RegisterScreen(),
      ConstantsRouteString.otpScreen: (context) => const OtpScreen(),
      ConstantsRouteString.userDetailsIdentaty: (context) =>
          const UserDetailsIdentaty(),
      ConstantsRouteString.homeScreen: (context) => const HomeScreen(),
    };
  }
}
