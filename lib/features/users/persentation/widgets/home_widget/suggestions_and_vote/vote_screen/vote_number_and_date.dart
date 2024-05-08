import 'package:el_erinat/features/users/persentation/widgets/home_widget/suggestions_and_vote/vote_screen/vote_date.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/suggestions_and_vote/vote_screen/vote_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoteNumberAndDate extends StatelessWidget {
  const VoteNumberAndDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: EdgeInsets.only(top: 5.h, right: 15.w, left: 15.w),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const VoteDate(),
          SizedBox(
            width: 10.w,
          ),
          const VoteNumber()
        ],
      ),
    );
  }
}
