/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:auto_route/auto_route.dart';
import 'package:school_timetable/pages/main_page.dart';
import 'package:school_timetable/pages/settings/settings_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  preferRelativeImports: false,
  routes: <AutoRoute>[
    AutoRoute(initial: true, page: MainPage),
    AutoRoute(page: SettingsPage),
    // TODO: specify some routes
  ],
)
class $AppRouter {}
