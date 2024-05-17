import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/book_elerinat_widget/user_book_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminUploadAndBookLibrary extends StatelessWidget {
  const AdminUploadAndBookLibrary({
    super.key,
    required this.bookImage,
  });
  final List<String> bookImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const UplaodBook(),
        UserBookLibarary(
          bookImage: bookImage,
        )
      ],
    );
  }
}

class UplaodBook extends StatelessWidget {
  const UplaodBook({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 19.h, vertical: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 19.h, vertical: 20.h),
        color: ColorManger.logoColor.withOpacity(0.6),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.upload,
              size: 25.h,
              color: Colors.white,
            ),
            Text(
              MStrings.uploadBook,
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
