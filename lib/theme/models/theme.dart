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
  static const primaryColor = Color(0xFF3476CE);
  static const primaryColorDark = Color(0xFF141A24);
  static const secondaryColor = primaryColor;
  static const onSecondaryColor = primaryColorDark;

  static get make => ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          surface: secondaryColor,
          onSecondary: onSecondaryColor,
        ),
        brightness: Brightness.light,
        scaffoldBackgroundColor: primaryColorDark,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
        ),
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.transparent,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF141821),
          border: OutlineInputBorder(),
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          hoverColor: Colors.white,
          focusColor: Colors.white,
          iconColor: primaryColor,
          prefixIconColor: primaryColor,
          suffixIconColor: primaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
        cardTheme: const CardTheme(
          clipBehavior: Clip.hardEdge,
          color: Colors.white,
          margin: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(),
        ),
      );
}

class DarkTheme {
  static const primaryColor = Color(0xFF3476CE);
  static const primaryColorDark = Color(0xFF141A24);
  static const secondaryColor = primaryColor;
  static const onSecondaryColor = primaryColorDark;

  static get make => ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          secondary: secondaryColor,
          surface: secondaryColor,
          onSecondary: onSecondaryColor,
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: primaryColorDark,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
        ),
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: primaryColorDark,
          centerTitle: false,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF141821),
          border: OutlineInputBorder(),
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          hoverColor: Colors.white,
          focusColor: Colors.white,
          iconColor: primaryColor,
          prefixIconColor: primaryColor,
          suffixIconColor: primaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            foregroundColor: Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
        cardTheme: const CardTheme(
          clipBehavior: Clip.hardEdge,
          color: Colors.white,
          margin: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(),
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
