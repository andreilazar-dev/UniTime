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
import 'package:school_timetable/models/timetable/celle.dart';
import 'package:school_timetable/models/timetable/fasce.dart';

import 'package:school_timetable/models/timetable/giorno.dart';

// part 'time_table.g.dart';

part 'time_table.freezed.dart';

@freezed
class TimeTable with _$TimeTable {
  const factory TimeTable({
    required String day,
    required String data,
    required List<Giorno> giorni,
    required String firstDay,
    required String lastDay,
    required String firstDayLabel,
    required String lastDayLabel,
    required double firstDayTimestamp,
    required double lastDayTimestamp,
    required String anno,
    List<Fasce>? fasce,
    String? granularita,
    String? startSlot,
    String? endSlot,
    int? numFasce,
    int? numGiorni,
    int? orarioTipo,
    //List<String>? colori,
    String? lang,
    String? tipo,
    String? aa,
    String? annoAccademico,
    String? cds,
    List<String>? anno2,
    List<String>? currCodes,
    List<Celle>? celle,
    //List<Legenda>? legenda,
    List<String>? dateInizioFineCurriculum,
    String? curriculaCourse,
    double? nowTimestamp,
    double? fileTimestamp,
    String? fileDate,
    //String? fileDateTxt,
    int? allEvents,
    int? maxNumEventsInADay,
    int? containsData,
  }) = _TimeTable;

// factory TimeTable.fromJson(Map<String, dynamic> json) =>
//     _$TimeTableFromJson(json);
}
