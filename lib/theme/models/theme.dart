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
  static const backgroundColor = Color(0xFFFDFDFD);
  static const primaryColor = Color(0xFF3476CE);
  static const primaryColorDark = Color(0xFF141A24);
  static const secondaryColor = primaryColor;
  static const onSecondaryColor = primaryColorDark;

  static get make =>
      // ThemeData(
      //   primaryColor: primaryColor,
      //   primaryColorDark: primaryColorDark,
      //   colorScheme: const ColorScheme.light(
      //     primary: primaryColor,
      //     secondary: secondaryColor,
      //     surface: secondaryColor,
      //     onSecondary: onSecondaryColor,
      //   ),
      //   brightness: Brightness.light,
      //   scaffoldBackgroundColor: primaryColorDark,
      //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
      //     backgroundColor: primaryColor,
      //   ),
      //   fontFamily: 'Inter',
      //   appBarTheme: const AppBarTheme(
      //     elevation: 0,
      //     color: Colors.transparent,
      //   ),
      //   inputDecorationTheme: const InputDecorationTheme(
      //     filled: true,
      //     fillColor: Color(0xFF141821),
      //     border: OutlineInputBorder(),
      //     alignLabelWithHint: true,
      //     floatingLabelBehavior: FloatingLabelBehavior.never,
      //     labelStyle: TextStyle(
      //       color: Colors.white,
      //     ),
      //     hintStyle: TextStyle(
      //       color: Colors.white,
      //     ),
      //     hoverColor: Colors.white,
      //     focusColor: Colors.white,
      //     iconColor: primaryColor,
      //     prefixIconColor: primaryColor,
      //     suffixIconColor: primaryColor,
      //   ),
      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(8),
      //       ),
      //     ),
      //   ),
      //   textButtonTheme: TextButtonThemeData(
      //     style: TextButton.styleFrom(
      //       foregroundColor: Colors.white,
      //     ),
      //   ),
      //   cardTheme: const CardTheme(
      //     clipBehavior: Clip.hardEdge,
      //     color: Colors.white,
      //     margin: EdgeInsets.zero,
      //     elevation: 0,
      //     shape: RoundedRectangleBorder(),
      //   ),
      // );
      ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFDFDFD),
        backgroundColor: const Color(0xFFFDFDFD),
        //#Used for check box
        disabledColor: const Color(0xFF3E3E70),
        unselectedWidgetColor: const Color(0xFF3E3E70),
        selectedRowColor: const Color.fromRGBO(114, 114, 186, 1),
        fontFamily: 'Roboto',
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF3E3E70),
          textTheme: ButtonTextTheme.primary,
        ),
        snackBarTheme: const SnackBarThemeData(
            backgroundColor: Color(0xFF3E3E70),
            contentTextStyle: TextStyle(
              fontFamily: 'Roboto-Medium',
              color: Color.fromRGBO(255, 255, 252, 1),
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
          primary: const Color(0xFF3E3E70),
        )),
        textTheme: const TextTheme(
          headline1: TextStyle(
              color: Color(0xFF06070D),
              fontSize: 48,
              fontWeight: FontWeight.normal,
              shadows: [
                Shadow(
                    // bottomLeft
                    offset: Offset(-1, -1),
                    color: Colors.black),
                Shadow(
                    // bottomRight
                    offset: Offset(1, -1),
                    color: Colors.black),
                Shadow(
                    // topRight
                    offset: Offset(1, 1),
                    color: Colors.black),
                Shadow(
                    // topLeft
                    offset: Offset(-1, 1),
                    color: Colors.black),
              ]),
          headline2: TextStyle(
            color: Color(0xFF06070D),
            fontSize: 24,
            // height: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          //selectedItemColor: Color.fromRGBO(97, 97, 168, 1),
          unselectedItemColor: Color.fromRGBO(118, 118, 122, 1),
          backgroundColor: Color.fromRGBO(226, 226, 226, 0.8),
        ),
        appBarTheme: const AppBarTheme(color: Color(0xFF3E3E70)),
        // elevatedButtonTheme: ElevatedButtonThemeData
        dialogTheme: DialogTheme(
          titleTextStyle: TextStyle(color: Color(0xFFFFFFFC)),
          contentTextStyle: TextStyle(color: Color(0xFFFFFFFC)),
          backgroundColor: Color.fromRGBO(62, 62, 112, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 0,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor:
                const Color(0xFFFFFFFC), // This is a custom color variable
          ),
        ),
        inputDecorationTheme:
            InputDecorationTheme(fillColor: const Color(0xFFFFFFFC)),
      );
}

class DarkTheme {
  static const primaryColor = Color(0xFF3476CE);
  static const primaryColorDark = Color(0xFF141A24);
  static const secondaryColor = primaryColor;
  static const onSecondaryColor = primaryColorDark;

  static get make =>
      // ThemeData(
      //   primaryColor: primaryColor,
      //   primaryColorDark: primaryColorDark,
      //   colorScheme: const ColorScheme.dark(
      //     primary: primaryColor,
      //     secondary: secondaryColor,
      //     surface: secondaryColor,
      //     onSecondary: onSecondaryColor,
      //   ),
      //   brightness: Brightness.dark,
      //   scaffoldBackgroundColor: primaryColorDark,
      //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
      //     backgroundColor: primaryColor,
      //   ),
      //   fontFamily: 'Inter',
      //   appBarTheme: const AppBarTheme(
      //     elevation: 0,
      //     color: primaryColorDark,
      //     centerTitle: false,
      //   ),
      //   inputDecorationTheme: const InputDecorationTheme(
      //     filled: true,
      //     fillColor: Color(0xFF141821),
      //     border: OutlineInputBorder(),
      //     alignLabelWithHint: true,
      //     floatingLabelBehavior: FloatingLabelBehavior.never,
      //     labelStyle: TextStyle(
      //       color: Colors.white,
      //     ),
      //     hintStyle: TextStyle(
      //       color: Colors.white,
      //     ),
      //     hoverColor: Colors.white,
      //     focusColor: Colors.white,
      //     iconColor: primaryColor,
      //     prefixIconColor: primaryColor,
      //     suffixIconColor: primaryColor,
      //   ),
      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(8),
      //       ),
      //       foregroundColor: Colors.white,
      //     ),
      //   ),
      //   textButtonTheme: TextButtonThemeData(
      //     style: TextButton.styleFrom(
      //       foregroundColor: Colors.white,
      //     ),
      //   ),
      //   cardTheme: const CardTheme(
      //     clipBehavior: Clip.hardEdge,
      //     color: Colors.white,
      //     margin: EdgeInsets.zero,
      //     elevation: 0,
      //     shape: RoundedRectangleBorder(),
      //   ),
      // );
      ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromRGBO(36, 36, 66, 1),
        backgroundColor: const Color.fromRGBO(36, 36, 66, 1),
        fontFamily: 'Roboto',
        //#Used for checkbox
        disabledColor: const Color(0xFF3E3E70),
        unselectedWidgetColor: const Color(0xFF3E3E70),
        selectedRowColor: const Color.fromRGBO(114, 114, 186, 1),
        appBarTheme: const AppBarTheme(color: Color(0xFF3E3E70)),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color.fromRGBO(97, 97, 168, 1),
          textTheme: ButtonTextTheme.primary,
        ),
        snackBarTheme: const SnackBarThemeData(
            backgroundColor: Color(0xFF3E3E70),
            contentTextStyle: TextStyle(
              fontFamily: 'Roboto-Medium',
              color: Color.fromRGBO(255, 255, 252, 1),
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
          primary: const Color.fromRGBO(97, 97, 168, 1),
        )),
        textTheme: const TextTheme(
          headline1: TextStyle(
              color: Color(0xFFFFFFFC),
              fontSize: 48,
              fontWeight: FontWeight.normal,
              shadows: [
                Shadow(
                    // bottomLeft
                    offset: Offset(-1, -1),
                    color: Colors.white),
                Shadow(
                    // bottomRight
                    offset: Offset(1, -1),
                    color: Colors.white),
                Shadow(
                    // topRight
                    offset: Offset(1, 1),
                    color: Colors.white),
                Shadow(
                    // topLeft
                    offset: Offset(-1, 1),
                    color: Colors.white),
              ]),
          headline2: TextStyle(
            color: Color(0xFFFFFFFC),
            fontSize: 24,
            // height: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          //selectedItemColor: Color.fromRGBO(97, 97, 168, 1),
          unselectedItemColor: Color.fromRGBO(36, 36, 66, 1),
          backgroundColor: Color.fromRGBO(97, 97, 168, 0.6),
        ),
        dialogTheme: DialogTheme(
          titleTextStyle: TextStyle(color: Color(0xFFFFFFFC)),
          contentTextStyle: TextStyle(color: Color(0xFFFFFFFC)),
          backgroundColor: Color.fromRGBO(97, 97, 168, 0.7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 0,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor:
                const Color(0xFFFFFFFC), // This is a custom color variable
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color(0xFF3E3E70),
          enabledBorder: const OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              borderSide: const BorderSide(color: Colors.black)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              borderSide: const BorderSide(color: Colors.black)),
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: const Color(0xFF3E3E70),
          shape: RoundedRectangleBorder(
            // side: BorderSide(
            //   color: Colors.greenAccent,
            // ),
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
