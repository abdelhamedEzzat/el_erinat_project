import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubTitleInUserDetailsScreen extends StatelessWidget {
  const SubTitleInUserDetailsScreen({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Colors.grey.shade500)
          .copyWith(fontSize: 14.h),
    );
  }
}
