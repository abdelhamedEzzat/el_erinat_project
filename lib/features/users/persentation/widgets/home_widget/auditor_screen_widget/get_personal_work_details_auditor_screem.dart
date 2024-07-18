import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/auditor_for_get_work_user_data/auditor_for_get_user_work_data_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/user_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetPersonalWorkDetails extends StatefulWidget {
  const GetPersonalWorkDetails({super.key, required this.userUID});
  final String userUID;
  @override
  State<GetPersonalWorkDetails> createState() => _GetPersonalWorkDetailsState();
}

class _GetPersonalWorkDetailsState extends State<GetPersonalWorkDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AuditorForGetUserWorkDataCubit>(context)
        .fetchAllPersonalUsersinfoByIDForAuditor(widget.userUID);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuditorForGetUserWorkDataCubit,
        AuditorForGetUserWorkDataState>(
      builder: (context, state) {
        if (state is WorkPersonalDetailsForAuditorLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WorkPersonalDetailsForAuditorLoaded) {
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
                          child: Text(" معلومات العمل",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                        ),

                        SizedBox(height: 10.h),

                        SizedBox(height: 10.h),
                        UserDataWidget(
                            detailsText: "الجامعه",
                            userDetails: user.university!),
                        SizedBox(height: 5.h),
                        UserDataWidget(
                            detailsText: "تاريخ التخرج",
                            userDetails: user.dateOfCertificate!),
                        SizedBox(height: 5.h),
                        UserDataWidget(
                            detailsText: " التخصص العام",
                            userDetails: user.generalSpecialization!),
                        SizedBox(height: 5.h),
                        UserDataWidget(
                            detailsText: "التخصص الفرعي",
                            userDetails: user.specialization!),
                        SizedBox(height: 5.h),
                        UserDataWidget(
                          detailsText: "الوظيفه",
                          userDetails: "${user.jobSelected!} ",
                        ),

                        SizedBox(height: 5.h),
                        // UserDataWidget(
                        //     detailsText: "الجنس",
                        //     userDetails: state.users.first.title!),
                        // SizedBox(height: 5.h),

                        // SizedBox(height: 5.h),
                        UserDataWidget(
                            detailsText: "جهه العمل",
                            userDetails: user.employer!),
                        SizedBox(height: 5.h),
                        UserDataWidget(
                            detailsText: "المدينة", userDetails: user.city!),
                        SizedBox(height: 5.h),
                        UserDataWidget(
                            detailsText: "تاريخ الميلاد",
                            userDetails: user.dateOfBirthday!),
                        SizedBox(height: 5.h),
                        // Text(state.user.email),
                        // Text(state.user.phone),
                      ],
                    );

                    // Text(state.user.email),
                    // Text(state.user.phone),
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
