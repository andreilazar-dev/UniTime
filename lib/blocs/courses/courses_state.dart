/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

part of 'courses_bloc.dart';

@freezed
class CoursesState with _$CoursesState {
  const factory CoursesState.fetching() = _FetchingCoursesState;

  const factory CoursesState.fetched(
          List<AcademicYear> accademicYears, Courses courses) =
      _FetchedCoursesState;

  const factory CoursesState.fetchedYears(List<Year> years) =
      _FetchedYearsCoursesState;

  const factory CoursesState.error() = _CoursesState;
}
