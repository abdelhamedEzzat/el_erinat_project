import 'dart:convert';
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
  const AddIdentityPic({super.key});

  @override
  State<AddIdentityPic> createState() => _AddIdentityPicState();
}

class _AddIdentityPicState extends State<AddIdentityPic> {
  final UploadImage uploadImage = UploadImage();

  @override
  void initState() {
    super.initState();
    // Fetch image when widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<WorkPersonalDetailsCubit>()
          .fetchImage(FirebaseAuth.instance.currentUser!.uid);
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
                  UplaodIdentatuPic(uploadImage: uploadImage),
                ],
              )
            else
              UplaodIdentatuPic(uploadImage: uploadImage),
          ],
        );
      },
    );
  }

  Widget _buildImage(UploadImage? image) {
    if (image?.bytes != null) {
      return Image.memory(
        image!.bytes!,
        height: 200,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fitWidth,
      );
    } else if (image?.uploadedIdentityImage != null) {
      return Image.network(
        image!.uploadedIdentityImage!,
        height: 100,
      );
    } else {
      return UplaodIdentatuPic(uploadImage: uploadImage);
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
            await openCameraTotakeImage(widget.uploadImage).whenComplete(() {
              print(
                "--------------------${widget.uploadImage.uploadedIdentityImage}------------------------",
              );
              BlocProvider.of<WorkPersonalDetailsCubit>(context)
                  .uploadImageDataForUser(
                widget.uploadImage,
                base64Decode(widget.uploadImage.uploadedIdentityImage!),
              );
            });
          },
          child:
              BlocBuilder<WorkPersonalDetailsCubit, WorkPersonalDetailsState>(
            builder: (context, state) {
              if (state is WorkPersonalDetailsLoading) {
                return const CircularProgressIndicator();
              } else if (state is WorkPersonalDetailsErrorImage) {
                return Text(state.failure);
              } else if (state is WorkPersonalDetailsSuccessFile) {
                return Image.memory(
                  widget.uploadImage.bytes!,
                  height: 200.h,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                );
              } else {
                return _buildPlaceholder(context);
              }
            },
          ),
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
