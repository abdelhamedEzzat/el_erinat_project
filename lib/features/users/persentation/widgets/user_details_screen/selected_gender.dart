import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/config/list_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedGender extends StatelessWidget {
  const SelectedGender({super.key, this.onChanged, required this.value});
  final void Function(String?)? onChanged;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      height: 45.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorManger.logoColor.withOpacity(0.6),
        borderRadius: BorderRadius.all(Radius.circular(7.w)),
      ),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(15),
        isExpanded: true,
        value: value,
        icon: Icon(
          Icons.arrow_drop_down,
          size: 25.h,
          color: Colors.black,
        ),
        elevation: 16,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.w,
          fontWeight: FontWeight.normal,
        ),
        underline: Container(
          height: 2,
          color: Colors.transparent,
        ),
        onChanged: onChanged,
        items: gender.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
