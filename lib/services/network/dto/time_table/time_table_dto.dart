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
import 'package:intl/intl.dart';

import 'celle_dto.dart';
import 'date_inizio_fine_curriculum_dto.dart';
import 'fasce_dto.dart';
import 'giorno_dto.dart';
import 'legenda_dto.dart';

part 'time_table_dto.g.dart';

part 'time_table_dto.freezed.dart';

@freezed
class TimeTableDTO with _$TimeTableDTO {
  const factory TimeTableDTO({
    @JsonKey(name: 'day') required String day,
    @JsonKey(name: 'data') required String data,
    @JsonKey(name: 'giorni') required List<GiornoDTO> giorni,
    @JsonKey(name: 'first_day') required String first_day,
    @JsonKey(name: 'last_day') required String last_day,
    @JsonKey(name: 'first_day_label') required String first_day_label,
    @JsonKey(name: 'last_day_label') required String last_day_label,
    @JsonKey(name: 'first_day_timestamp') required double first_day_timestamp,
    @JsonKey(name: 'last_day_timestamp') required double last_day_timestamp,
    @JsonKey(name: 'anno') required String anno,
    @JsonKey(name: 'fasce') List<FasceDTO>? fasce,
    @JsonKey(name: 'granularita') String? granularita,
    @JsonKey(name: 'start_slot') String? startSlot,
    @JsonKey(name: 'end_slot') String? endSlot,
    @JsonKey(name: 'num_fasce') int? numFasce,
    @JsonKey(name: 'num_giorni') int? numGiorni,
    @JsonKey(name: 'orario_tipo') int? orarioTipo,
    @JsonKey(name: 'colori') List<String>? colori,
    @JsonKey(name: 'lang') String? lang,
    @JsonKey(name: 'tipo') String? tipo,
    @JsonKey(name: 'aa') String? aa,
    @JsonKey(name: 'anno_accademico') String? annoAccademico,
    @JsonKey(name: 'cds') String? cds,
    @JsonKey(name: 'anno2') List<String>? anno2,
    @JsonKey(name: 'curr_codes') List<String>? currCodes,
    //@JsonKey(name: 'docente') Null? docente,
    //@JsonKey(name: 'attivita') List<Null>? attivita,
    @JsonKey(name: 'celle') List<CelleDTO>? celle,
    @JsonKey(name: 'legenda') List<LegendaDTO>? legenda,
    //@JsonKey(name: 'note_generali') List<NoteGenerali>? noteGenerali,
    @JsonKey(name: 'date_inizio_fine_curriculum')
        List<String>? dateInizioFineCurriculum,
    //@JsonKey(name: 'nota_cdl') List<Null>? notaCdl,
    @JsonKey(name: 'curricula_course') String? curriculaCourse,
    @JsonKey(name: 'now_timestamp') double? nowTimestamp,
    @JsonKey(name: 'file_timestamp') double? fileTimestamp,
    @JsonKey(name: 'file_date') String? fileDate,
    @JsonKey(name: 'file_date_txt') String? fileDateTxt,
    @JsonKey(name: 'all_events') int? allEvents,
    @JsonKey(name: 'max_num_events_in_a_day') int? maxNumEventsInADay,
    @JsonKey(name: 'contains_data') int? containsData,
    //@JsonKey(name: 'matrix_mask_orizontal_grid') MatrixMaskOrizontalGrid? matrixMaskOrizontalGrid,
  }) = _TimeTableDTO;

  factory TimeTableDTO.fromJson(Map<String, dynamic> json) =>
      _$TimeTableDTOFromJson(json);
}
