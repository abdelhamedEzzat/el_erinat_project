import 'package:el_erinat/core/config/font_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData themeManager() {
  return ThemeData(
    fontFamily: FontManger.fontFamily,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 34.h,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24.h,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20.h,
      ),
      bodySmall: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18.h,
      ),
      titleSmall: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.h,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.h,
      ),
      titleMedium: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12.h,
      ),
      headlineLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.h,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 10.h,
      ),
    ),
  );
}
