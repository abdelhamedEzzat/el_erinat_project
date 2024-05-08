import 'package:flutter/material.dart';

class VoteDate extends StatelessWidget {
  const VoteDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.start,
      maxLines: 15,
      overflow: TextOverflow.ellipsis,
      "14-04-2024",
      style:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
    );
  }
}
