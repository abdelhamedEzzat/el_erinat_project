import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/analitics_screen_widget/analitics_items_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobAnaliticsBody extends StatelessWidget {
  const JobAnaliticsBody({super.key});

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
                leftText: MStrings.judgeJob,
                rightNumber: "20",
                rightText: MStrings.holdsaDoctorate,
              ),
              SizedBox(
                height: 35.h,
              ),
              AnaliticsItemsRow(
                leftNumber: "30",
                leftText: MStrings.mastersDegree,
                rightNumber: "40",
                rightText: MStrings.doctor,
              ),
              SizedBox(
                height: 35.h,
              ),
              AnaliticsItemsRow(
                leftNumber: "50",
                leftText: MStrings.pharmaceutical,
                rightNumber: "60",
                rightText: MStrings.engineer,
              ),
              SizedBox(
                height: 35.h,
              ),
              AnaliticsItemsRow(
                leftNumber: "70",
                leftText: MStrings.accountant,
                rightNumber: "80",
                rightText: MStrings.officer,
              ),
              SizedBox(
                height: 35.h,
              ),
              AnaliticsItemsRow(
                leftNumber: "90",
                leftText: MStrings.pilot,
                rightNumber: "100",
                rightText: MStrings.teachers,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
