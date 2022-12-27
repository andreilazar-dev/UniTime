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

part 'legenda_dto.g.dart';

part 'legenda_dto.freezed.dart';

@freezed
class LegendaDTO with _$LegendaDTO {
  const factory LegendaDTO({
    @JsonKey(name: 'codice') String? codice,
    @JsonKey(name: 'nome') String? nome,
    @JsonKey(name: 'spunta') String? spunta,
    @JsonKey(name: 'tipo') String? tipo,
  }) = _LegendaDTO;

  factory LegendaDTO.fromJson(Map<String, dynamic> json) =>
      _$LegendaDTOFromJson(json);
}
