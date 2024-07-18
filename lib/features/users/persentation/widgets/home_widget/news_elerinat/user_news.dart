import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/features/admin/data/model/upload_book_model.dart';
import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';
import 'package:el_erinat/features/admin/persentation/cubit/video_cubit/news_cubit.dart';
import 'package:el_erinat/features/admin/persentation/screens/admin_sub_screen/admin_news_screen.dart';
import 'package:el_erinat/features/admin/persentation/widget/admin_book_screen/admin_upload_book_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/news_date.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/news_items_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/news_sub_title.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/news_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserNews extends StatelessWidget {
  const UserNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<NewsCubit, NewsState>(
          listener: (context, state) async {
            if (state is UploadNewsLoading) {
              // Show loading indicator
              print("Upload in progress...");
            } else if (state is UploadNewsSuccess) {
              BlocProvider.of<NewsCubit>(context).addNewsItem(state.news);
              // Handle success
              print("Upload successful: ${state.news.createdAt}");
            } else if (state is UploadNewsError) {
              // Handle error
              print("Upload failed: ${state.failure}");
            }
          },
          builder: (context, state) {
            if (state is GetNewsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetNewsSuccess) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.news.length,
                itemBuilder: (BuildContext context, int index) {
                  final news = state.news[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          Container(
                            height:
                                250.h, // Adjust height as needed for the image
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorManger.logoColor),
                            ),
                            child: buildImageAndVideoWidget(news),
                          ),
                          Container(
                            color: ColorManger.logoColor,
                            child: IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  NewsTitle(title: news.newsTitle),
                                  NewsSubTitle(subtitle: news.newsSubTitle),
                                  NewsDate(date: news.createdAt),
                                  SizedBox(height: 25.h),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 25.h),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is GetNewsError) {
              return Center(
                child: Text(state.failure.toString()),
              );
            }
            return const Center(child: Text("Something went wrong"));
          },
        ),
      ],
    );
  }
}
