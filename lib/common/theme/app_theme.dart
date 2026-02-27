import 'package:flutter/material.dart';
import 'package:wechat/common/theme/app_colors.dart';

class AppTheme {
  static OutlineInputBorder _border([
    Color color = AppColors.borderColor,
  ]) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: color, width: 2),
  );

  static final darkThemeMode = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    brightness: Brightness.dark,

    inputDecorationTheme: InputDecorationTheme(
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.appColor),
      errorBorder: _border(AppColors.errorColor),
      focusedErrorBorder:  _border(AppColors.errorColor),

      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    ),

    colorScheme: ColorScheme.dark(

      primary: AppColors.appColor,
      secondary: AppColors.white,
      surfaceContainer:AppColors.iconBackDarkTheme 
    ),
    iconTheme: IconThemeData(color: AppColors.appColor),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
    ),
  );





  static final lightThemeMode = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    brightness: Brightness.light,

    inputDecorationTheme: InputDecorationTheme(
        border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.appColor),
      errorBorder: _border(AppColors.errorColor),
     
      contentPadding: EdgeInsets.all(12),
    ),

    colorScheme: ColorScheme.light(
      primary: AppColors.appColor,
      secondary: AppColors.black,
      surfaceContainer:AppColors.iconBackLightTheme 
    ),
    iconTheme: IconThemeData(color: AppColors.appColor),
     appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
    ),
    
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
    ),
  );
}
