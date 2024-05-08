import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedVoteContainer extends StatelessWidget {
  const AnimatedVoteContainer({super.key, this.colors, this.textOfVote});
  final Color? colors;
  final String? textOfVote;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(alignment: Alignment.centerLeft, children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: colors ?? Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8.w)),
          height: 48.h,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 100.w,
          decoration: BoxDecoration(
              color: colors ?? Colors.black,
              borderRadius: BorderRadius.circular(8.w)),
          height: 48.h,
        ),
        Container(
          padding: EdgeInsets.only(left: 25.w),
          alignment: Alignment.centerLeft,
          child: Text(
            textAlign: TextAlign.center,
            textOfVote ?? " موافق",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }
}
