/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:school_timetable/errors/network_error.dart';
import 'package:school_timetable/errors/repository_error.dart';
import 'package:school_timetable/models/academic_year.dart';
import 'package:school_timetable/models/preferences/configuration.dart';
import 'package:school_timetable/models/timetable/time_table.dart';
import 'package:school_timetable/repositories/mappers/courses_mapper.dart';
import 'package:school_timetable/repositories/mappers/timetable_mapper.dto.dart';
import 'package:school_timetable/services/network/dto/time_table/time_table_dto.dart';
import 'package:school_timetable/services/network/university_information_service.dart';
import 'package:school_timetable/repositories/mappers/accademic_year_mapper.dart';
import 'package:school_timetable/models/courses/courses.dart';

class CoursesRepository {
  final UniversityInformationService universityInformationService;
  final CoursesMapper coursesMapper;
  final AcademicYearMapper academicYearMapper;
  final TimeTableMapper timeTableMapper;
  Configuration? _configuration;

  CoursesRepository(
      {required this.universityInformationService,
      required this.coursesMapper,
      required this.academicYearMapper,
      required this.timeTableMapper});

  void setConfiguration(Configuration configuration) =>
      this._configuration = configuration;

  Future<List<AcademicYear>> academicYears() async {
    try {
      final response = await universityInformationService.academicYear();
      return response.map(academicYearMapper.toModel).toList(growable: false);
    } on NetworkError catch (error) {
      throw RepositoryError(error);
    }
  }

  Future<Courses> courses({required String academicYear}) async {
    try {
      final response =
          await universityInformationService.courseList(aa: academicYear);
      return coursesMapper.toModel(response);
    } on NetworkError catch (error) {
      throw RepositoryError(error);
    }
  }

  Future<TimeTable> lessons(DateTime date) async {
    final reqdate = DateFormat("dd-MM-yyyy").format(date);
    if (_configuration != null) {
      try {
        List<Future<TimeTableDTO>> responses = _configuration!.selectedCourses
            .map((course) => universityInformationService.timetable(
                  textcurr: course.textcurr,
                  anno: course.anno.value,
                  anno2: course.anno2,
                  date: reqdate,
                  corso: course.corso,
                ))
            .toList();
        final obj = await Future.wait(responses);
        //TODO: Implement filter mode for merge multiple course
        return obj.map(timeTableMapper.toModel).toList()[0];
      } on NetworkError catch (error) {
        debugPrintStack(stackTrace: error.stackTrace);
        throw RepositoryError(error);
      } on Exception catch (error) {
        throw Exception(error);
      }
    } else {
      throw Exception();
    }
  }
}
