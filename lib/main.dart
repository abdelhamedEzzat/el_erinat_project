// import 'package:device_preview/device_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:el_erinat/features/admin/persentation/screens/admin_home_screen.dart';
import 'package:el_erinat/features/auditor_team/persentation/screen/auditor_team_home_screen.dart';
import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:el_erinat/features/users/persentation/screens/home/home_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/home/home_screen_branch/analitics_of_elerinat_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/register_screen/register_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/user_details_screen/user_details_identaty.dart';
import 'package:el_erinat/features/users/persentation/screens/user_details_screen/user_details_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/user_details_screen/work_user_detatils.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/auditor_for_get_work_user_data/auditor_for_get_user_work_data_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/google_auth_cubit/google_auth_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/problems_cubit/problems_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/suggetions_and_vote/suggtions_and_vote_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/work_personal_details_cubit/work_personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/analitics_screen_widget/analitics_elerinat_body.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/analitics_screen_widget/job_analitics_body.dart';
import 'package:el_erinat/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workmanager/workmanager.dart';

import 'core/config/color_manger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalNotification.init();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerOneOffTask("fetchNewsTask", "fetchNewsTask");

  //Workmanager().registerOneOffTask("fetchBookTask", "fetchBookTask");

  //getBookInBackGround
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
                        userRemoteDataSource: UserRemoteDataSource()))),
            BlocProvider(
                create: (context) => ProblemsCubit(UserRepoImplementation(
                    localDatabaseHelper: LocalDatabaseHelper(),
                    userRemoteDataSource: UserRemoteDataSource()))
                // ..getWattingproblemsForAuditors()
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
                create: (context) => SuggtionsAndVoteCubit(
                    userRepo: UserRepoImplementation(
                        localDatabaseHelper: LocalDatabaseHelper(),
                        userRemoteDataSource: UserRemoteDataSource()))
                  ..getSuggetions()),
            BlocProvider(
                create: (context) => AuditorForGetUserWorkDataCubit(
                    UserRepoImplementation(
                        localDatabaseHelper: LocalDatabaseHelper(),
                        userRemoteDataSource: UserRemoteDataSource()))),
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
      child:
          // UserDetailsIdentaty()
          //  UserDitailsScreen()
          //  AuditorTeamHomeScreen()
          // WorkUserDetails()
          // HomeScreen()
          //   RegisterScreen()
          //  const UserDetailsIdentaty(),
          //AnaliticsOfElerinatScreen()
          //  const AuthUsers(),
          AdminHomeScreen(),
    );
  }
}

class AuthUsers extends StatelessWidget {
  const AuthUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        User? user = snapshot.data;
        User? users = FirebaseAuth.instance.currentUser;
        //   var status = Constanscollection.getUserStatus();
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return Center(
            child: CircularProgressIndicator(
              color: ColorManger.logoColor,
            ),
          );
        } else if (user != null && users != null) {
          print("==================================User sign in ");
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  // Loading user data
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (userSnapshot.hasData) {
                  // User data is available, check role
                  var userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;
                  var personalDetails =
                      userData['personalDetails'] as Map<String, dynamic>?;
                  var workDetails =
                      userData['workDetails'] as Map<String, dynamic>?;
                  var identityImage =
                      userData['identityImage'] as Map<String, dynamic>?;

                  if (personalDetails == null) {
                    return const UserDitailsScreen();
                  } else if (workDetails == null) {
                    return const WorkUserDetails();
                  } else if (identityImage == null) {
                    return const UserDetailsIdentaty();
                  } else if (userSnapshot.data == null) {
                    return const RegisterScreen();
                  } else {
                    var role = personalDetails?['role'] as String?;
                    if (role == "مشرف") {
                      return const AuditorTeamHomeScreen();
                    } else if (role == "مسؤول") {
                      return const AdminHomeScreen();
                    } else {
                      return const HomeScreen();
                    }
                  }
                } else {
                  return const RegisterScreen();
                }
              });
        } else {
          print("==================================User sign out ");
          return const RegisterScreen();
        }
      },
    );
  }
}















//  if (userData != null && userData is Map<String, dynamic>) {
//                   //  String userRole = userData['role.en'] ?? '';
//                   Map<String, dynamic> roleMap = userData['role'] ?? '';
//                   // String userRole = roleMap['en']; // Accessing the English role
//                   // String userStatus =
//                   //     userData.containsKey('status') ? userData['status'] : '';
//                   // String userEmailStatus = userData.containsKey('Email_status')
//                   //     ? userData['Email_status']
//                   //     : '';
//                   // Now you can use the userRole to decide where to navigate
//                   if (userRole == 'admin') {
//                     return const AdminHomeScreen();
//                   } else if (userRole == 'User') {
//                     if (userStatus == '0') {
//                       return const RegisterScreen();
//                     } else if (userStatus == '1') {
//                       return const AdminstrationAccepted();
//                     } else if (userStatus == '2') {
//                       if (FirebaseAuth.instance.currentUser!.emailVerified) {
//                         return const HomeScreenForUser();
//                       } else if (!FirebaseAuth
//                           .instance.currentUser!.emailVerified) {
//                         return const VreifyEmail();
//                       }
//                       return const HomeScreenForUser();
//                     }
//                   } else if (userRole == "Accountant") {
//                     return AccountantHomeScreen();
//                   } else if (userRole == "Auditor" &&
//                       userEmailStatus == "enabled") {
//                     return AuditorHomeScreen();
//                     // Add logic for userRole == "Auditor"
//                   }
//                 } else {
//                   // FirebaseAuth.instance.currentUser!.delete();
//                   // // FirebaseAuth.instance.signOut();
//                   // return status == 0 ? SplashScreen() : RegisterScreen();
//                   print(
//                       "User data is null or not of type Map<String, dynamic>");
//                 }