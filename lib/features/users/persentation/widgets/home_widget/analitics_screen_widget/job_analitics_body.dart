import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/work_personal_details_cubit/work_personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/analitics_screen_widget/analitics_items_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobAnaliticsBody extends StatefulWidget {
  const JobAnaliticsBody({super.key});

  @override
  State<JobAnaliticsBody> createState() => _JobAnaliticsBodyState();
}

class _JobAnaliticsBodyState extends State<JobAnaliticsBody> {
  @override
  void initState() {
    BlocProvider.of<WorkPersonalDetailsCubit>(context).fetchJobAnalitics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkPersonalDetailsCubit, WorkPersonalDetailsState>(
      listener: (context, state) {
        // if (state is WorkPersonalDetailsLoaded) {
        //   for (var user in st ate.users) {

        //   }
        // }
      },
      builder: (context, state) {
        if (state is GetJobAnaliticsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetJobAnaliticsLoaded) {
          return Positioned.fill(
            top: 150.h,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnaliticsItemsRow(
                      leftNumber: state.jobAnalitics.judge.toString(),
                      leftText: MStrings.judgeJob,
                      rightNumber:
                          state.jobAnalitics.holdsAdoctorate.toString(),
                      rightText: MStrings.holdsaDoctorate,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    AnaliticsItemsRow(
                      leftNumber: state.jobAnalitics.holdsAmaster.toString(),
                      leftText: MStrings.mastersDegree,
                      rightNumber: state.jobAnalitics.doctor.toString(),
                      rightText: MStrings.doctor,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    AnaliticsItemsRow(
                      leftNumber: state.jobAnalitics.pharmaceutical.toString(),
                      leftText: MStrings.pharmaceutical,
                      rightNumber: state.jobAnalitics.engineer.toString(),
                      rightText: MStrings.engineer,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    AnaliticsItemsRow(
                      leftNumber: state.jobAnalitics.accountant.toString(),
                      leftText: MStrings.accountant,
                      rightNumber: state.jobAnalitics.oficer.toString(),
                      rightText: MStrings.officer,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    AnaliticsItemsRow(
                      leftNumber: state.jobAnalitics.pilot.toString(),
                      leftText: MStrings.pilot,
                      rightNumber: state.jobAnalitics.teachers.toString(),
                      rightText: MStrings.teachers,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    AnaliticsItemsRow(
                      leftNumber: state.jobAnalitics.student.toString(),
                      leftText: MStrings.student,
                      rightNumber: state.jobAnalitics.factor.toString(),
                      rightText: MStrings.factor,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is JobAnaliticsDetailsError) {
          return Center(child: Text("Error: ${state.failure}"));
        } else {
          return Center(child: Text("An unexpected state occurred"));
        }
      },
    );
  }
}
