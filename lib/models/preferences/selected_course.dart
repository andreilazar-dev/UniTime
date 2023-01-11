/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:school_timetable/models/academic_year.dart';

part 'selected_course.g.dart';
part 'selected_course.freezed.dart';

@freezed
class SelectedCourse with _$SelectedCourse {
  const factory SelectedCourse({
    required String corso,
    required String textcurr,
    required AcademicYear anno,
    required List<String> anno2,
  }) = _SelectedCourse;

  factory SelectedCourse.fromJson(Map<String, dynamic> json) =>
      _$SelectedCourseFromJson(json);
}
