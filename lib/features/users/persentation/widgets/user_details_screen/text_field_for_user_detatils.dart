import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldForUserDetatils extends StatelessWidget {
  const TextFieldForUserDetatils({
    super.key,
    this.onChangedText2,
    required this.text1,
    required this.text2,
    this.onChangedText1,
  });
  final void Function(String)? onChangedText2;
  final void Function(String)? onChangedText1;

  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            keyboardType: TextInputType.name,
            onChanged: onChangedText2,
            labelText: Text(text2),
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: CustomTextFormField(
            keyboardType: TextInputType.name,
            onChanged: onChangedText1,
            labelText: Text(
              text1,
            ),
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
      ],
    );
  }
}
