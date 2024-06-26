import 'package:el_erinat/features/admin/persentation/widget/admin_book_screen/admin_upload_book_widget.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/book_elerinat_widget/user_book_library.dart';
import 'package:flutter/material.dart';

class BookElerinatBody extends StatelessWidget {
  const BookElerinatBody(
      {super.key, required this.isAdmin, required this.isAuditor});
  final bool isAdmin;
  final bool isAuditor;
  @override
  Widget build(BuildContext context) {
    List<String> bookImage = [
      "assets/photo/bookCover.png",
      "assets/photo/bookCover2.jpg",
      "assets/photo/bookCover2.jpg",
      "assets/photo/bookCover.png",
      "assets/photo/bookCover.png",
      "assets/photo/bookCover2.jpg",
    ];
    return Positioned.fill(
      child: SafeArea(
        child: SingleChildScrollView(
          child: isAdmin == true
              ? AdminUploadAndBookLibrary(
                  // bookImage: bookImage,
                  )
              : isAuditor == true
                  ? UserBookLibarary(bookImage: bookImage)
                  : UserBookLibarary(bookImage: bookImage),
        ),
      ),
    );
  }
}
