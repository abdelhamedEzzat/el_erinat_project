import 'dart:io';

import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/open_pdf_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  double expandedHeight = 250.h;
  late ScrollController _scrollController;
  bool _isScrolledToTop = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        setState(() {
          _isScrolledToTop =
              _scrollController.offset < expandedHeight - kToolbarHeight;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final localImagePath = arguments["localImagePath"];
    final bookTitle = arguments["bookTitle"];
    final bookDescription = arguments["bookdescription"];
    final remotepdfUrl = arguments["remotepdfUrl"];
    final pdfName = arguments["pdfName"];

    // Determine file path based on whether it's a local or remote PDF

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            backgroundColor: ColorManger.appBarColor,
            expandedHeight: expandedHeight,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: _isScrolledToTop
                  ? null
                  : Text(
                      MStrings.bookDetails,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.w,
                            color: ColorManger.white,
                          ),
                    ),
              background: Image.file(
                File(localImagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // SliverList for your content
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Your content widgets go here

                Container(
                  margin: EdgeInsets.only(top: 20.h, left: 15.w, right: 15.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                textAlign: TextAlign.end,
                                MStrings.bookTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: ColorManger.logoColor),
                              ),
                            ),
                            Divider(
                              color: ColorManger.logoColor,
                              indent: 240.w,
                              endIndent: 20.w,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                bookTitle,
                                //    textAlign: TextAlign.end,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: 12.h),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.1),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                textAlign: TextAlign.end,
                                MStrings.bookDetails,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: ColorManger.logoColor),
                              ),
                            ),
                            Divider(
                              color: ColorManger.logoColor,
                              indent: 240.w,
                              endIndent: 20.w,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                //     textAlign: TextAlign.end,
                                bookDescription,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.black.withOpacity(0.7),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12.h),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.1),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          //   localPdFPath
                          if (remotepdfUrl != null && remotepdfUrl.isNotEmpty) {
                            openPDF(
                              context,
                              remotepdfUrl!,
                            );
                          } else {
                            // Handle case where localPdFPath is null (optional)
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    'PDF file path is not available.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorManger.logoColor.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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
                              SizedBox(width: 10.w),
                              Icon(
                                Icons.picture_as_pdf,
                                color: ColorManger.logoColor,
                                size: 40.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
