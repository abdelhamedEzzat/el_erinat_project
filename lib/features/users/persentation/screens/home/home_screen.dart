import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/admin/persentation/screens/admin_home_screen.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_state.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isUnderReview = false;

  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget is initialized
    BlocProvider.of<PersonalDetailsCubit>(context).fetchUsersbYId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PersonalDetailsCubit, PersonalDetailsState>(
        listener: (context, state) {
          if (state is PersonalDetailsLoaded) {
            var user = state.users.first;
            var personalDetails = user.statusOfUser;
            if (personalDetails == "قيد المراجعه") {
              setState(() {
                _isUnderReview = true;
              });
            } else {
              setState(() {
                _isUnderReview = false;
              });
            }
          }
        },
        builder: (context, state) {
          if (state is PersonalDetailsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorManger.logoColor,
              ),
            );
          } else if (state is PersonalDetailsLoaded) {
            var user = state.users.first;

            return Stack(
              children: [
                AbsorbPointer(
                  absorbing: _isUnderReview,
                  child: BackGroundAndAppBarAndDaynamicBody(
                    alignmentTitle: Alignment.topRight,
                    titleName: "${user.firstname} ${user.familyName}",
                    yourBodyOfScreen: const HomeScreenBody(),
                    drawer: const CustomErainatDrawer(),
                  ),
                ),
                if (_isUnderReview)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Expanded(
                            child: Center(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                "حياك الله حسابك قيد المراجعه , يرجي الانتظار حتي تتم الموافقه ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          } else {
            return const Center(
              child: Text("لا يوجد بيانات"),
            );
          }
        },
      ),
    );
  }
}
