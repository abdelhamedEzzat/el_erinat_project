import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoteNumber extends StatelessWidget {
  const VoteNumber({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          textAlign: TextAlign.end,
          maxLines: 15,
          overflow: TextOverflow.ellipsis,
          MStrings.vote,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          textAlign: TextAlign.end,
          maxLines: 15,
          overflow: TextOverflow.ellipsis,
          "39",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
