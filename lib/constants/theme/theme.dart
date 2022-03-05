import 'package:flutter/material.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: ThemeColors.green,
    accentColor: ThemeColors.blue,
    hintColor: ThemeColors.black,
    dividerColor: ThemeColors.white,
    scaffoldBackgroundColor: ThemeColors.white,
    canvasColor: ThemeColors.white,
    fontFamily: StaticStyles.fontFamily,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black45, width: 1.0),
      ),
    ),
  );
}
