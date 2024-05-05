import 'package:el_erinat/features/users/persentation/widgets/home_widget/analitics_screen_widget/left_column_analitics.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/analitics_screen_widget/right_column_analitics.dart';
import 'package:flutter/material.dart';

class AnaliticsItemsRow extends StatelessWidget {
  const AnaliticsItemsRow({
    super.key,
    required this.rightNumber,
    required this.rightText,
    required this.leftNumber,
    required this.leftText,
  });
  final String rightNumber;
  final String rightText;
  final String leftNumber;
  final String leftText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LeftColumnAnalitics(
          leftNumber: leftNumber,
          leftText: leftText,
        ),
        RightColumnAnalitics(
          rightNumber: rightNumber,
          rightText: rightText,
        )
      ],
    );
  }
}
