import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/slide_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllSlidesWidget extends StatelessWidget {
  const AllSlidesWidget({
    super.key,
    required this.colors1,
    required this.colors2,
  });
  final Color colors1;
  final Color colors2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SlideWidget(
          color: colors1,
        ),
        SizedBox(
          width: 15.w,
        ),
        SlideWidget(
          color: colors2,
        ),
      ],
    );
  }
}
