// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:el_erinat/core/helpers/open_pdf_method.dart';
import 'package:el_erinat/features/admin/data/model/upload_tree_model.dart';
import 'package:el_erinat/features/admin/persentation/cubit/tree_elerinat/tree_elerinat_cubit.dart';
import 'package:el_erinat/features/admin/persentation/widget/tree_elerinat_widget/all_families.dart';
import 'package:el_erinat/features/admin/persentation/widget/tree_elerinat_widget/auditor_tree_elerinat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return SafeArea(
        child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        height: 20.h,
      ),
      BlocConsumer<TreeElerinatCubit, TreeElerinatState>(
        listener: (context, state) async {
          if (state is UploadTreeSuccess) {
            BlocProvider.of<TreeElerinatCubit>(context).addFamilyItem(
              state.tree,
            );
          }
        },
        builder: (context, state) {
          if (state is GetAuditorTreeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetAuditorTreeSuccess) {
            return
                //state.id == FirebaseAuth.instance.currentUser!.uid
                //   ?
                Column(children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 20.w),
                      child: Text(
                        "جميع الاسر",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontSize: 14.w, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Divider(thickness: 3, endIndent: 20.w, indent: 280.w),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.tree.length,
                    itemBuilder: (context, index) {
                      UploadTreeModel uploadTreeModel = state.tree[index];
                      return GestureDetector(
                        onTap: () {
                          openPDF(context, uploadTreeModel.pdfUrl!);
                        },
                        child: AllFamilies(
                          familyName: uploadTreeModel.familyName.toString(),
                          familyLineage:
                              uploadTreeModel.familyLineage.toString(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ]);
          } else if (state is GetAuditorTreeError) {
            return Center(child: Text(state.failure.toString()));
          }
          return Container();
        },
      ),
      SizedBox(height: 15.h),
    ])));
  }
}
