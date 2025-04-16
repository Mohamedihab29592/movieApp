import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/core/utilies/values_manger.dart';

import 'colors.dart';


class AppThemes {
  static final darkMode = ThemeData(


    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.defaultColor),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
    ),
    scaffoldBackgroundColor: AppColors.defaultColor,
    colorScheme: const ColorScheme.dark(primary: Colors.blue),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.blue,
    ),
    // Add BottomNavigationBar theme for dark mode
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.defaultColor,
      selectedItemColor: AppColors.blue,
      unselectedItemColor: AppColors.grey,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.defaultColor,
      elevation: AppSize.s0,
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: AppSize.s20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: AppColors.blue,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: AppSize.s22,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontSize: AppSize.s14,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleSmall: TextStyle(
        fontSize: AppSize.s14,
        fontWeight: FontWeight.w600,
        color: AppColors.grey,
        height: AppSize.s1_2,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: AppColors.softGrey,
      hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.softGrey
      ),
      labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.softGrey
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.searchColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide:  const BorderSide(color: AppColors.searchColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.searchColor),
      ),
      contentPadding: const EdgeInsets.only(left: 20),
      filled: true,
      fillColor: AppColors.searchColor,
    ),  );

  static final lightMode = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(primary: AppColors.blue),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.blue,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.blue,
      unselectedItemColor: AppColors.grey,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: AppSize.s0,
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: AppSize.s20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: AppColors.blue,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: AppSize.s22,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      titleMedium: TextStyle(
        fontSize: AppSize.s14,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      titleSmall: TextStyle(
        fontSize: AppSize.s14,
        fontWeight: FontWeight.w600,
        color: AppColors.grey,
        height: AppSize.s1_2,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: AppColors.softGrey,
      hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.softGrey
      ),
      labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.softGrey
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.black),
      ),
      contentPadding: const EdgeInsets.only(left: 20),
      filled: true,
      fillColor: AppColors.white,
    ),  );
}