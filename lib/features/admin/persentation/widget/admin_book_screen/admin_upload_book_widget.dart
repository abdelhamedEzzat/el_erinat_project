import 'dart:io';
import 'package:dio/dio.dart';
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/admin/data/model/upload_book_model.dart';
import 'package:el_erinat/features/admin/persentation/cubit/book_cubit/upload_book_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

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
            child: BlocBuilder<UploadBookCubit, UploadBookState>(
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
                                "remotepdfUrl": book.remotepdfUrl
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorManger.logoColor),
                          ),
                          child: _buildImageWidget(book),
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

  Widget _buildImageWidget(UplaodBookModel book) {
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
}

class UploadBook extends StatelessWidget {
  const UploadBook({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String? uploadBook = await Navigator.of(context)
            .pushNamed(ConstantsRouteString.uploadBookScreen) as String?;

        if (uploadBook == "Success upload book") {
          BlocProvider.of<UploadBookCubit>(context)
              .fetchBookImage(FirebaseAuth.instance.currentUser!.uid);
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
              Icons.upload,
              size: 25.h,
              color: Colors.white,
            ),
            Text(
              MStrings.uploadBook,
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

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
                        // decoration: BoxDecoration(
                        //   border: Border.all(
                        //       color: ColorManger.logoColor.withOpacity(0.2)),
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
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
                                  "pdfFileName" ?? '',
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

void openPDF(BuildContext context, String filePath) async {
  try {
    String? tempFilePath;

    // Check if filePath is a URL
    if (filePath.startsWith('http')) {
      // Download the PDF file and save it locally
      final fileName = filePath.split('/').last;
      tempFilePath = '${(await getTemporaryDirectory()).path}/$fileName';

      // Use Dio package to download the file
      await Dio().download(filePath, tempFilePath);
    } else {
      tempFilePath = filePath; // Use provided local file path directly
    }

    // Open the PDF file using OpenFile.open(filePath)
    final result = await OpenFile.open(tempFilePath!);

    // Print the relevant details from OpenResult
    print('OpenResult type: ${result.type}');
    print('OpenResult message: ${result.message}');

    // Check if there was an error
    if (result.type == ResultType.error) {
      print('Error opening PDF: ${result.message}');
      // Handle error as needed
    } else {
      // Wait for 60 seconds before showing the dialog
      Future.delayed(Duration(seconds: 1), () {
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          try {
            // Show dialog asking user if they are finished viewing the PDF
            await showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(
                  "تاكيد",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                content: Text(
                  'هل تم الانتهاء من عرض الكتاب؟',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 10.w,
                      ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'نعم',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: ColorManger.logoColor,
                            fontSize: 12.w,
                          ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop(); // Close the dialog
                      // Delete the temporary file after closing PDF viewer
                      await File(tempFilePath!).delete();
                      print('Deleted file: $tempFilePath');
                    },
                  ),
                  TextButton(
                    child: Text(
                      'لا',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: ColorManger.logoColor,
                            fontSize: 12.w,
                          ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              ),
            );
          } catch (e) {
            print('Error deleting file: $e');
            // Handle error deleting file if necessary
          }
        });
      });
    }
  } on PlatformException catch (e) {
    print('Error opening PDF: ${e.message}');
    // Handle platform exceptions (like missing implementation) as needed
  } catch (e) {
    print('Error opening PDF: $e');
    // Handle other exceptions as needed
  }
}
