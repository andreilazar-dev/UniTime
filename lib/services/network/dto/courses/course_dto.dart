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
import 'package:school_timetable/services/network/dto/courses/periodo_dto.dart';

part 'course_dto.g.dart';

part 'course_dto.freezed.dart';

@freezed
class CourseDTO with _$CourseDTO{
  const factory CourseDTO({
    @JsonKey(name: 'label') required String label,
    @JsonKey(name: 'tipo') required String tipo,
    @JsonKey(name: 'TipoID') required String tipoID,
    @JsonKey(name: 'valore') required String valore,
    @JsonKey(name: 'cdl_id') required String cdlId,
    @JsonKey(name: 'scuola') required String scuola,
    @JsonKey(name: 'pub_type') required String pubType,
    @JsonKey(name: 'default_grid') required String defaultGrid,
    @JsonKey(name: 'pub_periodi') required List<PeriodoDTO> pubPeriodi,
    @JsonKey(name: 'periodi') required List<PeriodoDTO> periodi,
    @JsonKey(name: 'facolta_id') required String facoltaId,
    @JsonKey(name: 'facolta_code') required String facoltaCode,
  }) = _CourseDTO;

  factory CourseDTO.fromJson(Map<String, dynamic> json) => _$CourseDTOFromJson(json);
}
