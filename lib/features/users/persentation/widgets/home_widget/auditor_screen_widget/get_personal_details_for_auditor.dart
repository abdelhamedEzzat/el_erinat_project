import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_state.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/user_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetpersonalDetailsForAuditor extends StatefulWidget {
  const GetpersonalDetailsForAuditor({super.key, required this.userUID});
  final String userUID;
  @override
  State<GetpersonalDetailsForAuditor> createState() =>
      _GetpersonalDetailsForAuditorState();
}

class _GetpersonalDetailsForAuditorState
    extends State<GetpersonalDetailsForAuditor> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PersonalDetailsCubit>(context)
        .fetchUsersToUditorbYUId(widget.userUID);
    print("${widget.userUID}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDetailsCubit, PersonalDetailsState>(
      builder: (context, state) {
        if (state is PersonalDetailsForAuditorLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PersonalDetailsForAuditorSuccess) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 10.h),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          width: 150.w,
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                              color: ColorManger.logoColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.h))),
                          child: Text("المعلومات الشخصية",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                        ),

                        SizedBox(height: 10.h),
                        UserDataWidget(
                          detailsText: "الاسم",
                          userDetails:
                              "${user.firstname!} ${user.fatherName!} ${user.grandfatherName!} ${user.greatGrandfatherName!}",
                        ),
                        SizedBox(height: 5.h),
                        UserDataWidget(
                            detailsText: "الاسره",
                            userDetails: user.familyName!),
                        SizedBox(height: 5.h),
                        UserDataWidget(
                            detailsText: "العمر", userDetails: user.age!),
                        SizedBox(height: 5.h),
                        UserDataWidget(
                            detailsText: "الجنس", userDetails: user.gender!),
                        SizedBox(height: 5.h),
                        UserDataWidget(
                            detailsText: "رقم الجوال",
                            userDetails: user.phoneNumber!),
                        SizedBox(height: 5.h),
                        UserDataWidget(
                            detailsText: "حاله الاب",
                            userDetails: user.fatherLiveORDead!),
                        SizedBox(height: 5.h),
                        UserDataWidget(
                            detailsText: "حاله الجد",
                            userDetails: user.grandfatherLiveORDead!),
                        SizedBox(height: 5.h),
                        UserDataWidget(
                            detailsText: "حاله الاب للجد",
                            userDetails: user.greatGrandFatherLiveOrDead!),

                        // Text(state.user.email),
                        // Text(state.user.phone),
                      ],
                    );
                  }),
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
