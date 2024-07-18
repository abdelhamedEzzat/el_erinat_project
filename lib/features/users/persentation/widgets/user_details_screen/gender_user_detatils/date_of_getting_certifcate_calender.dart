import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateOfGettingCertificateCalender extends StatefulWidget {
  const DateOfGettingCertificateCalender({
    super.key,
    required this.textIftrue,
    required this.isHijridate,
    required this.onDateSelected,
    this.isBirthday,
  });
  final String textIftrue;
  final bool isHijridate;
  final bool? isBirthday;
  final Function(String, bool) onDateSelected;

  @override
  State<DateOfGettingCertificateCalender> createState() =>
      _DateOfGettingCertificateCalenderState();
}

class _DateOfGettingCertificateCalenderState
    extends State<DateOfGettingCertificateCalender> {
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
          title: widget.isBirthday == true
              ? Text(
                  MStrings.chooseYourBirthday,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 12.h,
                      fontWeight: FontWeight.bold,
                      color: ColorManger.logoColor),
                )
              : Text(
                  " تاريخ الحصول علي الشهاده",
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
                widget.onDateSelected(selectedDate, true);
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
        height: 44.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: ColorManger.appBarColor),
          borderRadius: BorderRadius.circular(7.w),
        ),
        child: widget.isHijridate
            ? Text(
                " ${widget.textIftrue}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 10.h,
                    fontWeight: FontWeight.bold,
                    color: ColorManger.balckColor),
              )
            : Text(
                MStrings.dateofobtainingthecertificate,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 10.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
              ),
      ),
    );
  }
}
