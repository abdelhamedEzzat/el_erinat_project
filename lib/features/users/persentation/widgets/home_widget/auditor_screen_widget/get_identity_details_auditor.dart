import 'dart:io';

import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/work_personal_details_cubit/work_personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/finished_user_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/auditor_screen_widget/get_call_to_user_widget_in_auditor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetIDentityDetailsForAuditor extends StatefulWidget {
  const GetIDentityDetailsForAuditor({
    super.key,
    required this.userUID,
  });
  final String userUID;
  @override
  State<GetIDentityDetailsForAuditor> createState() =>
      _GetIDentityDetailsForAuditorState();
}

class _GetIDentityDetailsForAuditorState
    extends State<GetIDentityDetailsForAuditor> {
  @override
  void initState() {
    BlocProvider.of<WorkPersonalDetailsCubit>(context)
        .fetchImageForAuditor(widget.userUID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkPersonalDetailsCubit, WorkPersonalDetailsState>(
      builder: (context, state) {
        if (state is WorkPersonalDetailsUserDataForAuditorLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WorkPersonalDetailsUserDataForAuditorLoaded) {
          if (state.user!.uID == widget.userUID &&
              state.user!.imagePath != null &&
              state.user!.imagePath!.isNotEmpty) {
            // Check if imagePath is a URL or a local path
            final imagePath = state.user!.imagePath!;
            final isUrl = Uri.tryParse(imagePath)?.hasAbsolutePath ?? false;

            return Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w),
              // height: 200,
              width: MediaQuery.of(context).size.width,
              child: isUrl
                  ? Image.network(
                      imagePath,
                      width: MediaQuery.of(context).size.width,
                    )
                  : Image.file(
                      File(imagePath),
                      width: MediaQuery.of(context).size.width,
                    ),
            );
          } else if (state.user!.imagePath == null &&
              state.user!.imagePath!.isEmpty) {
            return GetCallToUSer(
              userUID: widget.userUID,
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Center(
                child: Text(
                    "طلب المستخدم اتصال من قبل المشرفين للتاكد من الهويه",
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    style: TextStyle(
                        color: ColorManger.logoColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            );
          }
        } else {
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Center(
              child: Text("طلب المستخدم اتصال من قبل المشرفين للتاكد من الهويه",
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  style: TextStyle(
                      color: ColorManger.logoColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          );
        }
      },
    );
  }
}
