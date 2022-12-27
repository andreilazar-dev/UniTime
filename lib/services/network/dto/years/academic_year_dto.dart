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

part 'academic_year_dto.g.dart';

part 'academic_year_dto.freezed.dart';

@freezed
class AcademicYearDTO with _$AcademicYearDTO {
  const factory AcademicYearDTO({
    @JsonKey(name: 'label') required String label,
    @JsonKey(name: 'valore') required String value,
  }) = _AcademicYearDTO;

  factory AcademicYearDTO.fromJson(Map<String,dynamic> json) =>
      _$AcademicYearDTOFromJson(json);

}
