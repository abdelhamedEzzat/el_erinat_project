import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/config/images_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/core/helpers/custom_app_bar.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/admin/persentation/widget/admin_home_widget/admin_home_body.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_state.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/work_personal_details_cubit/work_personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/user_data_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
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
            yourBodyOfScreen: const AdminHomeScreenBody(),
          );
        } else {
          return const BackGroundAndAppBarAndDaynamicBody(
            alignmentTitle: Alignment.centerRight,
            titleName: "الادمن",
            drawer: CustomErainatDrawer(),
            yourBodyOfScreen: AdminHomeScreenBody(),
          );
        }
      },
    );
  }
}

class CustomErainatDrawer extends StatelessWidget {
  const CustomErainatDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            // ItemInDrawer(
            //   text: "الرئيسيه",
            //   icon: Icons.home,
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed(
            //         ConstantsRouteString.mainHomeScreens);
            //   },
            // ),
            // const Divider(),
            ItemInDrawer(
              text: "معلومات الحساب",
              icon: Icons.account_circle,
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ConstantsRouteString.userInformationforUser);
              },
            ),
            const Divider(),
            ItemInDrawer(
              text: "تسجيل الخروج",
              icon: Icons.logout,
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
            const Divider(),
            const Spacer(),
            Text("انضم الينا ",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Image.asset(ImagesStrings.tiktok, width: 35.w),
                  ),
                  GestureDetector(
                    child: Image.asset(ImagesStrings.twitter, width: 30.w),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}

class UserInformationforUser extends StatelessWidget {
  const UserInformationforUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        alignmentTitle: Alignment.center,
        title: Text(
          "معلومات الحساب",
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const GetpersonalDetails(),
            Divider(
              color: ColorManger.logoColor,
              indent: 20.w,
              endIndent: 20.w,
            ),

            GetWorkDetails(),
            Divider(
              color: ColorManger.logoColor,
              indent: 20.w,
              endIndent: 20.w,
            ),
            SizedBox(
              height: 10.h,
            ),
            // GetIdentityDetails()
            //getWorkOfUser
          ],
        ),
      )),
    );
  }
}

class GetWorkDetails extends StatefulWidget {
  const GetWorkDetails({super.key});

  @override
  State<GetWorkDetails> createState() => _GetWorkDetailsState();
}

class _GetWorkDetailsState extends State<GetWorkDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<WorkPersonalDetailsCubit>(context).fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkPersonalDetailsCubit, WorkPersonalDetailsState>(
      builder: (context, state) {
        if (state is WorkPersonalDetailsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WorkPersonalDetailsLoaded) {
          return Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 10.h),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 150.w,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      color: ColorManger.logoColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.h))),
                  child: Text("معلومات العمل",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ),

                SizedBox(height: 10.h),
                UserDataWidget(
                    detailsText: "الجامعه",
                    userDetails: state.users.first.university!),
                SizedBox(height: 5.h),
                UserDataWidget(
                    detailsText: "تاريخ التخرج",
                    userDetails: state.users.first.dateOfCertificate!),
                SizedBox(height: 5.h),
                UserDataWidget(
                    detailsText: " التخصص العام",
                    userDetails: state.users.first.generalSpecialization!),
                SizedBox(height: 5.h),
                UserDataWidget(
                    detailsText: "التخصص الفرعي",
                    userDetails: state.users.first.specialization!),
                SizedBox(height: 5.h),
                UserDataWidget(
                  detailsText: "الوظيفه",
                  userDetails: "${state.users.first.jobSelected!} ",
                ),

                SizedBox(height: 5.h),
                // UserDataWidget(
                //     detailsText: "الجنس",
                //     userDetails: state.users.first.title!),
                // SizedBox(height: 5.h),

                // SizedBox(height: 5.h),
                UserDataWidget(
                    detailsText: "جهه العمل",
                    userDetails: state.users.first.employer!),
                SizedBox(height: 5.h),
                UserDataWidget(
                    detailsText: "المدينة",
                    userDetails: state.users.first.city!),
                SizedBox(height: 5.h),
                UserDataWidget(
                    detailsText: "تاريخ الميلاد",
                    userDetails: state.users.first.dateOfBirthday!),
                SizedBox(height: 5.h),
                // Text(state.user.email),
                // Text(state.user.phone),
              ],
            ),
          );
        } else {
          return Text(" no data");
        }
      },
    );
  }
}

class GetpersonalDetails extends StatefulWidget {
  const GetpersonalDetails({super.key});

  @override
  State<GetpersonalDetails> createState() => _GetpersonalDetailsState();
}

class _GetpersonalDetailsState extends State<GetpersonalDetails> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PersonalDetailsCubit>(context).fetchUsersbYId();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDetailsCubit, PersonalDetailsState>(
      builder: (context, state) {
        if (state is PersonalDetailsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PersonalDetailsLoaded) {
          return Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 10.h),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 150.w,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      color: ColorManger.logoColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.h))),
                  child: Text("المعلومات الشخصية",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ),

                SizedBox(height: 10.h),
                UserDataWidget(
                  detailsText: "الاسم",
                  userDetails:
                      "${state.users.first.familyName!} ${state.users.first.fatherName!} ${state.users.first.grandfatherName!} ${state.users.first.greatGrandfatherName!}",
                ),
                SizedBox(height: 5.h),
                UserDataWidget(
                    detailsText: "الاسره",
                    userDetails: state.users.first.familyName!),
                SizedBox(height: 5.h),
                UserDataWidget(
                    detailsText: "العمر", userDetails: state.users.first.age!),
                SizedBox(height: 5.h),
                UserDataWidget(
                    detailsText: "الجنس",
                    userDetails: state.users.first.gender!),
                SizedBox(height: 5.h),
                UserDataWidget(
                    detailsText: "رقم الجوال",
                    userDetails: state.users.first.phoneNumber!),
                SizedBox(height: 5.h),
                UserDataWidget(
                    detailsText: "حاله الاب",
                    userDetails: state.users.first.fatherLiveORDead!),
                SizedBox(height: 5.h),
                UserDataWidget(
                    detailsText: "حاله الجد",
                    userDetails: state.users.first.grandfatherLiveORDead!),
                SizedBox(height: 5.h),
                UserDataWidget(
                    detailsText: "حاله الاب للجد",
                    userDetails: state.users.first.greatGrandFatherLiveOrDead!),

                // Text(state.user.email),
                // Text(state.user.phone),
              ],
            ),
          );
        } else {
          return Text(" no data");
        }
      },
    );
  }
}

class ItemInDrawer extends StatelessWidget {
  const ItemInDrawer({
    super.key,
    this.onTap,
    this.icon,
    required this.text,
  });
  final void Function()? onTap;
  final IconData? icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(9.h),
        margin: EdgeInsets.only(right: 9.h, left: 9.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 21.w,
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(text,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
