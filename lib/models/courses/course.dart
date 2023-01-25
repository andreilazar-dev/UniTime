/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:school_timetable/models/courses/periodo.dart';
import 'package:school_timetable/models/courses/year.dart';

part 'course.freezed.dart';

@freezed
class Course with _$Course {
  const factory Course({
    List<Year>? years,
    required String label,
    required String tipo,
    required String tipoID,
    required String valore,
    required String cdlId,
    required String scuola,
    String? pubType,
    required String defaultGrid,
    required List<Periodo> pubPeriodi,
    required List<Periodo> periodi,
    required String facoltaId,
    required String facoltaCode,
  }) = _Course;
}
