import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminAuditorAndVoteText extends StatelessWidget {
  const AdminAuditorAndVoteText({
    super.key,
    required this.text,
    this.style,
  });
  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text(textAlign: TextAlign.end, text, style: style),
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          "-",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
