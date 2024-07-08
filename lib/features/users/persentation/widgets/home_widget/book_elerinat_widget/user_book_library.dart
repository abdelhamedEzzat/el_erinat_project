import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserBookLibarary extends StatelessWidget {
  const UserBookLibarary({
    super.key,
    required this.bookImage,
  });

  final List<String> bookImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 50.w,
              mainAxisSpacing: 15.h,
            ),
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorManger.logoColor)),
                child: Image.asset(
                  bookImage[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 25.h,
        ),
      ],
    );
  }
}
