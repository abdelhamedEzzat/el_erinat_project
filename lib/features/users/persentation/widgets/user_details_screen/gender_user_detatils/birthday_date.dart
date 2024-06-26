import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BithDayDate extends StatelessWidget {
  const BithDayDate({
    super.key,
    required this.textIftrue,
    required this.isHijridate,
    required this.onDateSelected,
  });

  final String textIftrue;
  final bool isHijridate;
  final Function(String, bool) onDateSelected;

  void _openHijriDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            TextButton(
              child: Text(
                MStrings.thatsItMyBirthday,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 12.h,
                    fontWeight: FontWeight.bold,
                    color: ColorManger.logoColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          title: Text(
            MStrings.chooseYourBirthday,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 12.h,
                fontWeight: FontWeight.bold,
                color: ColorManger.logoColor),
          ),
          content: SizedBox(
            height: 350.h,
            width: 300.w,
            child: SfHijriDateRangePicker(
              selectionColor: ColorManger.logoColor,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                final List<String> hijriMonths = [
                  'Muharram',
                  'Safar',
                  'Rabi\' al-Awwal',
                  'Rabi\' al-Thani',
                  'Jumada al-Awwal',
                  'Jumada al-Thani',
                  'Rajab',
                  'Sha\'ban',
                  'Ramadan',
                  'Shawwal',
                  'Dhu al-Qi\'dah',
                  'Dhu al-Hijjah'
                ];
                final hijriDate = args.value;
                final selectedDate =
                    '${hijriDate.day} - ${hijriMonths[hijriDate.month - 1]} - ${hijriDate.year}';
                onDateSelected(selectedDate, true);
              },
              selectionMode: DateRangePickerSelectionMode.single,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openHijriDatePicker(context);
      },
      child: Container(
        padding: EdgeInsets.only(right: 14.w),
        alignment: Alignment.centerRight,
        height: 46.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: ColorManger.appBarColor),
          borderRadius: BorderRadius.circular(7.w),
        ),
        child: isHijridate
            ? Text(
                " $textIftrue : تاريخ ميلادك",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 12.h,
                      fontWeight: FontWeight.bold,
                      color: ColorManger.balckColor,
                    ),
              )
            : Text(
                " اكتب تاريخ ميلادك",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 12.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
              ),
      ),
    );
  }
}
