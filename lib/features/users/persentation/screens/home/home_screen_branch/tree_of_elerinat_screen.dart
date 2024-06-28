// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:el_erinat/features/admin/persentation/widget/tree_elerinat_widget/auditor_tree_elerinat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';

class TreeOfElerinatScreen extends StatefulWidget {
  const TreeOfElerinatScreen({super.key});

  @override
  State<TreeOfElerinatScreen> createState() => _TreeOfElerinatScreenState();
}

class _TreeOfElerinatScreenState extends State<TreeOfElerinatScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    bool isAdmin = arguments['isAdmin'];
    bool isAuditor = arguments['isAuditor'];
    return BackGroundAndAppBarAndDaynamicBody(
      alignmentTitle: Alignment.center,
      titleName: MStrings.treeOfElerinat,
      yourBodyOfScreen: isAdmin
          ? const AuditorTreesOfElerinatUser()
          : isAuditor
              ? const AuditorTreesOfElerinatUser()
              : const TreesOfElerinatUser(),
    );
  }
}

class TreesOfElerinatUser extends StatelessWidget {
  const TreesOfElerinatUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // print('clicked');
        },
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManger.logoColor.withOpacity(0.5),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'أسر الحمادى',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontSize: 14.w, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      color: ColorManger.logoColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              'من آل أبي ربّاع من بكر بن وائل من ربيعة بن نزار بن معدّ بن عدنان',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(fontSize: 14.w),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
            // ),
          ),
        ));
  }
}
