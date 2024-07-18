import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/admin/persentation/screens/admin_home_screen.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_state.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/home_screen_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuditorTeamHomeScreen extends StatefulWidget {
  const AuditorTeamHomeScreen({super.key});

  @override
  State<AuditorTeamHomeScreen> createState() => _AuditorTeamHomeScreenState();
}

class _AuditorTeamHomeScreenState extends State<AuditorTeamHomeScreen> {
  void initState() {
    super.initState();
    // Fetch user data when the widget is initialized
    BlocProvider.of<PersonalDetailsCubit>(context).fetchUsersbYId();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDetailsCubit, PersonalDetailsState>(
      builder: (context, state) {
        if (state is PersonalDetailsLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorManger.logoColor,
            ),
          );
        } else if (state is PersonalDetailsLoaded) {
          var user = state.users.first;
          return BackGroundAndAppBarAndDaynamicBody(
            alignmentTitle: Alignment.centerRight,
            titleName: "${user.firstname} ${user.familyName}",
            drawer: const CustomErainatDrawer(),
            yourBodyOfScreen: const AuditorHomeScreenBody(),
          );
        } else {
          return const BackGroundAndAppBarAndDaynamicBody(
            alignmentTitle: Alignment.centerRight,
            titleName: "الادمن",
            drawer: CustomErainatDrawer(),
            yourBodyOfScreen: AuditorHomeScreenBody(),
          );
        }
      },
    );
  }
}

class AuditorHomeScreenBody extends StatelessWidget {
  const AuditorHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: kToolbarHeight - 20.h,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 95.w,
                  mainAxisSpacing: 40.h,
                ),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return HomeScreenItem(
                    isAuditor: true,
                    isAdmin: false,
                    index: index,
                  );
                },
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}
