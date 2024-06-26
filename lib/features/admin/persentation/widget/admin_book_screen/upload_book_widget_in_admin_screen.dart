import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/admin/persentation/cubit/book_cubit/upload_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadBook extends StatelessWidget {
  const UploadBook({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String? uploadBook = await Navigator.of(context)
            .pushNamed(ConstantsRouteString.uploadBookScreen) as String?;

        if (uploadBook == "Success upload book") {
          BlocProvider.of<UploadBookCubit>(context).fetchBookImage();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 19.h, vertical: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 19.h, vertical: 20.h),
        color: ColorManger.subScreenscontainerColor,
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
