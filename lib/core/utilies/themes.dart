import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/core/utilies/values_manger.dart';

import 'colors.dart';


class AppThemes{
  static final darkMode=ThemeData(
elevatedButtonTheme: ElevatedButtonThemeData(style:ButtonStyle(backgroundColor:MaterialStateProperty.all(AppColors.darkGrey),foregroundColor:MaterialStateProperty.all(Colors.white) ) ),

    scaffoldBackgroundColor: AppColors.darkGrey,
    colorScheme:  const ColorScheme.dark(primary: AppColors.teal),
    buttonTheme: const ButtonThemeData(
       buttonColor: AppColors.teal,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkGrey,
      elevation: AppSize.s0,
      titleTextStyle: const TextStyle(
          color: AppColors.white, fontSize: AppSize.s20, fontWeight: FontWeight.bold),
      iconTheme: const IconThemeData(
        color: AppColors.teal,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    textTheme:  const TextTheme(
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
  );


  static final lightMode=ThemeData(




    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(primary: AppColors.teal),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.teal,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: AppSize.s0,
      titleTextStyle: TextStyle(
          color: AppColors.black, fontSize: AppSize.s20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(
        color: AppColors.teal,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    textTheme:  const TextTheme(
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


  );
}