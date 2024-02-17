import 'package:flutter/material.dart';

import '/presentation/resources/color_manager.dart';
import '/presentation/resources/values_manager.dart';
import '/presentation/resources/styles_manager.dart';
import '/presentation/resources/font_manager.dart';

ThemeData getApplicationLightTheme() {
  return ThemeData(
    useMaterial3: true,
    //!main colors
    primaryColor: Colors.teal,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: ColorManager.orange, brightness: Brightness.light),
    canvasColor: ColorManager.white10,
    cardColor: ColorManager.whiteGrey,
    shadowColor: ColorManager.white30,
    scaffoldBackgroundColor: ColorManager.offWhite,
    dialogBackgroundColor: ColorManager.white,
    brightness: Brightness.light,
    //!app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        shadowColor: ColorManager.lightPrimary,
        elevation: AppSize.s4,
        iconTheme: const IconThemeData(color: ColorManager.black87),
        actionsIconTheme: const IconThemeData(color: ColorManager.black87),
        titleTextStyle:
            getBoldStyle(fontSize: FontSize.s20, color: ColorManager.black87)),

    //!Icon theme
    iconTheme: const IconThemeData(color: ColorManager.black87),

    //!Dialog theme
    dialogTheme: const DialogTheme(
      backgroundColor: ColorManager.white,
      elevation: AppSize.s10,
    ),

    //!Snack Bar theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: ColorManager.black,
      actionTextColor: ColorManager.primary,
      contentTextStyle:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s15),
    ),

    //!Card theme
    cardTheme: const CardTheme(color: ColorManager.white10),

    //!button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),
    //! elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                fontSize: FontSize.s17, color: ColorManager.white),
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),
    //!text theme
    textTheme: TextTheme(
        displayLarge: getRegularStyle(
            color: ColorManager.black87, fontSize: FontSize.s25),
        displayMedium:
            getBoldStyle(color: ColorManager.black87, fontSize: FontSize.s20),
        displaySmall: getRegularStyle(
            color: ColorManager.black87, fontSize: FontSize.s15),
        bodyLarge: getRegularStyle(
            color: ColorManager.black87, fontSize: FontSize.s22),
        bodyMedium:
            getBoldStyle(color: ColorManager.black87, fontSize: FontSize.s50)
                .copyWith(fontFamily: FontConstants.fontFamily2),
        labelSmall:
            getLightStyle(color: ColorManager.white, fontSize: FontSize.s14),
        labelMedium: getRegularStyle(
            color: ColorManager.black87, fontSize: FontSize.s20)),

    //!Input decoration theme(text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.grey,
      ),
      labelStyle: getRegularStyle(
        fontSize: FontSize.s14,
        color: ColorManager.grey,
      ),
      errorStyle:
          getRegularStyle(fontSize: FontSize.s14, color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.black, width: AppSize.s0),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.primary, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.error, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.primary, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
  );
}

ThemeData getApplicationDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    //!main colors
    primaryColor: Colors.teal,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: ColorManager.pink, brightness: Brightness.dark),
    canvasColor: ColorManager.grey,
    cardColor: ColorManager.blackGreen,
    shadowColor: ColorManager.black26,
    scaffoldBackgroundColor: ColorManager.black,
    brightness: Brightness.dark,

    //!app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        shadowColor: ColorManager.lightPrimary,
        elevation: AppSize.s4,
        iconTheme: const IconThemeData(color: ColorManager.white),
        actionsIconTheme: const IconThemeData(color: ColorManager.white),
        titleTextStyle:
            getBoldStyle(fontSize: FontSize.s20, color: ColorManager.white)),

    //!Icon theme
    iconTheme: const IconThemeData(color: ColorManager.black87),

    //!Dialog theme
    dialogTheme: const DialogTheme(
      backgroundColor: ColorManager.grey80,
      elevation: AppSize.s10,
    ),

    //!Snack Bar theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: ColorManager.grey80,
      actionTextColor: ColorManager.primary,
      contentTextStyle:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s15),
    ),

    //!Card theme
    cardTheme: const CardTheme(color: ColorManager.grey),

    //!button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),
    //! elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                fontSize: FontSize.s17, color: ColorManager.white),
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),
    //!text theme
    textTheme: TextTheme(
        displayLarge:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s25),
        displayMedium:
            getBoldStyle(color: ColorManager.white, fontSize: FontSize.s20),
        displaySmall:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s15),
        bodyLarge:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s22),
        bodyMedium:
            getBoldStyle(color: ColorManager.white, fontSize: FontSize.s50)
                .copyWith(fontFamily: FontConstants.fontFamily2),
        labelSmall:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s14),
        labelMedium: getRegularStyle(
            color: ColorManager.black87, fontSize: FontSize.s20)),

    //!Input decoration theme(text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.grey,
      ),
      labelStyle: getRegularStyle(
        fontSize: FontSize.s14,
        color: ColorManager.grey,
      ),
      errorStyle:
          getRegularStyle(fontSize: FontSize.s14, color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.white, width: AppSize.s0),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.primary, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.error, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.primary, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
  );
}
