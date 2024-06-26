import 'package:flutter/material.dart';

class VoteDate extends StatelessWidget {
  const VoteDate({
    super.key,
    required this.date,
  });
  final String date;
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.start,
      maxLines: 15,
      overflow: TextOverflow.ellipsis,
      date,
      style:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
    );
  }
}
