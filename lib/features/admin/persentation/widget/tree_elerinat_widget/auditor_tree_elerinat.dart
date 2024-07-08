import 'package:el_erinat/core/helpers/open_pdf_method.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/admin/data/model/upload_tree_model.dart';
import 'package:el_erinat/features/admin/persentation/cubit/tree_elerinat/tree_elerinat_cubit.dart';
import 'package:el_erinat/features/admin/persentation/widget/tree_elerinat_widget/all_families.dart';
import 'package:el_erinat/features/admin/persentation/widget/tree_elerinat_widget/auditor_family_widget.dart';
import 'package:el_erinat/features/admin/persentation/widget/tree_elerinat_widget/upload_tree_widget.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/get_tree_cubit/get_tree_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuditorTreesOfElerinatUser extends StatefulWidget {
  const AuditorTreesOfElerinatUser({
    super.key,
  });

  @override
  State<AuditorTreesOfElerinatUser> createState() =>
      _AuditorTreesOfElerinatUserState();
}

class _AuditorTreesOfElerinatUserState
    extends State<AuditorTreesOfElerinatUser> {
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const UploadTree(),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 20.h,
        ),
        BlocBuilder<TreeElerinatCubit, TreeElerinatState>(
          builder: (context, state) {
            if (state is GetAuditorTreeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetAuditorTreeSuccess) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 20.w),
                      child: Text(
                        "الاسر التي اشرف عليها",
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
                        onTap: () async {
                          String? update = await Navigator.of(context)
                              .pushNamed(
                                  ConstantsRouteString.detailsOfFamilyAuditor,
                                  arguments: {
                                "id": uploadTreeModel.id,
                                "familyName": uploadTreeModel.familyName,
                                "familyLineage": uploadTreeModel.familyLineage,
                                "pdfName": uploadTreeModel.pdfName,
                                "pdfPath": uploadTreeModel.pdfPath,
                              }) as String?;

                          if (update == "Success update tree") {
                            if (mounted) {
                              // ignore: use_build_context_synchronously
                              await BlocProvider.of<TreeElerinatCubit>(context)
                                  .fetchAuditorElerinatFamilyTree(
                                      FirebaseAuth.instance.currentUser!.uid);

                              // ignore: use_build_context_synchronously
                              await BlocProvider.of<GetTreeCubit>(context)
                                  .fetchAllElerinatFamilyTree();
                            }
                          }
                        },
                        child: Column(
                          children: [
                            AuditorFamily(
                              familyName: uploadTreeModel.familyName.toString(),
                              familyLineage:
                                  uploadTreeModel.familyLineage.toString(),
                            ),
                            SizedBox(height: 15.h),
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(),
                ],
              );
            } else if (state is GetAuditorTreeError) {
              return Center(child: Text(state.failure.toString()));
            }
            return Container();
          },
        ),
        SizedBox(height: 15.h),
        BlocBuilder<GetTreeCubit, GetTreeState>(
          builder: (context, state) {
            if (state is GetAllTreeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetAllTreeSuccess) {
              return Column(
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
              );
            } else if (state is GetAllTreeError) {
              return Center(child: Text(state.failure.toString()));
            }
            return const Center(child: Text("Something went wrong"));
          },
        )
      ]),
    ));
  }
}
