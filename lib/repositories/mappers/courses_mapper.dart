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
import 'package:school_timetable/models/course.dart';
import 'package:school_timetable/models/courses.dart';
import 'package:school_timetable/models/periodo.dart';
import 'package:school_timetable/models/school.dart';
import 'package:school_timetable/services/network/dto/courses/course_list_response.dart';

class CoursesMapper extends DTOMapper<CourseListResponse, Courses> {
  @override
  Courses toModel(CourseListResponse dto) => Courses(
        elencoCorsi: dto.elencoCorsi
            .map(
              (corso) => Course(
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
