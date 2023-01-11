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

part 'academic_year.g.dart';
part 'academic_year.freezed.dart';

@freezed
class AcademicYear with _$AcademicYear {
  const factory AcademicYear({
    required String label,
    required String value,
  }) = _AcademicYear;

  factory AcademicYear.fromJson(Map<String, dynamic> json) =>
      _$AcademicYearFromJson(json);
}
