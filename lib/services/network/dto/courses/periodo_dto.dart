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

part 'periodo_dto.g.dart';

part 'periodo_dto.freezed.dart';

@freezed
class PeriodoDTO with _$PeriodoDTO {
  const factory PeriodoDTO({
    @JsonKey(name: 'label') required String label,
    @JsonKey(name: 'valore') required String valore,
    @JsonKey(name: 'pub') required String pub,
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'aa_id') required String aaId,
    @JsonKey(name: 'facolta_code') required String facoltaCode,
  }) = _PeriodoDTO;

  factory PeriodoDTO.fromJson(Map<String, dynamic> json) => _$PeriodoDTOFromJson(json);
}
