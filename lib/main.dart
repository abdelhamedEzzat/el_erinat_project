// import 'package:device_preview/device_preview.dart';
import 'package:device_preview/device_preview.dart';
import 'package:el_erinat/core/config/theme_manger.dart';
import 'package:el_erinat/core/helpers/bloc_opserver.dart';
import 'package:el_erinat/core/local_%20notification/notification.dart';
import 'package:el_erinat/core/route/generate_route.dart';
import 'package:el_erinat/features/admin/data/repo_admin/admin_isolates.dart';
import 'package:el_erinat/features/admin/data/repo_admin/admin_repo_impelment.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/admin_local_data_base_helper.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/remote_data_base_helper.dart';
import 'package:el_erinat/features/admin/persentation/cubit/book_cubit/upload_book_cubit.dart';
import 'package:el_erinat/features/admin/persentation/cubit/tree_elerinat/tree_elerinat_cubit.dart';
import 'package:el_erinat/features/admin/persentation/cubit/video_cubit/news_cubit.dart';
import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/persentation/screens/register_screen/register_screen.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/get_tree_cubit/get_tree_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/google_auth_cubit/google_auth_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/work_personal_details_cubit/work_personal_details_cubit.dart';
import 'package:el_erinat/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalNotification.init();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  Workmanager().registerOneOffTask("fetchNewsTask", "fetchNewsTask");
  //Workmanager().initialize(callbackDispatcher);
  //Workmanager().initialize(deleteCacheFromLocalDataBase, isInDebugMode: true);
  // Workmanager().registerPeriodicTask(
  //   "1",
  //   "adminDeleteOldEntries",
  //   frequency: const Duration(hours: 24),
  // );

  Bloc.observer = MyBlocObserver();
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
            BlocProvider(
              create: (context) => GoogleAuthCubit(),
            ),
            BlocProvider(
              create: (context) => PersonalDetailsCubit(
                  userRepo: UserRepoImplementation(
                      localDatabaseHelper: LocalDatabaseHelper(),
                      userRemoteDataSource: UserRemoteDataSource())),
            ),
            BlocProvider(
              create: (context) => WorkPersonalDetailsCubit(
                  userRepo: UserRepoImplementation(
                      localDatabaseHelper: LocalDatabaseHelper(),
                      userRemoteDataSource: UserRemoteDataSource())),
            ),
            BlocProvider(
                create: (context) => UploadBookCubit(
                    adminRepo: AdminRepoImplementation(
                        adminLocalDatabaseHelper: AdminLocalDatabaseHelper(),
                        adminRemoteDataBaseHelper: AdminRemoteDataBaseHelper()))
                  ..fetchBookImage()),
            BlocProvider(
                create: (context) => NewsCubit(
                    adminRepo: AdminRepoImplementation(
                        adminLocalDatabaseHelper: AdminLocalDatabaseHelper(),
                        adminRemoteDataBaseHelper: AdminRemoteDataBaseHelper()))
                  ..fetchNewsData()),
            BlocProvider(
                create: (context) => TreeElerinatCubit(
                    adminRepo: AdminRepoImplementation(
                        adminLocalDatabaseHelper: AdminLocalDatabaseHelper(),
                        adminRemoteDataBaseHelper: AdminRemoteDataBaseHelper()))
                  ..fetchAuditorElerinatFamilyTree(
                      FirebaseAuth.instance.currentUser!.uid)),
            BlocProvider(
                create: (context) => GetTreeCubit(
                    adminRepo: AdminRepoImplementation(
                        adminLocalDatabaseHelper: AdminLocalDatabaseHelper(),
                        adminRemoteDataBaseHelper: AdminRemoteDataBaseHelper()))
                  ..fetchAllElerinatFamilyTree()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,

            // You can use the library anywhere in the app even in theme
            theme: themeManager(),

            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            themeMode: ThemeMode.light,
            //   darkTheme: ThemeData.dark(),
            home: child, routes: RouteGenerator.buildRoutes(),
          ),
        );
      },
      child: const RegisterScreen(),
      // AdminHomeScreen(),
    );
  }
}
