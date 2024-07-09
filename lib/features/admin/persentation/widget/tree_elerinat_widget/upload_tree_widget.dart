import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/admin/persentation/cubit/tree_elerinat/tree_elerinat_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/color_manger.dart';

class UploadTree extends StatelessWidget {
  const UploadTree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String? upload = await Navigator.of(context)
            .pushNamed(ConstantsRouteString.uploadTreeScreen) as String?;
        if (upload == "Success upload tree") {
          await BlocProvider.of<TreeElerinatCubit>(context)
              .fetchAuditorElerinatFamilyTree(
                  FirebaseAuth.instance.currentUser!.uid);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 19.h, vertical: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 19.h, vertical: 20.h),
        color: ColorManger.subScreenscontainerColor,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.upload,
              size: 25.h,
              color: Colors.white,
            ),
            Text(
              MStrings.uploadFamily,
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
