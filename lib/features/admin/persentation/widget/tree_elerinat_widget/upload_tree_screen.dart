import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_app_bar.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/core/helpers/file_picker.dart';
import 'package:el_erinat/features/admin/data/model/upload_tree_model.dart';
import 'package:el_erinat/features/admin/data/repo_admin/admin_repo_impelment.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/admin_local_data_base_helper.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/remote_data_base_helper.dart';
import 'package:el_erinat/features/admin/persentation/widget/tree_elerinat_widget/upload_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
                              Navigator.of(context).pop("Success upload tree");
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
