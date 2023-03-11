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
import 'package:school_timetable/models/courses/year.dart';
import 'package:school_timetable/services/network/dto/courses/year_dto.dart';
import 'package:school_timetable/models/courses/teaching.dart';

class YearsMapper extends DTOMapper<List<YearDTO>, List<Year>> {
  @override
  List<Year> toModel(List<YearDTO> dto) => dto
      .map((e) => Year(
          label: e.label,
          valore: e.valore,
          elencoInsegnamenti: e.elencoInsegnamenti
              .map((list) => Teaching(
                  label: list.label,
                  valore: list.valore,
                  id: list.id,
                  idPeriodo: list.idPeriodo,
                  docente: list.docente))
              .toList(),
          orderLbl: e.orderLbl,
          external: e.external))
      .toList();

  @override
  List<YearDTO> toTrasferObject(List<Year> model) {
    // TODO: implement toTrasferObject
    throw UnimplementedError();
  }
}
