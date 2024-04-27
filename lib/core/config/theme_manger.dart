import 'package:el_erinat/core/config/font_manger.dart';
import 'package:flutter/material.dart';

ThemeData themeManager() {
  return ThemeData(
    // scaffoldBackgroundColor: const Color(0xffE8F6FB),
    // colorScheme: const ColorScheme(
    //   // for brightness
    //   brightness: Brightness.light,

    //   // for appbar background color and widget color in it
    //   primary: Color(0xff022238),
    //   onPrimary: Color(0xFFFFFFFF),

    //   // for promo back ground color  and button color
    //   surface: Color(0xFFFFFFFF),

    //   // for Text Color
    //   onPrimaryContainer: Color(0xff8D969F),
    //   primaryContainer: Color(0xff843667),
    //   onSurface: Colors.black,
    //   secondary: Color(0xff20ACFD),
    //   onSecondary: Color(0xffFBF3E8),
    //   onSecondaryContainer: Color(0xffFFDCBC),

    //   // backGroundColor in card
    //   background: Color(0xFFFFFFFF),
    //   onBackground: Color(0xffE8F6FB),

    //   // error text  color
    //   error: Colors.red,
    //   onError: Color(0xFFF46258),
    // ),
    //
    //  font theme
    //
    fontFamily: FontManger.fontFamily,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 34,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      titleSmall: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      headlineLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
    ),
  );
}
