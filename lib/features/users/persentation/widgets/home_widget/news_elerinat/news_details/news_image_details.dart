import 'package:flutter/material.dart';

class NewsImageDetailsWidget extends StatelessWidget {
  const NewsImageDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "news_image",
      child: Image.asset(
        "assets/photo/bookCover2.jpg",
        fit: BoxFit.fill,
      ),
    );
  }
}
