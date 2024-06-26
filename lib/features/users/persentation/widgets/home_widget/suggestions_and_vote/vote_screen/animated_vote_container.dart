import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedVoteContainer extends StatefulWidget {
  const AnimatedVoteContainer({
    super.key,
    this.colors,
    this.textOfVote,
    this.onTap,
    required this.isEnabled,
    required this.percentage,
  });

  final Color? colors;
  final String? textOfVote;
  final void Function()? onTap;
  final bool isEnabled;
  final double percentage;

  @override
  State<AnimatedVoteContainer> createState() => _AnimatedVoteContainerState();
}

class _AnimatedVoteContainerState extends State<AnimatedVoteContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled ? widget.onTap : null,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: widget.colors ?? Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8.w),
            ),
            height: 48.h,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: MediaQuery.of(context).size.width * widget.percentage / 100,
            decoration: BoxDecoration(
              color: widget.colors ?? Colors.black,
              borderRadius: BorderRadius.circular(8.w),
            ),
            height: 48.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 25.w),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.textOfVote ?? "موافق",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorManger.logoColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.h),
            ),
          )
        ],
      ),
    );
  }
}
