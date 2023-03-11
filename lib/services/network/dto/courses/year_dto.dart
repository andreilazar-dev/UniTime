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
import 'package:school_timetable/services/network/dto/courses/teaching_dto.dart';

part 'year_dto.g.dart';

part 'year_dto.freezed.dart';

@freezed
class YearDTO with _$YearDTO{
  const factory YearDTO({
    @JsonKey(name: 'label') required String label,
    @JsonKey(name: 'valore') required  String valore,
    @JsonKey(name: 'elenco_insegnamenti') required List<TeachingDTO> elencoInsegnamenti,
    @JsonKey(name: 'order_lbl') required String orderLbl,
    @JsonKey(name: 'external') required int external,
  }) = _YearDTO;

  factory YearDTO.fromJson(Map<String, dynamic> json) => _$YearDTOFromJson(json);
}
