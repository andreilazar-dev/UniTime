/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

part of 'course_setting_bloc.dart';

@freezed
class CourseSettingEvent with _$CourseSettingEvent {
  const factory CourseSettingEvent.selection() = _SelectionCourseSettingEvent;
  const factory CourseSettingEvent.chosen(
      AcademicYear academicYear, Course course) = _ChosenCourseSettingEvent;
  const factory CourseSettingEvent.saving(Course course) =
      _SavingCourseSettingEvent;
}
