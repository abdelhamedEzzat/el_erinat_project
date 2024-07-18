import 'dart:convert';
import 'dart:io';
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/image_picker.dart';
import 'package:el_erinat/features/users/data/model/upload_image.dart';

import 'package:el_erinat/features/users/persentation/user_cubit/work_personal_details_cubit/work_personal_details_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddIdentityPic extends StatefulWidget {
  const AddIdentityPic({super.key, required this.uploadImage});
  final UploadImage uploadImage;

  @override
  State<AddIdentityPic> createState() => _AddIdentityPicState();
}

class _AddIdentityPicState extends State<AddIdentityPic> {
  @override
  void initState() {
    super.initState();
    // Fetch image when widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<WorkPersonalDetailsCubit>()
          .fetchImage(widget.uploadImage.uID.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkPersonalDetailsCubit, WorkPersonalDetailsState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state is WorkPersonalDetailsLoading)
              const CircularProgressIndicator()
            else if (state is WorkPersonalDetailsSuccessIdentety)
              _buildImage(state.user)
            else if (state is WorkPersonalDetailsError)
              Column(
                children: [
                  //Text(state.failure),
                  UplaodIdentatuPic(uploadImage: widget.uploadImage),
                ],
              )
            else
              UplaodIdentatuPic(uploadImage: widget.uploadImage),
          ],
        );
      },
    );
  }

  Widget _buildImage(UploadImage? image) {
    if (image?.imagePath != null) {
      return Image.file(
        File(
          image!.imagePath!,
        ),
        height: 200,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fitWidth,
      );
    } else if (image?.imagePath != null) {
      return Image.network(
        image!.imagePath!,
        height: 100.h,
      );
    } else {
      return UplaodIdentatuPic(uploadImage: widget.uploadImage);
    }
  }
}

class UplaodIdentatuPic extends StatefulWidget {
  const UplaodIdentatuPic({super.key, required this.uploadImage});
  final UploadImage uploadImage;

  @override
  State<UplaodIdentatuPic> createState() => _UplaodIdentatuPicState();
}

class _UplaodIdentatuPicState extends State<UplaodIdentatuPic> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () async {
              await openCamera(
                widget.uploadImage,
              ).whenComplete(() {
                print(
                  "--------------------${widget.uploadImage.imagePath}------------------------",
                );

                if (widget.uploadImage.imagePath != null) {
                  setState(() {});

                  print("-------------------uploaded--------------");
                } else {
                  // Handle the case where uploadedIdentityImage is null
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No Image to upload')),
                  );
                }
              });
            },
            child:
                //   BlocBuilder<WorkPersonalDetailsCubit, WorkPersonalDetailsState>(
                // builder: (context, state) {
                //   if (state is WorkPersonalDetailsLoading) {
                //     return const CircularProgressIndicator();
                //   } else if (state is WorkPersonalDetailsErrorImage) {
                //     return Text(state.failure);
                //   } else if (state is WorkPersonalDetailsSuccessFile) {
                //     return
                widget.uploadImage.imagePath != null
                    ? Image.file(
                        File(widget.uploadImage.imagePath!),
                        height: 200.h,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )
                    : _buildPlaceholder(context)
            // } else {
            //   return _buildPlaceholder(context);
            // }
            //     },
            //   ),
            ),
      ],
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      color: ColorManger.logoColor.withOpacity(0.5),
      width: MediaQuery.of(context).size.width,
      height: 200.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, size: 25.h),
          SizedBox(width: 15.w),
          Text(MStrings.addIdedntatyPic,
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
