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

part 'date_inizio_fine_curriculum.g.dart';

part 'date_inizio_fine_curriculum.freezed.dart';

@freezed
class DateInizioFineCurriculum with _$DateInizioFineCurriculum {
  const factory DateInizioFineCurriculum({
    Date? date,
  }) = _DateInizioFineCurriculum;

  factory DateInizioFineCurriculum.fromJson(Map<String, dynamic> json) =>
      _$DateInizioFineCurriculumFromJson(json);
}

@freezed
class Date with _$Date {
  const factory Date({
    Datedescription? datedescription,
  }) = _Date;

  factory Date.fromJson(Map<String, dynamic> json) => _$DateFromJson(json);
}

@freezed
class Datedescription with _$Datedescription {
  const factory Datedescription({
    String? annoCorso,
    String? dataInizio,
    String? dataFine,
  }) = _Datedescription;

  factory Datedescription.fromJson(Map<String, dynamic> json) =>
      _$DatedescriptionFromJson(json);
}
