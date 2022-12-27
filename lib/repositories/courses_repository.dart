
/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:school_timetable/errors/network_error.dart';
import 'package:school_timetable/errors/repository_error.dart';
import 'package:school_timetable/models/academic_year.dart';
import 'package:school_timetable/models/courses.dart';
import 'package:school_timetable/repositories/mappers/courses_mapper.dart';
import 'package:school_timetable/services/network/dto/time_table/time_table_dto.dart';
import 'package:school_timetable/services/network/university_information_service.dart';
import 'package:school_timetable/repositories/mappers/accademic_year.dart';

class CoursesRepository {
  final UniversityInformationService universityInformationService;
  final CoursesMapper coursesMapper;
  final AcademicYearMapper academicYearMapper;

  CoursesRepository(
      {required this.universityInformationService,
      required this.coursesMapper,
      required this.academicYearMapper});

  Future<List<AcademicYear>> academicYears() async {
    try {
      final response = await universityInformationService.academicYear();
      return response.map(academicYearMapper.toModel).toList(growable: false);
    } on NetworkError catch (error) {
      throw RepositoryError(error);
    }
  }


  Future<Courses> courses() async {
    try {
      final response = await universityInformationService.courseList(aa: '2022');
      return coursesMapper.toModel(response);
    } on NetworkError catch (error) {
      throw RepositoryError(error);
    }
  }

  Future<TimeTableDTO> lessons() async {
    try {
      final response = await universityInformationService.timetable(textcurr: '1+-+UNICO', anno: '2022',anno2: '999|1',date: '20-12-2022', corso: '419',);
      //return coursesMapper.toModel(response);
      return response;
    } on NetworkError catch (error) {
      throw RepositoryError(error);
    }
  }

}
