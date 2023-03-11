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
class CourseSettingState with _$CourseSettingState {
  const factory CourseSettingState.initial() = _InitCourseSettingState;
  const factory CourseSettingState.teachings(Course course) =
      _TeachingsCourseSettingState;
  const factory CourseSettingState.saved() = _SavedCourseSettingState;
}
