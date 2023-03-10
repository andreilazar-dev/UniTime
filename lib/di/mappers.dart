/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

part of 'dependency_injector.dart';

final List<SingleChildWidget> _mappers = [
  Provider<CoursesMapper>(
    create: (_) => CoursesMapper(),
  ),
  Provider<AcademicYearMapper>(
    create: (_) => AcademicYearMapper(),
  ),
  Provider<TimeTableMapper>(
    create: (_) => TimeTableMapper(),
  ),
  Provider<YearsMapper>(
    create: (_) => YearsMapper(),
  ),
];
