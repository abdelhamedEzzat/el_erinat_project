import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.leading,
    this.onPressed,
    this.bottom,
    required this.alignmentTitle,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  final Widget? title;
  final Widget? leading;
  final void Function()? onPressed;
  final PreferredSizeWidget? bottom;
  final AlignmentGeometry alignmentTitle;
  @override
  Size get preferredSize => Size.fromHeight(70.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: widget.bottom,
      toolbarHeight: 70.h,

      surfaceTintColor: ColorManger.logoColor,

      title: Align(alignment: widget.alignmentTitle, child: widget.title),
      titleTextStyle: TextStyle(
        fontSize: 14.sp,
      ),
      leading: widget.leading,
      iconTheme: IconThemeData(size: 18.h, color: Colors.white),
      elevation: 0,
      backgroundColor: ColorManger.logoColor
          .withOpacity(0.7), // Set the desired background color
    );
  }
}
