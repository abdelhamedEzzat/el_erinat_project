import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_state.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/analitics_screen_widget/analitics_items_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PeopleAnaliticsBody extends StatefulWidget {
  const PeopleAnaliticsBody({super.key});

  @override
  _PeopleAnaliticsBodyState createState() => _PeopleAnaliticsBodyState();
}

class _PeopleAnaliticsBodyState extends State<PeopleAnaliticsBody> {
  @override
  void initState() {
    super.initState();

    // Initial fetch of user data
    context.read<PersonalDetailsCubit>().fetchStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalDetailsCubit, PersonalDetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetStatisticsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetStatisticsLoaded) {
          return Positioned.fill(
            top: 150.h,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnaliticsItemsRow(
                      leftNumber:
                          state.statistics.personalInFamilies.toString(),
                      leftText: MStrings.numberOfTripPeople,
                      rightNumber: state.statistics.allFamilies.toString(),
                      rightText: MStrings.numberOfFamilies,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    AnaliticsItemsRow(
                      leftNumber: "${state.statistics.totalMales}",
                      leftText: MStrings.totalMales,
                      rightNumber: "${state.statistics.totalFemales}",
                      rightText: MStrings.totalFemales,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    AnaliticsItemsRow(
                      leftNumber: state.statistics.liveMale.toString(),
                      leftText: MStrings.theRemainingMales,
                      rightNumber: state.statistics.totalFemales.toString(),
                      rightText: MStrings.theRemainingFemales,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    AnaliticsItemsRow(
                      leftNumber: state.statistics.totalLive.toString(),
                      leftText: MStrings.totalNeighborhoods,
                      rightNumber: state.statistics.totalDead.toString(),
                      rightText: MStrings.totalDead,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is PersonalDetailsError) {
          return Center(child: Text("Error: ${state.failure}"));
        } else {
          return Center(child: Text("An unexpected state occurred"));
        }
      },
    );
  }
}
