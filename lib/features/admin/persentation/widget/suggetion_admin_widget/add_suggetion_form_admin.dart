import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/suggetions_and_vote/suggtions_and_vote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSuggetionFromAdmin extends StatelessWidget {
  const AddSuggetionFromAdmin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final isUpladed = Navigator.of(context)
            .pushNamed(ConstantsRouteString.adminAddSuggetions);
        if (isUpladed == "Success upload suggetion") {
          BlocProvider.of<SuggtionsAndVoteCubit>(context).getSuggetions();
        }
        ;
      },
      child: Container(
        margin:
            EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w, bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 19.h, vertical: 20.h),
        color: ColorManger.subScreenscontainerColor.withOpacity(0.9),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.add_task_sharp,
              size: 25.h,
              color: Colors.white,
            ),
            Text(
              MStrings.addSuggetion,
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
