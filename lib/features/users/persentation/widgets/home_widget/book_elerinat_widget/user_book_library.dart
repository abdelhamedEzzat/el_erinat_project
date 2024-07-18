import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/admin/persentation/cubit/book_cubit/upload_book_cubit.dart';
import 'package:el_erinat/features/admin/persentation/widget/admin_book_screen/admin_upload_book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserBookLibarary extends StatelessWidget {
  const UserBookLibarary({
    super.key,
    //required this.bookImage,
  });

  //final List<String> bookImage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
