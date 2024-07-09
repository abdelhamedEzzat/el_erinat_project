import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseTypeOfNews extends StatelessWidget {
  const ChooseTypeOfNews({
    super.key,
    required this.items,
  });

  final List items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      height: 60.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorManger.logoColor.withOpacity(0.7),
          borderRadius: BorderRadius.all(Radius.circular(7.w))),
      child: DropdownButton(
          iconEnabledColor: Colors.white,
          hint: Text(
            MStrings.type,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          isExpanded: true,
          items: [
            DropdownMenuItem(
              value: items[0],
              child: Text(items[0]),
            ),
            DropdownMenuItem(
              value: items[1],
              child: Text(items[1]),
            )
          ],
          onChanged: (value) {}),
    );
  }
}
