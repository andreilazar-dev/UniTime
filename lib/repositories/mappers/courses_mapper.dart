/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:school_timetable/misc/mappers/dto_mapper.dart';
import 'package:school_timetable/models/courses/course.dart';
import 'package:school_timetable/models/courses/school.dart';
import 'package:school_timetable/models/courses/teaching.dart';
import 'package:school_timetable/models/courses/year.dart';
import 'package:school_timetable/services/network/dto/courses/course_list_response.dart';
import 'package:school_timetable/models/courses/courses.dart';
import 'package:school_timetable/models/courses/periodo.dart';

class CoursesMapper extends DTOMapper<CourseListResponse, Courses> {
  @override
  Courses toModel(CourseListResponse dto) => Courses(
        elencoCorsi: dto.elencoCorsi
            .map(
              (corso) => Course(
                  years: corso.elencoAnni
                      .map((year) => Year(
                          label: year.label,
                          valore: year.valore,
                          elencoInsegnamenti: year.elencoInsegnamenti
                              .map((list) => Teaching(
                                  label: list.label,
                                  valore: list.valore,
                                  id: list.id,
                                  idPeriodo: list.idPeriodo,
                                  docente: list.docente))
                              .toList(),
                          orderLbl: year.orderLbl,
                          external: year.external))
                      .toList(),
                  label: corso.label,
                  tipo: corso.tipo,
                  tipoID: corso.tipoID,
                  valore: corso.valore,
                  cdlId: corso.cdlId,
                  scuola: corso.scuola,
                  pubType: corso.pubType,
                  defaultGrid: corso.defaultGrid,
                  pubPeriodi: corso.pubPeriodi
                      .map(
                        (periodo) => Periodo(
                            label: periodo.label,
                            valore: periodo.valore,
                            pub: periodo.pub,
                            id: periodo.id,
                            aaId: periodo.aaId,
                            facoltaCode: periodo.facoltaCode),
                      )
                      .toList(),
                  periodi: corso.periodi
                      .map(
                        (periodo) => Periodo(
                            label: periodo.label,
                            valore: periodo.valore,
                            pub: periodo.pub,
                            id: periodo.id,
                            aaId: periodo.aaId,
                            facoltaCode: periodo.facoltaCode),
                      )
                      .toList(),
                  facoltaId: corso.facoltaId,
                  facoltaCode: corso.facoltaCode),
            )
            .toList(),
        elencoScuole: dto.elencoScuole != null
            ? dto.elencoScuole
                ?.map((scuola) =>
                    School(label: scuola.label, valore: scuola.valore))
                .toList()
            : null,
      );

  @override
  CourseListResponse toTrasferObject(Courses model) {
    // TODO: implement toTrasferObject
    throw UnimplementedError();
  }
}
