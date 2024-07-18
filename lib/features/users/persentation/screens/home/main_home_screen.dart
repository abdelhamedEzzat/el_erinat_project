import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/admin/persentation/screens/admin_home_screen.dart';
import 'package:el_erinat/features/auditor_team/persentation/screen/auditor_team_home_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/home/home_screen.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHomeScreens extends StatefulWidget {
  const MainHomeScreens({Key? key}) : super(key: key);

  @override
  State<MainHomeScreens> createState() => _MainHomeScreensState();
}

class _MainHomeScreensState extends State<MainHomeScreens> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<PersonalDetailsCubit>(context).fetchUsersbYId();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalDetailsCubit, PersonalDetailsState>(
      listener: (context, state) {
        if (state is UpdateStatusSuccess) {
          BlocProvider.of<PersonalDetailsCubit>(context).fetchUsersbYId();
        }
      },
      builder: (context, state) {
        if (state is PersonalDetailsLoaded) {
          final user = state.users.first;
          if (user.role == "مشرف") {
            return const AuditorTeamHomeScreen();
          } else if (user.role == "مسؤول") {
            return const AdminHomeScreen();
          } else {
            return const HomeScreen();
          }
        } else {
          return const HomeScreen();
          // Handle loading state or other states here
          // return const Scaffold(
          //   body: Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // );
        }
      },
    );
  }
}
