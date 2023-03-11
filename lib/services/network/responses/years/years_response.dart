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
import 'package:school_timetable/services/network/dto/courses/year_dto.dart';

part 'years_response.g.dart';

part 'years_response.freezed.dart';

@freezed
class YearsResponse with _$YearsResponse {
  const factory YearsResponse({
    @JsonKey(name: 'elenco_anni') required List<YearDTO> elencoAnni,
  }) = _YearsResponse;

  factory YearsResponse.fromJson(Map<String, dynamic> json) =>
      _$YearsResponseFromJson(json);
}
