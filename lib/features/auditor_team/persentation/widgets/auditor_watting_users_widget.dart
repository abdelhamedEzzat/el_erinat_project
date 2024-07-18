import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_state.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/user_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuditorWattingUserWidget extends StatefulWidget {
  const AuditorWattingUserWidget({super.key});

  @override
  State<AuditorWattingUserWidget> createState() =>
      _AuditorWattingUserWidgetState();
}

class _AuditorWattingUserWidgetState extends State<AuditorWattingUserWidget> {
  final List<String> items = [
    'مستخدم',
  ];
  UserRepoImplementation userRepoImplementation = UserRepoImplementation(
    localDatabaseHelper: LocalDatabaseHelper(),
    userRemoteDataSource: UserRemoteDataSource(),
  );
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    BlocProvider.of<PersonalDetailsCubit>(context).fetchWaitingUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalDetailsCubit, PersonalDetailsState>(
      listener: (context, state) {
        if (state is PersonalDetailsSuccess) {
          BlocProvider.of<PersonalDetailsCubit>(context).fetchWaitingUsers();
        }
        if (state is UpdateStatusSuccess) {
          BlocProvider.of<PersonalDetailsCubit>(context).fetchWaitingUsers();
        }
      },
      builder: (context, state) {
        if (state is WattingPersonalDetailsLoading ||
            state is UpdateStatusLoading ||
            state is DeleteUnAcceptedUserLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WattingPersonalDetailsSuccess) {
          return SafeArea(
            child: ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (BuildContext context, int index) {
                final user = state.users[index];
                // تعيين القيمة المحددة من الدور الحالي للمستخدم
                String selectedValue = user.role ?? 'مستخدم';

                // التحقق من أن القيمة المحددة موجودة في القائمة items
                if (!items.contains(selectedValue)) {
                  selectedValue = 'مستخدم';
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.of(context).pushNamed(
                              ConstantsRouteString
                                  .userInformationInAuditorScreen,
                              arguments: user.uID);

                          if (result == "refresh") {
                            _fetchData();
                          }
                        },
                        child: Container(
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
                              DropdownButton<String>(
                                isExpanded: true,
                                value: selectedValue,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 22.h,
                                elevation: 16,
                                style: TextStyle(
                                  color: ColorManger.logoColor,
                                ),
                                underline: Container(
                                  height: 2,
                                  color: ColorManger.logoColor.withOpacity(0.7),
                                ),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      selectedValue = newValue;
                                      user.role = newValue;
                                    });
                                  }
                                },
                                items: items.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: 18.h,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: BottonClick(
                                      height: 35.h,
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      onTap: () async {
                                        await userRepoImplementation
                                            .updateUserRole(selectedValue, user)
                                            .whenComplete(() {
                                          String acceptedStatus = "تم الموافقه";
                                          BlocProvider.of<PersonalDetailsCubit>(
                                                  context)
                                              .updateStatusOfUsers(
                                                  user.id!, acceptedStatus);
                                        });
                                      },
                                      text: MStrings.accepted,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: BottonClick(
                                      colorBotton: Colors.red,
                                      height: 35.h,
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      onTap: () {
                                        String acceptedStatus = "تم الرفض";
                                        BlocProvider.of<PersonalDetailsCubit>(
                                                context)
                                            .deleteUserWhenUnAccepted(
                                                user.uID.toString(), user)
                                            .whenComplete(() {
                                          BlocProvider.of<PersonalDetailsCubit>(
                                                  context)
                                              .updateStatusOfUsers(
                                                  user.id!, acceptedStatus);
                                        });
                                      },
                                      text: MStrings.rajected,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
