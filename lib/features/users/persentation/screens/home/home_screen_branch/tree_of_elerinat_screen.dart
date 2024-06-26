// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:el_erinat/core/helpers/open_pdf_method.dart';
import 'package:el_erinat/features/admin/persentation/widget/admin_book_screen/admin_upload_book_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_app_bar.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/core/helpers/file_picker.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/admin/data/model/upload_tree_model.dart';
import 'package:el_erinat/features/admin/data/repo_admin/admin_repo_impelment.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/admin_local_data_base_helper.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/remote_data_base_helper.dart';

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

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

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
  AdminRepoImplementation adminRepoImplementation = AdminRepoImplementation(
    adminLocalDatabaseHelper: AdminLocalDatabaseHelper(),
    adminRemoteDataBaseHelper: AdminRemoteDataBaseHelper(),
  );
  late Future<List<UploadTreeModel>> auditorTreesFuture;
  late Future<List<UploadTreeModel>> allTreesFuture;

  // }
  @override
  void initState() {
    super.initState();
    adminRepoImplementation = AdminRepoImplementation(
      adminLocalDatabaseHelper: AdminLocalDatabaseHelper(),
      adminRemoteDataBaseHelper: AdminRemoteDataBaseHelper(),
    );
    loadData();
  }

  void loadData() {
    setState(() {
      auditorTreesFuture = adminRepoImplementation
          .getAuditortrees(FirebaseAuth.instance.currentUser!.uid);
      allTreesFuture = adminRepoImplementation.getAlltrees();
    });
  }

  @override
  Widget build(BuildContext context) {
    // AdminRepoImplementation adminRepoImplementation = AdminRepoImplementation(
    //     adminLocalDatabaseHelper: AdminLocalDatabaseHelper(),
    //     adminRemoteDataBaseHelper: AdminRemoteDataBaseHelper());

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
        FutureBuilder<List<UploadTreeModel>>(
            future: adminRepoImplementation
                .getAuditortrees(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Container();
                }
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
                    Divider(
                      thickness: 3,
                      endIndent: 20.w,
                      indent: 280.w,
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          UploadTreeModel uploadTreeModel =
                              snapshot.data![index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    ConstantsRouteString.detailsOfFamilyAuditor,
                                    arguments: {
                                      "familyName": uploadTreeModel.familyName,
                                      "familyLineage":
                                          uploadTreeModel.familyLineage,
                                      "pdfName": uploadTreeModel.pdfName,
                                      "pdfPath": uploadTreeModel.pdfPath,
                                    });
                              },
                              child: Column(
                                children: [
                                  AuditorFamily(
                                    familyName:
                                        uploadTreeModel.familyName.toString(),
                                    familyLineage: uploadTreeModel.familyLineage
                                        .toString(),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                ],
                              ));
                        }),
                    const Divider(),
                  ],
                );
              }
              return const Center(child: Text("لا يوجد اي بيانات"));
            }),
        SizedBox(
          height: 15.h,
        ),
        FutureBuilder<List<UploadTreeModel>>(
            future: adminRepoImplementation.getAlltrees(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
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
                    Divider(
                      thickness: 3,
                      endIndent: 20.w,
                      indent: 280.w,
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          UploadTreeModel uploadTreeModel =
                              snapshot.data![index];

                          return GestureDetector(
                            onTap: () {
                              openPDF(
                                  context,
                                  //uploadTreeModel.pdfUrl!,
                                  "https://firebasestorage.googleapis.com/v0/b/elerinat-f7190.appspot.com/o/FamilyTree%2Fpdfs%2Fimages_bd791441603b8beaf14cd9e119133303-Simple-resume-template.pdf?alt=media&token=cfc47383-0dc7-4230-ad43-ee734eaf63fa");
                            },
                            child: AllFamilies(
                              familyName: uploadTreeModel.familyName.toString(),
                              familyLineage:
                                  uploadTreeModel.familyLineage.toString(),
                            ),
                          );
                        }),
                  ],
                );
              }
              return const Center(child: Text("لا يوجد اي بيانات"));
            })
      ]),
    ));
  }
}

class UploadTree extends StatefulWidget {
  const UploadTree({
    super.key,
  });

  @override
  State<UploadTree> createState() => _UploadTreeState();
}

class _UploadTreeState extends State<UploadTree> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String? upload = await Navigator.of(context)
            .pushNamed(ConstantsRouteString.uploadTreeScreen) as String?;
        if (upload == "تم التحميل بنجاح") {
          // ignore: use_build_context_synchronously
          context
              .findAncestorStateOfType<_AuditorTreesOfElerinatUserState>()
              ?.loadData();
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

class AuditorFamily extends StatelessWidget {
  const AuditorFamily({
    super.key,
    required this.familyLineage,
    required this.familyName,
  });
  final String familyLineage;
  final String familyName;
  @override
  Widget build(BuildContext context) {
    return Container(
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
            familyName,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 14.w, fontWeight: FontWeight.bold),
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
                    familyLineage,
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
    );
  }
}

class AllFamilies extends StatelessWidget {
  const AllFamilies({
    Key? key,
    required this.familyLineage,
    required this.familyName,
  }) : super(key: key);
  final String familyLineage;
  final String familyName;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 20.h,
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
        child: Column(children: [
          Text(
            familyName,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 14.w, fontWeight: FontWeight.bold),
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
                    familyLineage,
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
        ]),
      ),
    ]);
  }
}

class UploadTreeScreen extends StatefulWidget {
  const UploadTreeScreen({super.key});

  @override
  State<UploadTreeScreen> createState() => _UploadTreeScreenState();
}

class _UploadTreeScreenState extends State<UploadTreeScreen> {
  String? localImage;
  String? localPDF;
  String? pdfFileName;

  FilePickerResult? result;

  UploadTreeModel uploadTreeModel = UploadTreeModel();

  bool isLoading = false;

  AdminRepoImplementation adminRepoImplementation = AdminRepoImplementation(
    adminLocalDatabaseHelper: AdminLocalDatabaseHelper(),
    adminRemoteDataBaseHelper: AdminRemoteDataBaseHelper(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          alignmentTitle: Alignment.center,
          title: Text(
            MStrings.uploadFamilyPdf,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14.w,
                color: ColorManger.white),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final pickedFile = await pickPdfFile();
                            if (pickedFile != null) {
                              setState(() {
                                localPDF = pickedFile.path;
                                pdfFileName = pickedFile.path.split('/').last;
                                uploadTreeModel.pdfPath = pickedFile.path;
                              });
                            }
                          },
                          child: localPDF != null
                              ? Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorManger.logoColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.picture_as_pdf,
                                        color: ColorManger.logoColor,
                                        size: 40.h,
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Text(
                                          pdfFileName ?? '',
                                          style: TextStyle(
                                            color: ColorManger.logoColor,
                                            fontSize: 16.sp,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : UploadContainer(
                                  containerColor: ColorManger.white,
                                  iconColor: ColorManger.logoColor,
                                  textColor: ColorManger.logoColor,
                                  icon: Icons.picture_as_pdf,
                                  titleText: MStrings.uploadFamilyPdf,
                                ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          minLines: 1,
                          maxLines: 7,
                          labelText: Text(
                            MStrings.uploadFamilyName,
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: ColorManger.logoColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                          ),
                          onChanged: (p0) {
                            setState(() {});
                            uploadTreeModel.familyName = p0;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          minLines: 1,
                          maxLines: 15,
                          labelText: Text(
                            MStrings.uploadFamilyLineage,
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: ColorManger.logoColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                          ),
                          onChanged: (p0) {
                            setState(() {});
                            uploadTreeModel.familyLineage = p0;
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        BottonClick(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          onTap: () async {
                            uploadTreeModel.pdfName = pdfFileName;
                            setState(() {
                              isLoading = true;
                            });
                            await adminRepoImplementation
                                .uploadAndSavetree(
                                    uploadTreeModel: uploadTreeModel)
                                .whenComplete(() {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context).pop("تم التحميل بنجاح");
                            });
                          },
                          text: MStrings.uploadBook,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  // ),
  //  );
}
//}

class DetailsOfFamilyAuditor extends StatefulWidget {
  const DetailsOfFamilyAuditor({super.key});

  @override
  State<DetailsOfFamilyAuditor> createState() => _DetailsOfFamilyAuditorState();
}

class _DetailsOfFamilyAuditorState extends State<DetailsOfFamilyAuditor> {
  String? localImage;
  String? localPDF;
  String? pdfFileName;

  FilePickerResult? result;

  UploadTreeModel uploadTreeModel = UploadTreeModel();

  bool isLoading = false;

  AdminRepoImplementation adminRepoImplementation = AdminRepoImplementation(
    adminLocalDatabaseHelper: AdminLocalDatabaseHelper(),
    adminRemoteDataBaseHelper: AdminRemoteDataBaseHelper(),
  );
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final pdfName = arguments["pdfName"];
    final familyName = arguments["familyName"];
    final familyLineage = arguments["familyLineage"];
    final pdfPath = arguments["pdfPath"];
    return Scaffold(
        appBar: CustomAppBar(
          alignmentTitle: Alignment.center,
          title: Text(
            MStrings.detailsOfFamilyAuditor,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14.w,
                color: ColorManger.white),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final pickedFile = await pickPdfFile();
                            if (pickedFile != null) {
                              setState(() {
                                localPDF = pickedFile.path;
                                pdfFileName = pickedFile.path.split('/').last;
                                uploadTreeModel.pdfPath = pickedFile.path;
                              });
                            }
                          },
                          child: localPDF != null
                              ? Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorManger.logoColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.picture_as_pdf,
                                        color: ColorManger.logoColor,
                                        size: 40.h,
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Text(
                                          pdfFileName ?? '',
                                          style: TextStyle(
                                            color: ColorManger.logoColor,
                                            fontSize: 16.sp,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : pdfName != null
                                  ? Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorManger.logoColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.picture_as_pdf,
                                            color: ColorManger.logoColor,
                                            size: 40.h,
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: Text(
                                              pdfName ?? '',
                                              style: TextStyle(
                                                color: ColorManger.logoColor,
                                                fontSize: 16.sp,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : UploadContainer(
                                      containerColor: ColorManger.white,
                                      iconColor: ColorManger.logoColor,
                                      textColor: ColorManger.logoColor,
                                      icon: Icons.picture_as_pdf,
                                      titleText: MStrings.uploadFamilyPdf,
                                    ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          minLines: 1,
                          maxLines: 7,
                          labelText: Text(
                            familyName,
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: ColorManger.logoColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                          ),
                          onChanged: (p0) {
                            setState(() {});
                            uploadTreeModel.familyName = p0;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          minLines: 1,
                          maxLines: 15,
                          labelText: Text(
                            familyLineage,
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: ColorManger.logoColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                          ),
                          onChanged: (p0) {
                            setState(() {});
                            uploadTreeModel.familyLineage = p0;
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        BottonClick(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await adminRepoImplementation
                                .uploadAndSavetree(
                                    uploadTreeModel: uploadTreeModel)
                                .whenComplete(() {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context).pop(true);
                            });
                          },
                          text: MStrings.uploadBook,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class UploadContainer extends StatelessWidget {
  const UploadContainer({
    super.key,
    required this.containerColor,
    required this.iconColor,
    required this.textColor,
    required this.icon,
    required this.titleText,
  });
  final Color containerColor;
  final Color iconColor;
  final Color textColor;
  final String titleText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 165.h,
      decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorManger.logoColor, width: 1.w)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 35.w,
              color: iconColor,
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              titleText,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: textColor, fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
