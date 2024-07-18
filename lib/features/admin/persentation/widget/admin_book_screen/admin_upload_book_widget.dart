import 'dart:io';
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/admin/data/model/upload_book_model.dart';
import 'package:el_erinat/features/admin/persentation/cubit/book_cubit/upload_book_cubit.dart';
import 'package:el_erinat/features/admin/persentation/widget/admin_book_screen/upload_book_widget_in_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminUploadAndBookLibrary extends StatelessWidget {
  const AdminUploadAndBookLibrary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const UploadBook(),
          Container(
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
            width: MediaQuery.of(context).size.width,
            child: BlocConsumer<UploadBookCubit, UploadBookState>(
              listener: (context, state) {
                if (state is UploadBookSuccess) {
                  BlocProvider.of<UploadBookCubit>(context)
                      .addNewsItem(state.book);
                }
              },
              builder: (context, state) {
                if (state is GetBookLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetBookSuccess) {
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 35.w,
                      mainAxisSpacing: 20.h,
                      mainAxisExtent: 200.h,
                    ),
                    itemCount: state.book.length,
                    itemBuilder: (BuildContext context, int index) {
                      final book = state.book[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              ConstantsRouteString.bookDetailsScreen,
                              arguments: {
                                "localImagePath": book.localImagePath,
                                "localPdFPath": book.localPdFPath,
                                "bookTitle": book.bookTitle,
                                "bookdescription": book.bookdescription,
                                "remotepdfUrl": book.remotepdfUrl,
                                "pdfName": book.pdfName
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorManger.logoColor),
                          ),
                          child: buildImageWidget(book),
                        ),
                      );
                    },
                  );
                } else if (state is GetBookError) {
                  return Center(
                    child: Text(state.failure.toString()),
                  );
                }
                return const Center(child: Text("Something went wrong"));
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildImageWidget(UplaodBookModel book) {
  if (book.localImagePath != null) {
    return Image.file(
      File(book.localImagePath!),
      fit: BoxFit.cover,
      width: 100.w,
      height: 200.h,
    );
  } else if (book.remoteImageUrl != null) {
    return _buildNetworkImageWithLoader(book.remoteImageUrl!);
  } else {
    return const Center(
      child: Text("No Image Available"),
    );
  }
}

Widget _buildNetworkImageWithLoader(String imageUrl) {
  return Image.network(
    imageUrl,
    fit: BoxFit.cover,
    width: 100.w,
    height: 200.h,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      }
    },
    errorBuilder: (context, error, stackTrace) {
      return const Center(
        child: Text(
          'Image not found',
          style: TextStyle(color: Colors.red),
        ),
      );
    },
  );
}
