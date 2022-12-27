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
import 'package:school_timetable/services/network/dto/years/academic_year_dto.dart';
import 'package:school_timetable/models/academic_year.dart' ;

class AcademicYearMapper extends DTOMapper<AcademicYearDTO, AcademicYear> {
  @override
  AcademicYear toModel(AcademicYearDTO dto) =>
      AcademicYear(label: dto.label, value: dto.value);

  @override
  AcademicYearDTO toTrasferObject(AcademicYear model) {
    // TODO: implement toTrasferObject
    throw UnimplementedError();
  }
}
