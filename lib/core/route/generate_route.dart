import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/screens/splach_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Map<String, WidgetBuilder> buildRoutes() {
    return {
      ConstantsRouteString.splashScreen: (context) => const SplachScreen(),
    };
  }
}
