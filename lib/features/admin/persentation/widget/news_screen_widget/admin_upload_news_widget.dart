import 'dart:io';
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/core/helpers/file_picker.dart';
import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';
import 'package:el_erinat/features/admin/data/repo_admin/admin_repo_impelment.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/admin_local_data_base_helper.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/remote_data_base_helper.dart';
import 'package:el_erinat/features/admin/persentation/cubit/video_cubit/news_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class AdminUploadNews extends StatefulWidget {
  const AdminUploadNews({super.key});

  @override
  State<AdminUploadNews> createState() => _AdminUploadNewsState();
}

class _AdminUploadNewsState extends State<AdminUploadNews> {
  AdminRepoImplementation adminRepoImplementation = AdminRepoImplementation(
    adminLocalDatabaseHelper: AdminLocalDatabaseHelper(),
    adminRemoteDataBaseHelper: AdminRemoteDataBaseHelper(),
  );

  UploadImageAndVideoModel uploadImageAndVideoModel =
      UploadImageAndVideoModel();
  File? selectedFile;
  String? fileType;
  VideoPlayerController? _videoController;

  Future<void> pickNewsFile() async {
    File? file = await pickNewsFiles();

    if (file != null) {
      String? type = getFileType(file);
      if (type != null) {
        setState(() {
          selectedFile = file;
          fileType = type;
          if (fileType == 'VIDEO') {
            _videoController = VideoPlayerController.file(selectedFile!)
              ..initialize().then((_) {
                setState(() {}); // Ensure the UI updates after initialization
                _videoController!.play();
              });
          }
        });
      }
      print(type);
    }
  }

  String? getFileType(File file) {
    String extension = file.path.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png', 'svg'].contains(extension)) {
      return 'IMAGE';
    } else if (['mp4'].contains(extension)) {
      return 'VIDEO';
    }
    return null;
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBarAndDaynamicBody(
      alignmentTitle: Alignment.center,
      titleName: MStrings.uplaodNews,
      yourBodyOfScreen: Positioned.fill(
        child: SafeArea(
          child: BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await pickNewsFile();

                          uploadImageAndVideoModel.path = selectedFile!.path;

                          uploadImageAndVideoModel.type = fileType;
                        },
                        child: Container(
                          padding: EdgeInsets.all(25.w),
                          height: 200.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: ColorManger.white.withOpacity(0.9),
                            border: Border(
                              bottom: BorderSide(
                                width: 5.w,
                                color: ColorManger.logoColor,
                              ),
                              right: BorderSide(
                                width: 5.w,
                                color: ColorManger.logoColor,
                              ),
                              left: BorderSide(
                                width: 5.w,
                                color: ColorManger.logoColor,
                              ),
                              top: BorderSide(
                                width: 5.w,
                                color: ColorManger.logoColor,
                              ),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.w)),
                          ),
                          child: selectedFile == null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload,
                                      size: 25.h,
                                      color: ColorManger.logoColor,
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Text(
                                      MStrings.uploadPic,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: ColorManger.logoColor),
                                    ),
                                  ],
                                )
                              : fileType == 'IMAGE'
                                  ? Image.file(
                                      selectedFile!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    )
                                  : _videoController != null &&
                                          _videoController!.value.isInitialized
                                      ? AspectRatio(
                                          aspectRatio: _videoController!
                                              .value.aspectRatio,
                                          child: VideoPlayer(_videoController!),
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator()),
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      CustomTextFormField(
                        onChanged: (value) {
                          setState(() {
                            uploadImageAndVideoModel.newsTitle = value;
                          });
                        },
                        hintColor: ColorManger.logoColor,
                        hintText: MStrings.newsAddress,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      CustomTextFormField(
                        onChanged: (value) {
                          setState(() {
                            uploadImageAndVideoModel.newsSubTitle = value;
                          });
                        },
                        hintColor: ColorManger.logoColor,
                        maxLines: 5,
                        hintText: MStrings.detailsNews,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      BottonClick(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        onTap: () {
                          BlocProvider.of<NewsCubit>(context)
                              .uploadNewsDataForAdmin(uploadImageAndVideoModel);
                        },
                        text: MStrings.submit,
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
