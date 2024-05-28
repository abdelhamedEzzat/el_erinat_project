// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.padding,
    this.height,
    this.borderRadius,
    this.suffixIcon,
    this.normalBorderColor,
    this.prefixIcon,
    this.enabled,
    this.border,
    this.labelText,
    this.hintColor,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.obscureText,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.width,
  });

  final String? hintText;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget? suffixIcon;
  final Color? normalBorderColor;
  final Widget? prefixIcon;
  final bool? enabled;
  final InputBorder? border;
  final Widget? labelText;
  final Color? hintColor;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onChanged;
  final double? width;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height,
      width: width,
      padding: padding,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        validator: validator,
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        minLines: minLines,
        maxLines: maxLines,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            fontSize: 10.0.w,
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManger.logoColor)),
          enabled: enabled ?? true,
          //   labelText: labelText,

          label: labelText,
          labelStyle: TextStyle(
              color: Colors.grey, fontSize: 10.w, fontWeight: FontWeight.bold),
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(7.0)),
              borderSide: BorderSide(
                  color: normalBorderColor ??
                      ColorManger.logoColor.withOpacity(0.9))),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 4.0, bottom: 4.0),

          alignLabelWithHint: true,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 12.w, color: hintColor ?? Colors.grey),
          border: border ??
              OutlineInputBorder(
                borderRadius: borderRadius ??
                    const BorderRadius.all(
                      Radius.circular(7.0),
                    ),
              ),
        ),
      ),
    );
  }
}
