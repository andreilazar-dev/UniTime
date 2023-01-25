/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:school_timetable/misc/mappers/dto_mapper.dart';
import 'package:school_timetable/models/timetable/celle.dart';
import 'package:school_timetable/models/timetable/fasce.dart';
import 'package:school_timetable/models/timetable/giorno.dart';
import 'package:school_timetable/models/timetable/time_table.dart';
import 'package:school_timetable/services/network/dto/time_table/time_table_dto.dart';

class TimeTableMapper extends DTOMapper<TimeTableDTO, TimeTable> {
  @override
  TimeTable toModel(TimeTableDTO dto) => TimeTable(
        day: dto.day,
        data: dto.data,
        giorni: dto.giorni
            .map((giorno) => Giorno(
                label: giorno.label, valore: giorno.valore, data: giorno.data))
            .toList(),
        first_day: dto.first_day,
        last_day: dto.last_day,
        first_day_label: dto.first_day_label,
        last_day_label: dto.last_day_label,
        first_day_timestamp: dto.first_day_timestamp,
        last_day_timestamp: dto.last_day_timestamp,
        anno: dto.anno,
        fasce: dto.fasce
            ?.map((fasce) => Fasce(label: fasce.label, valore: fasce.valore))
            .toList(),
        granularita: dto.granularita,
        startSlot: dto.startSlot,
        endSlot: dto.endSlot,
        numFasce: dto.numFasce,
        numGiorni: dto.numGiorni,
        orarioTipo: dto.orarioTipo,
        lang: dto.lang,
        tipo: dto.tipo,
        aa: dto.aa,
        annoAccademico: dto.annoAccademico,
        cds: dto.cds,
        anno2: dto.anno2,
        currCodes: dto.currCodes,
        celle: dto.celle
            ?.map((celle) => Celle(
                  mostraAula: celle.mostraAula,
                  tipologia: celle.tipologia,
                  //linkLezioneOnline: celle.linkLezioneOnline,
                  codiceInsegnamento: celle.codiceInsegnamento,
                  nomeInsegnamento: celle.nomeInsegnamento,
                  nome: celle.nome,
                  nameOriginal: celle.nameOriginal,
                  linkCorso: celle.linkCorso,
                  id: celle.id,
                  timestamp: celle.timestamp,
                  data: celle.data,
                  giornoCompleto: celle.giornoCompleto,
                  codiceAula: celle.codiceAula,
                  codiceSede: celle.codiceSede,
                  aula: celle.aula,
                  orario: celle.orario,
                  tipo: celle.tipo,
                  giorno: celle.giorno,
                  numeroGiorno: celle.numeroGiorno,
                  nomeGiorno: celle.nomeGiorno,
                  oraInizio: celle.oraInizio,
                  oraFine: celle.oraFine,
                  noteAula: celle.noteAula,
                  noteSettimanali: celle.noteSettimanali,
                  annullato: celle.annullato,
                  titoloLezione: celle.titoloLezione,
                  codiceDocente: celle.codiceDocente,
                  docente: celle.docente,
                  display: celle.display,
                  insegnamentoTipo: celle.insegnamentoTipo,
                ))
            .toList(),
        //dateInizioFineCurriculum: dto.dateInizioFineCurriculum,
        curriculaCourse: dto.curriculaCourse,
        nowTimestamp: dto.nowTimestamp,
        fileTimestamp: dto.fileTimestamp,
        fileDate: dto.fileDate,
        allEvents: dto.allEvents,
        maxNumEventsInADay: dto.maxNumEventsInADay,
        containsData: dto.containsData,
      );

  @override
  TimeTableDTO toTrasferObject(TimeTable model) {
    // TODO: implement toTrasferObject
    throw UnimplementedError();
  }
}
