// import 'package:device_preview/device_preview.dart';
import 'package:device_preview/device_preview.dart';
import 'package:el_erinat/core/config/theme_manger.dart';
import 'package:el_erinat/core/route/generate_route.dart';
import 'package:el_erinat/features/users/persentation/cubit/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:el_erinat/features/users/persentation/screens/register_screen/register_screen.dart';
import 'package:el_erinat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PhoneAuthCubit(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,

            // You can use the library anywhere in the app even in theme
            theme: themeManager(),

            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,

            darkTheme: ThemeData.dark(),
            home: child, routes: RouteGenerator.buildRoutes(),
          ),
        );
      },
      child: const RegisterScreen(),
    );
  }
}
