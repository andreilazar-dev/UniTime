/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LightTheme {
  static const backgroundColor = Color.fromRGBO(233, 233, 248, 1.0);
  static const primaryTextColorLight = Color.fromRGBO(247, 239, 229, 1);
  static const primaryTextColorDark = Color.fromRGBO(21, 21, 21, 1.0);
  static const primaryColor = Color.fromRGBO(62, 62, 112, 1);
  static const primaryColorLight = Color.fromRGBO(97, 97, 168, 0.4);
  static const primaryColorBright = Color.fromRGBO(114, 114, 186, 1);
  static const primaryColorDull = Color(0xFF3E3E70);

  static get make => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: backgroundColor,
        primaryColorDark: primaryColor,
        //This is used in multi selction for widget color in formfield
        primaryColorLight: primaryTextColorLight,
        //#Used for check box
        disabledColor: primaryColorDull,
        unselectedWidgetColor: primaryColor,
        selectedRowColor: primaryColorBright,
        appBarTheme: const AppBarTheme(color: primaryColor),
        //#FONT
        fontFamily: 'OpenSans',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: primaryTextColorDark,
              fontSize: 48,
              fontWeight: FontWeight.normal,
              shadows: [
                Shadow(
                    // bottomLeft
                    offset: Offset(-1, -1),
                    color: primaryTextColorDark),
                Shadow(
                    // bottomRight
                    offset: Offset(1, -1),
                    color: primaryTextColorDark),
                Shadow(
                    // topRight
                    offset: Offset(1, 1),
                    color: primaryTextColorDark),
                Shadow(
                    // topLeft
                    offset: Offset(-1, 1),
                    color: primaryTextColorDark),
              ]),
          displayMedium: TextStyle(
            color: primaryTextColorDark,
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
          displaySmall: TextStyle(
            color: primaryTextColorDark,
            fontSize: 20,
            // height: 28,
            fontWeight: FontWeight.w700,
          ),

          headlineMedium: TextStyle(
            color: primaryTextColorDark,
            fontSize: 24,
            // height: 28,
            fontWeight: FontWeight.w500,
          ),
          headlineSmall: TextStyle(
            color: primaryTextColorDark,
            fontSize: 12,
            // height: 28,
            fontWeight: FontWeight.w700,
          ),

          labelLarge: TextStyle(
            color: primaryTextColorLight,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
          labelMedium: TextStyle(
            color: primaryTextColorLight,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
          labelSmall: TextStyle(
            color: primaryTextColorLight,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),

          //Calendar
          // bodyLarge: TextStyle(
          //   color: Color(0xFFFFFFFC),
          //   fontSize: 20,
          //   // height: 28,
          //   fontWeight: FontWeight.w700,
          // ),
          // bodyMedium: TextStyle(
          //   color: Color(0xFFFFFFFC),
          //   fontSize: 14,
          //   // height: 28,
          //   fontWeight: FontWeight.w700,
          // ),
          // bodySmall: TextStyle(
          //   color: Color(0xFFFFFFFC),
          //   fontSize: 12,
          //   // height: 28,
          //   fontWeight: FontWeight.w700,
          // ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          //selectedItemColor: Color.fromRGBO(97, 97, 168, 1),
          //unselectedItemColor: Color.fromRGBO(118, 118, 122, 1),
          unselectedItemColor: backgroundColor,
          //backgroundColor: Color.fromRGBO(226, 226, 226, 0.8),
          backgroundColor: primaryColorLight,
        ),

        buttonTheme: const ButtonThemeData(
          buttonColor: primaryColor,
          textTheme: ButtonTextTheme.primary,
        ),
        snackBarTheme: const SnackBarThemeData(
            backgroundColor: primaryColor,
            contentTextStyle: TextStyle(
              color: primaryTextColorLight,
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: primaryColor,
          padding: const EdgeInsets.all(10),
        )),
        listTileTheme: const ListTileThemeData(
          textColor: primaryTextColorLight,
          selectedColor: primaryColorBright,
        ),
        dialogTheme: DialogTheme(
          titleTextStyle: const TextStyle(color: primaryTextColorLight),
          contentTextStyle: const TextStyle(color: primaryTextColorLight),
          backgroundColor: primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 0,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            // This is a custom color variable
            foregroundColor: primaryTextColorLight,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: primaryColor,
          labelStyle: TextStyle(
              color: primaryTextColorLight, fontWeight: FontWeight.w700),
          floatingLabelStyle: TextStyle(
              color: primaryTextColorLight, fontWeight: FontWeight.w700),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Colors.black)),
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: primaryColor,
          textStyle: const TextStyle(
              color: primaryTextColorLight, fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      );
}

class DarkTheme {
  static const backgroundColor = Color.fromRGBO(36, 36, 66, 1);

  static const primaryTextColorLight = Color.fromRGBO(247, 239, 229, 1);
  static const primaryTextColorDark = Color.fromRGBO(21, 21, 21, 1.0);

  //p
  static const primaryColor = Color(0xFF3E3E70);
  static const primaryColorLight = Color.fromRGBO(114, 114, 186, 1);

  static const primaryColorBright = Color.fromRGBO(114, 114, 186, 1);
  static const primaryColorDull = Color.fromRGBO(97, 97, 168, 1);

  static get make => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        //#Used for checkbox
        disabledColor: primaryColor,
        unselectedWidgetColor: primaryColor,
        selectedRowColor: primaryColorLight,
        appBarTheme: const AppBarTheme(color: primaryColor),
        //#FONT
        fontFamily: 'Lato',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: primaryTextColorLight,
              fontSize: 48,
              fontWeight: FontWeight.normal,
              shadows: [
                Shadow(
                    // bottomLeft
                    offset: Offset(-1, -1),
                    color: primaryTextColorDark),
                Shadow(
                    // bottomRight
                    offset: Offset(1, -1),
                    color: primaryTextColorDark),
                Shadow(
                    // topRight
                    offset: Offset(1, 1),
                    color: primaryTextColorDark),
                Shadow(
                    // topLeft
                    offset: Offset(-1, 1),
                    color: primaryTextColorDark),
              ]),
          displayMedium: TextStyle(
            color: primaryTextColorLight,
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
          displaySmall: TextStyle(
            color: primaryTextColorLight,
            fontSize: 20,
            // height: 28,
            fontWeight: FontWeight.w700,
          ),

          headlineMedium: TextStyle(
            color: primaryTextColorLight,
            fontSize: 24,
            // height: 28,
            fontWeight: FontWeight.w500,
          ),
          headlineSmall: TextStyle(
            color: primaryTextColorLight,
            fontSize: 12,
            // height: 28,
            fontWeight: FontWeight.w700,
          ),

          labelLarge: TextStyle(
            color: primaryTextColorLight,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
          labelMedium: TextStyle(
            color: primaryTextColorLight,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
          labelSmall: TextStyle(
            color: primaryTextColorLight,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),

          //Calendar
          // bodyLarge: TextStyle(
          //   color: Color(0xFFFFFFFC),
          //   fontSize: 20,
          //   // height: 28,
          //   fontWeight: FontWeight.w700,
          // ),
          // bodyMedium: TextStyle(
          //   color: Color(0xFFFFFFFC),
          //   fontSize: 14,
          //   // height: 28,
          //   fontWeight: FontWeight.w700,
          // ),
          // bodySmall: TextStyle(
          //   color: Color(0xFFFFFFFC),
          //   fontSize: 12,
          //   // height: 28,
          //   fontWeight: FontWeight.w700,
          // ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          //selectedItemColor: Color.fromRGBO(97, 97, 168, 1),
          unselectedItemColor: backgroundColor,
          backgroundColor: primaryColor,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: primaryColorDull,
          textTheme: ButtonTextTheme.primary,
        ),
        snackBarTheme: const SnackBarThemeData(
            backgroundColor: primaryColor,
            contentTextStyle: TextStyle(
              color: primaryTextColorLight,
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: primaryColorDull,
          padding: const EdgeInsets.all(10),
        )),
        listTileTheme: const ListTileThemeData(
          textColor: primaryTextColorLight,
          selectedColor: primaryColorBright,
        ),
        dialogTheme: DialogTheme(
          titleTextStyle: const TextStyle(color: primaryTextColorLight),
          contentTextStyle: const TextStyle(color: primaryTextColorLight),
          backgroundColor: const Color.fromRGBO(97, 97, 168, 0.7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 0,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor:
                primaryTextColorLight, // This is a custom color variable
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: primaryColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Colors.black)),
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: primaryColor,
          textStyle: const TextStyle(
              color: primaryTextColorLight, fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      );
}

enum Theme {
  system,
  light,
  dark,
}

extension ThemeExtensions on Theme {
  String? localize(BuildContext context) {
    switch (this) {
      case Theme.light:
        return AppLocalizations.of(context)?.theme_light;
      case Theme.dark:
        return AppLocalizations.of(context)?.theme_dark;
      case Theme.system:
        return AppLocalizations.of(context)?.theme_system;
    }
  }
}
