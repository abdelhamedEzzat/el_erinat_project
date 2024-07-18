import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_state.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/user_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinishedUserWidget extends StatefulWidget {
  const FinishedUserWidget({super.key});

  @override
  State<FinishedUserWidget> createState() => _FinishedUserWidgetState();
}

class _FinishedUserWidgetState extends State<FinishedUserWidget> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    BlocProvider.of<PersonalDetailsCubit>(context).fetchAcceptedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalDetailsCubit, PersonalDetailsState>(
      listener: (context, state) {
        if (state is PersonalDetailsSuccess) {
          BlocProvider.of<PersonalDetailsCubit>(context).fetchAcceptedUsers();
        }
      },
      builder: (context, state) {
        if (state is AcceptPersonalDetailsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AcceptPersonalDetailsSuccess) {
          return SafeArea(
            child: ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (BuildContext context, int index) {
                final user = state.users[index];

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorManger.appBarColor),
                        ),
                        padding: const EdgeInsets.all(18.0),
                        margin: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            UserDataWidget(
                              detailsText: "اسم المستخدم",
                              userDetails:
                                  "${user.firstname!} ${user.fatherName} ${user.grandfatherName} ${user.greatGrandfatherName}",
                            ),
                            SizedBox(height: 10.h),
                            UserDataWidget(
                              detailsText: "العمر",
                              userDetails: user.age.toString(),
                            ),
                            SizedBox(height: 10.h),
                            UserDataWidget(
                              detailsText: "الدوله",
                              userDetails: user.countryName.toString(),
                            ),
                            SizedBox(height: 10.h),
                            UserDataWidget(
                              detailsText: "رقم الجوال",
                              userDetails: user.phoneNumber.toString(),
                            ),
                            SizedBox(height: 10.h),
                            UserDataWidget(
                              detailsText: "دور المستخدم",
                              userDetails: user.role.toString(),
                            ),
                            SizedBox(height: 10.h),
                            UserDataWidget(
                              detailsText: "الحالة",
                              userDetails: user.statusOfUser.toString(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: Text("لا يوجد مستخدمين",
                style: TextStyle(color: ColorManger.logoColor, fontSize: 18.w)),
          );
        }
      },
    );
  }
}
