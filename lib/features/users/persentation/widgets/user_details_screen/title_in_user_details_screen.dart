import 'package:flutter/material.dart';

class TitleInUserDetailsScreen extends StatelessWidget {
  const TitleInUserDetailsScreen({
    super.key,
    required this.text,
    required this.titleColor,
  });
  final String text;
  final Color titleColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .labelMedium!
          .copyWith(fontWeight: FontWeight.bold)
          .copyWith(color: titleColor),
    );
  }
}
