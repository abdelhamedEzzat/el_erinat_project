import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PicOfNewsItem extends StatelessWidget {
  const PicOfNewsItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 9,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Hero(
          tag: "news_image",
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.h), topRight: Radius.circular(5.h)),
            child: Image.asset(
              "assets/photo/bookCover2.jpg",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
