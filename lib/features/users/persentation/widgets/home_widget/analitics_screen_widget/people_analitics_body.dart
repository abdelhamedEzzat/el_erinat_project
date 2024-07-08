import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/analitics_screen_widget/analitics_items_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PeopleAnaliticsBody extends StatelessWidget {
  const PeopleAnaliticsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 150.h,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnaliticsItemsRow(
                leftNumber: "10",
                leftText: MStrings.numberOfTripPeople,
                rightNumber: "20",
                rightText: MStrings.numberOfFamilies,
              ),
              SizedBox(
                height: 35.h,
              ),
              AnaliticsItemsRow(
                leftNumber: "30",
                leftText: MStrings.familyMembers,
                rightNumber: "40",
                rightText: MStrings.theRemainingMales,
              ),
              SizedBox(
                height: 35.h,
              ),
              // AnaliticsItemsRow(
              //   leftNumber: "50",
              //   leftText: MStrings.departedMales,
              //   rightNumber: "60",
              //   rightText: MStrings.departedFemales,
              // ),
              // SizedBox(
              //   height: 35.h,
              // ),
              AnaliticsItemsRow(
                leftNumber: "70",
                leftText: MStrings.totalNeighborhoods,
                rightNumber: "80",
                rightText: MStrings.totalDead,
              ),
              SizedBox(
                height: 35.h,
              ),
              AnaliticsItemsRow(
                leftNumber: "90",
                leftText: MStrings.maleNames,
                rightNumber: "100",
                rightText: MStrings.femaleNames,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
