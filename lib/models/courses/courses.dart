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
import 'package:school_timetable/models/school.dart';
import 'course.dart';

part 'courses.freezed.dart';

@freezed
class Courses with _$Courses {
  const factory Courses({
    required List<Course> elencoCorsi,
    List<School>? elencoScuole,
  }) = _Courses;
}
