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
import 'package:school_timetable/di/dependency_injector.dart';
import 'package:school_timetable/routers/app_router.gr.dart';
import 'package:school_timetable/theme/models/theme.dart';
import 'package:school_timetable/theme/widgets/theme_selector.dart';

class App extends StatelessWidget {
  final _router = AppRouter();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DependencyInjector(
        child: ThemeSelector(
          builder: (context, mode) => MaterialApp.router(
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)?.app_name ?? 'UniTime',
            debugShowCheckedModeBanner: false,
            routeInformationParser: _router.defaultRouteParser(),
            routerDelegate: _router.delegate(),
            theme: LightTheme.make,
            darkTheme: DarkTheme.make,
            themeMode: mode,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        ),
      );

  // ThemeData _theme(BuildContext context) {
  //   final primaryColor = Colors.blue[700]!;
  //   final primaryColorDark = Colors.blue[900]!;
  //   const secondaryColor = Colors.orange;
  //   final onSecondaryColor = Colors.grey[100]!;
  //
  //   return ThemeData(
  //     primaryColor: primaryColor,
  //     primaryColorDark: primaryColorDark,
  //     colorScheme: ColorScheme.light(
  //       primary: primaryColor,
  //       secondary: secondaryColor,
  //       surface: secondaryColor,
  //       onSecondary: onSecondaryColor,
  //     ),
  //     brightness: Brightness.light,
  //     floatingActionButtonTheme: FloatingActionButtonThemeData(
  //       backgroundColor: primaryColor,
  //     ),
  //   );
  // }
  //
  // ThemeData _darkTheme(BuildContext context) {
  //   final primaryColor = Colors.blue[700]!;
  //   final primaryColorDark = Colors.blue[900]!;
  //   const secondaryColor = Colors.orange;
  //   const surfaceColor = Colors.black26;
  //
  //   return ThemeData(
  //     primaryColor: primaryColor,
  //     primaryColorDark: primaryColorDark,
  //     colorScheme: ColorScheme.dark(
  //       primary: primaryColor,
  //       secondary: secondaryColor,
  //       surface: surfaceColor,
  //     ),
  //     brightness: Brightness.dark,
  //     floatingActionButtonTheme: FloatingActionButtonThemeData(
  //       backgroundColor: primaryColor,
  //     ),
  //   );
  // }
}
