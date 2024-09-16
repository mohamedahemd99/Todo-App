import 'package:flutter/material.dart';

import '../helpers/custom_colors.dart';

class ThemeWidget {
  ThemeData lightBuild() {
    return ThemeData(
      primaryColor: CustomColors.whiteColor,
      scaffoldBackgroundColor: CustomColors.whiteColor,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: CustomColors.whiteColor),
          backgroundColor: CustomColors.whiteColor,
          centerTitle: true,
          toolbarHeight: 75,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: CustomColors.blackColor,
            fontSize: 31,
            fontWeight: FontWeight.w600,
          ),
          actionsIconTheme: IconThemeData(color: CustomColors.whiteColor)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: CustomColors.whiteColor,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
            color: CustomColors.blackColor,
            fontSize: 12,
            fontFamily: "Madani",
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            color: CustomColors.greyAppColor,
            fontSize: 12,
            fontFamily: "Madani",
            fontWeight: FontWeight.w400,
          ),
          selectedIconTheme: IconThemeData(color: CustomColors.whiteColor),
          unselectedIconTheme: IconThemeData(color: CustomColors.greyAppColor),
          selectedItemColor: CustomColors.blackColor,
          unselectedItemColor: CustomColors.greyAppColor),
      cardColor: CustomColors.whiteColor,
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dialogBackgroundColor: CustomColors.whiteColor,
      dividerColor: CustomColors.greyAppColor,
      disabledColor: CustomColors.greyAppColor,
      primaryIconTheme: const IconThemeData(color: CustomColors.whiteColor),
      iconTheme: const IconThemeData(color: CustomColors.whiteColor),
      canvasColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonTheme: const ButtonThemeData(
          buttonColor: CustomColors.primaryColor,
          disabledColor: CustomColors.greyAppColor),
      fontFamily: "Madani",
      indicatorColor: CustomColors.greyAppColor,
      primaryTextTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 24,
          fontFamily: "Madani",
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 31,
          fontFamily: "Madani",
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          color: CustomColors.whiteColor,
          fontSize: 24,
          fontFamily: "Madani",
          fontWeight: FontWeight.w400,
        ),
        displayLarge: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 35,
          fontFamily: "Madani",
          fontWeight: FontWeight.w700,
        ),
        displayMedium: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 24,
          fontFamily: "Madani",
          fontWeight: FontWeight.w600,
        ),
        displaySmall: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 15,
          fontFamily: "Madani",
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 24,
          fontFamily: "Madani",
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 18,
          fontFamily: "Madani",
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 16,
          fontFamily: "Madani",
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: TextStyle(
          color: CustomColors.greyAppColor,
          fontSize: 18,
          fontFamily: "Madani",
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: CustomColors.greyAppColor,
          fontSize: 14,
          fontFamily: "Madani",
          fontWeight: FontWeight.w600,
        ),
        bodySmall: TextStyle(
          color: CustomColors.greyAppColor,
          fontSize: 10,
          fontFamily: "Madani",
          fontWeight: FontWeight.w400,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 24,
          fontFamily: "Madani",
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 31,
          fontFamily: "Madani",
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          color: CustomColors.whiteColor,
          fontSize: 24,
          fontFamily: "Madani",
          fontWeight: FontWeight.w400,
        ),
        displayLarge: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 35,
          fontFamily: "Madani",
          fontWeight: FontWeight.w700,
        ),
        displayMedium: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 24,
          fontFamily: "Madani",
          fontWeight: FontWeight.w600,
        ),
        displaySmall: TextStyle(
          color: CustomColors.greyAppColor,
          fontSize: 15,
          fontFamily: "Madani",
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 24,
          fontFamily: "Madani",
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 18,
          fontFamily: "Madani",
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: CustomColors.titleColor,
          fontSize: 16,
          fontFamily: "Madani",
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: TextStyle(
          color: CustomColors.greyAppColor,
          fontSize: 18,
          fontFamily: "Madani",
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: CustomColors.greyAppColor,
          fontSize: 14,
          fontFamily: "Madani",
          fontWeight: FontWeight.w600,
        ),
        bodySmall: TextStyle(
          color: CustomColors.greyTextFieldColor,
          fontSize: 10,
          fontFamily: "Madani",
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
