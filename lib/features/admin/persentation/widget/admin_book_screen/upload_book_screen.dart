import 'dart:io';
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_app_bar.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/core/helpers/file_picker.dart';
import 'package:el_erinat/features/admin/data/model/upload_book_model.dart';
import 'package:el_erinat/features/admin/persentation/cubit/book_cubit/upload_book_cubit.dart';
import 'package:el_erinat/features/admin/persentation/widget/admin_book_screen/static_upload_container_for_book_admin_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadBookScreen extends StatefulWidget {
  const UploadBookScreen({super.key});
  @override
  State<UploadBookScreen> createState() => _UploadBookScreenState();
}

class _UploadBookScreenState extends State<UploadBookScreen> {
  String? localImage;
  String? localPDF;
  String? pdfFileName;

  FilePickerResult? result;

  UplaodBookModel uploadBookModel = UplaodBookModel();

  bool isLoading = false;

  late Future<List<UplaodBookModel>> getAllBook;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        alignmentTitle: Alignment.center,
        title: Text(
          MStrings.uploadNewBook,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14.w,
              color: ColorManger.white),
        ),
      ),
      body: BlocBuilder<UploadBookCubit, UploadBookState>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 30.h),
                            GestureDetector(
                              onTap: () async {
                                final pickedFile = await pickImageFile();
                                if (pickedFile != null) {
                                  setState(() {
                                    localImage = pickedFile.path;
                                    uploadBookModel.localImagePath =
                                        pickedFile.path;
                                  });
                                }
                              },
                              child: localImage != null
                                  ? Image.file(
                                      File(localImage!),
                                      height: 165.h,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : StaticUploadContainerForBookAdminScreen(
                                      containerColor: ColorManger.logoColor,
                                      iconColor: ColorManger.white,
                                      textColor: ColorManger.white,
                                      icon: Icons.image,
                                      titleText: MStrings.uploadPic,
                                    ),
                            ),
                            SizedBox(height: 20.h),
                            GestureDetector(
                              onTap: () async {
                                final pickedFile = await pickPdfFile();
                                if (pickedFile != null) {
                                  setState(() {
                                    localPDF = pickedFile.path;
                                    pdfFileName =
                                        pickedFile.path.split('/').last;
                                    uploadBookModel.localPdFPath =
                                        pickedFile.path;
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
                                  : StaticUploadContainerForBookAdminScreen(
                                      containerColor: ColorManger.white,
                                      iconColor: ColorManger.logoColor,
                                      textColor: ColorManger.logoColor,
                                      icon: Icons.picture_as_pdf,
                                      titleText: MStrings.uploadBook,
                                    ),
                            ),
                            SizedBox(height: 20.h),
                            CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'قم بادخال العنوان';
                                }
                                return null;
                              },
                              minLines: 1,
                              maxLines: 7,
                              labelText: Text(
                                MStrings.bookTitle,
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
                                uploadBookModel.bookTitle = p0;
                              },
                            ),
                            SizedBox(height: 20.h),
                            CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'قم بادخال تفاصيل الكتاب';
                                }
                                return null;
                              },
                              minLines: 1,
                              maxLines: 15,
                              labelText: Text(
                                MStrings.bookSubTitle,
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
                                uploadBookModel.bookdescription = p0;
                              },
                            ),
                            SizedBox(height: 30.h),
                            BottonClick(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              onTap: () async {
                                if (formKey.currentState!.validate() &&
                                    localImage != null &&
                                    localPDF != null) {
                                  formKey.currentState!.save();

                                  setState(() {
                                    isLoading = true;
                                  });
                                  await BlocProvider.of<UploadBookCubit>(
                                          context)
                                      .uploadImageDataForAdmin(uploadBookModel)
                                      .whenComplete(() {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    // ignore: unrelated_type_equality_checks
                                    if (state == "Success upload book") {
                                      Navigator.of(context)
                                          .pop("Success upload book");
                                    }
                                    Navigator.of(context)
                                        .pop("Success upload book");
                                  });
                                } else {
                                  if (localImage == null) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              'حقل الصورة فارغ يرجي اضافته',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .copyWith(
                                                      fontSize: 14.w,
                                                      color: Colors.white),
                                            )));
                                  } else if (localPDF == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'حقل الكتاب فارغ يرجي اضافته',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  fontSize: 14.w,
                                                  color: Colors.white),
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              text: MStrings.uploadBook,
                            ),
                            SizedBox(height: 30.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
