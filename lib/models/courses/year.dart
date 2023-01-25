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
import 'package:school_timetable/models/courses/teaching.dart';

part 'year.freezed.dart';

part 'year.g.dart';

@freezed
class Year with _$Year {
  const factory Year({
    required String label,
    required String valore,
    required List<Teaching> elencoInsegnamenti,
    required String orderLbl,
    required int external,
  }) = _Year;

  factory Year.fromJson(Map<String, dynamic> json) => _$YearFromJson(json);
}
