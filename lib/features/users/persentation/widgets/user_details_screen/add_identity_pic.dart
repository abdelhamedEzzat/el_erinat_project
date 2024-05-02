import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddIdentityPic extends StatelessWidget {
  const AddIdentityPic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: ColorManger.logoColor.withOpacity(0.5),
        width: MediaQuery.of(context).size.width,
        height: 200.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 25.h,
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              MStrings.addIdedntatyPic,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
