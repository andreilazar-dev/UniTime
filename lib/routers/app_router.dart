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
import 'package:school_timetable/pages/daily_lessons_page.dart';
import 'package:school_timetable/pages/home.dart';
import 'package:school_timetable/pages/main_page.dart';
import 'package:school_timetable/pages/settings/filter_modules_page.dart';
import 'package:school_timetable/pages/settings/manage_courses_page.dart';
import 'package:school_timetable/pages/overview_page.dart';
import 'package:school_timetable/pages/registration/details/registration_details_page.dart';
import 'package:school_timetable/pages/registration/registration_homepage.dart';
import 'package:school_timetable/pages/settings/settings_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  preferRelativeImports: false,
  routes: <AutoRoute>[
    AutoRoute(initial: true, page: MainPage),
    AutoRoute(
      path: 'registration',
      page: RegistrationHomePage,
      fullscreenDialog: true,
    ),
    AutoRoute(path: 'details', page: RegistrationDetailsPage),
    AutoRoute(page: HomePage, children: [
      AutoRoute(page: DailyLessonsPage, initial: true),
      AutoRoute(page: OverviewPage),
      AutoRoute(page: SettingsPage),
    ]),
    AutoRoute(path: 'filter_modules', page: FilterModulesPage),
    AutoRoute(path: 'manage_courses', page: ManageCoursesPage),
  ],
)
class $AppRouter {}
