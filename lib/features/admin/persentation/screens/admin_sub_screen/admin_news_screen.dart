import 'dart:async';
import 'dart:io';

import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/admin/persentation/cubit/video_cubit/news_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/news_date.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/news_sub_title.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/news_title.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_widget/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';

import '../../../../../core/route/route_strings.dart';

class AdminNewsScreen extends StatefulWidget {
  const AdminNewsScreen({super.key});

  @override
  State<AdminNewsScreen> createState() => _AdminNewsScreenState();
}

class _AdminNewsScreenState extends State<AdminNewsScreen> {
 final progress = 0;
 
 late StreamSubscription newsSubscription;
  //  final StreamSubscription newsSubscription;
 @override
  // void initState() {
  //   super.initState();
  //   print("initState called");

  //   // Listen to task status changes here
  // BlocProvider.of<NewsCubit>(context).stream.listen((state)async {
  //     if (state is UploadNewsLoading) {
  //       // Show loading indicator
  //       print("Upload in progress...");
  //     } else if (state is UploadNewsSuccess) {
  //   await BlocProvider.of<NewsCubit>(context).fetchNewsData();
  //       print("Upload successful: ${state.news.createdAt}");
  //     } else if (state is UploadNewsError) {
  //       // Handle error
  //       print("Upload failed: ${state.failure}");
  //     }else{
  //       print("else");
  //     }
  //   });
  // }

  //  @override
  // void dispose() {
  //   // Cancel the subscription when the widget is disposed
  //   newsSubscription.cancel();
  //   super.dispose();
  // }



  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            final result =
             await Navigator.of(context).pushNamed(ConstantsRouteString.adminUploadNews);
            if (result == true) {
              
              BlocProvider.of<NewsCubit>(context).fetchNewsData();
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
                  Icons.newspaper,
                  size: 25.h,
                  color: Colors.white,
                ),
                Text(
                  MStrings.uplaodNews,
                  textAlign: TextAlign.end,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
  




        BlocConsumer<NewsCubit, NewsState>(

  listener: (context, state) async{
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
                          Container(
                            height: 250.h, // Adjust height as needed for the image
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorManger.logoColor),
                            ),
                            child: _buildImageWidget(news),
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

  Widget _buildImageWidget(UploadImageAndVideoModel book) {
    if (book.path != null && book.type == 'IMAGE') {
      return Image.file(
        File(book.path!),
        fit: BoxFit.cover,
      );
     
    } else if ( book.type == 'VIDEO') {
        return BuildNetworkVideoPlayer(
          videoUrl: book.url!,
          isLocal: false,
          isLooping: true,
        );
    }

    
     else if (book.url != null) {
      if (book.type == 'IMAGE') {
        return _buildNetworkImageWithLoader(book.url!);
      } else if (book.type == 'VIDEO') {
        return BuildNetworkVideoPlayer(
          videoUrl: book.url!,
          isLocal: false,
          isLooping: true,
        );
      } else {
        return const Center(
          child: Text("Unknown Media Type"),
        );
      }
    } else {
      return const Center(
        child: Text("No Image or Video Available"),
      );
    }
  }

  Widget _buildNetworkImageWithLoader(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
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
}



