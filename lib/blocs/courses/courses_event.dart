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
class CoursesEvent with _$CoursesEvent {
  const factory CoursesEvent.load() = _LoadCoursesEvent;
  const factory CoursesEvent.reload() = _ReloadCoursesEvent;
  const factory CoursesEvent.getYears(
          String courseValue, String academicYear, String code) =
      _GetYearsCoursesEvent;
}
