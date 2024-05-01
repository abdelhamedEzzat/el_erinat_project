// import 'package:device_preview/device_preview.dart';
import 'package:device_preview/device_preview.dart';
import 'package:el_erinat/core/config/theme_manger.dart';
import 'package:el_erinat/core/route/generate_route.dart';
import 'package:el_erinat/features/users/persentation/screens/splash_screen/splach_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          // You can use the library anywhere in the app even in theme
          theme: themeManager(),

          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,

          darkTheme: ThemeData.dark(),
          home: child, routes: RouteGenerator.buildRoutes(),
        );
      },
      child: const SplachScreen(),
    );
  }
}
