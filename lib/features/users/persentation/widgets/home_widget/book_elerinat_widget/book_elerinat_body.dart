import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookElerinatBody extends StatelessWidget {
  const BookElerinatBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> bookImage = [
      "assets/photo/bookCover.png",
      "assets/photo/bookCover2.jpg",
      "assets/photo/bookCover2.jpg",
      "assets/photo/bookCover.png",
      "assets/photo/bookCover.png",
      "assets/photo/bookCover2.jpg",
    ];
    return Positioned.fill(
      top: kToolbarHeight,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 50.w,
                  mainAxisSpacing: 20.h,
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
        ),
      ),
    );
  }
}
