import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsDate extends StatelessWidget {
  const NewsDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.topRight,
        padding: EdgeInsets.only(top: 5.h, right: 15.w, left: 15.w),
        width: MediaQuery.of(context).size.width,
        child: Text(
          textAlign: TextAlign.end,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          "13-03-2024",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white, fontSize: 12.h, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
