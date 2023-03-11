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


part 'date_inizio_fine_curriculum_dto.g.dart';

part 'date_inizio_fine_curriculum_dto.freezed.dart';

@freezed
class DateInizioFineCurriculumDTO with _$DateInizioFineCurriculumDTO{
  const factory DateInizioFineCurriculumDTO({
    //@JsonKey(name: 'timestamp') Streaming? timestamp,
    @JsonKey(name: 'date') DateDTO? date,
  }) = _DateInizioFineCurriculumDTO;

  factory DateInizioFineCurriculumDTO.fromJson(Map<String, dynamic> json) => _$DateInizioFineCurriculumDTOFromJson(json);
}

@freezed
class DateDTO with _$DateDTO{
  const factory DateDTO({
    //@JsonKey(name: 'timestamp') Streaming? timestamp,
    @JsonKey(name: '1') DatedescriptionDTO? datedescription,
  }) = _DateDTO;

  factory DateDTO.fromJson(Map<String, dynamic> json) => _$DateDTOFromJson(json);
}

@freezed
class DatedescriptionDTO with _$DatedescriptionDTO{
  const factory DatedescriptionDTO({
    //@JsonKey(name: 'timestamp') Streaming? timestamp,
    @JsonKey(name: 'AnnoCorso') String? annoCorso,
    @JsonKey(name: 'DataInizio') String? dataInizio,
    @JsonKey(name: 'DataFine') String? dataFine,
  }) = _DatedescriptionDTO;

  factory DatedescriptionDTO.fromJson(Map<String, dynamic> json) => _$DatedescriptionDTOFromJson(json);
}


