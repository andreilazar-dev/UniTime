/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:school_timetable/errors/generic_error.dart';
import 'package:school_timetable/errors/network_error.dart';
import 'package:school_timetable/errors/repository_error.dart';
import 'package:school_timetable/misc/date_util.dart';
import 'package:school_timetable/models/academic_year.dart';
import 'package:school_timetable/models/courses/year.dart';
import 'package:school_timetable/models/preferences/configuration.dart';
import 'package:school_timetable/models/preferences/selected_course.dart';
import 'package:school_timetable/models/timetable/celle.dart';
import 'package:school_timetable/models/timetable/time_table.dart';
import 'package:school_timetable/repositories/mappers/courses_mapper.dart';
import 'package:school_timetable/repositories/mappers/timetable_mapper.dto.dart';
import 'package:school_timetable/repositories/mappers/years_mapper.dart';
import 'package:school_timetable/services/network/dto/time_table/time_table_dto.dart';
import 'package:school_timetable/services/network/university_information_service.dart';
import 'package:school_timetable/repositories/mappers/accademic_year_mapper.dart';
import 'package:school_timetable/models/courses/courses.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kAppCached = "APP_CACHEDTIMETABLE";

class CoursesRepository {
  final UniversityInformationService universityInformationService;
  final CoursesMapper coursesMapper;
  final AcademicYearMapper academicYearMapper;
  final TimeTableMapper timeTableMapper;
  final YearsMapper yearsMapper;
  Configuration? _configuration;
  final Future<SharedPreferences> sharedPreferences;

  CoursesRepository({
    required this.universityInformationService,
    required this.coursesMapper,
    required this.academicYearMapper,
    required this.timeTableMapper,
    required this.yearsMapper,
    required this.sharedPreferences,
  });

  void setConfiguration(Configuration configuration) =>
      _configuration = configuration;

  Future<List<AcademicYear>> academicYears() async {
    try {
      final response = await universityInformationService.academicYear();
      return response.map(academicYearMapper.toModel).toList(growable: false);
    } on NetworkError catch (error) {
      throw RepositoryError(error);
    } catch (e) {
      log("Generic RepositoryError", name: "Course_Repository academicYears");
      throw RepositoryError(e);
    }
  }

  Future<Courses> courses({required String academicYear}) async {
    try {
      final response =
          await universityInformationService.courseList(aa: academicYear);
      return coursesMapper.toModel(response);
    } on NetworkError catch (error) {
      throw RepositoryError(error);
    } catch (e) {
      log("Generic RepositoryError", name: "Course_Repository courses");
      throw RepositoryError(e);
    }
  }

  Future<List<Year>> courseYears(
      {required String courseValue,
      required String academicYear,
      required String code}) async {
    try {
      final response = await universityInformationService.yearList(
          code: code, academicYear: academicYear, courseValue: courseValue);
      return yearsMapper.toModel(response);
    } on NetworkError catch (error) {
      throw RepositoryError(error);
    } catch (e) {
      log("Generic RepositoryError", name: "Course_Repository courseYears");
      throw RepositoryError(e);
    }
  }

  Future<List<TimeTable>> lessons(DateTime date) async {
    final reqdate = DateFormat("dd-MM-yyyy").format(date);
    if (_configuration != null) {
      try {
        List<Future<TimeTableDTO>> responses = _configuration!.selectedCourses
            .map((course) => universityInformationService.timetable(
                  textcurr: course.years.map((e) => e.label).join(),
                  anno: course.anno.value,
                  anno2: course.years.map((e) => e.valore).toList(),
                  date: reqdate,
                  corso: course.corso,
                ))
            .toList();
        final obj = await Future.wait(responses);
        return _filtering(obj.map(timeTableMapper.toModel).toList());
      } on NetworkError catch (error) {
        //TODO: ADDED CACHE
        // _cachedTimetable(date);
        throw RepositoryError(error);
      } catch (e) {
        log("Generic RepositoryError", name: "Course_Repository lessons");
        throw RepositoryError(e);
      }
    } else {
      throw GenericError();
    }
  }

  Future<TimeTable> dailyLessons(DateTime date) async {
    List<TimeTable> timeTables = await lessons(date);
    List<Celle> celle = [];
    String day = DateFormat('dd-MM-yyyy').format(date);
    for (TimeTable timeTable in timeTables) {
      for (Celle cella in timeTable.celle ?? []) {
        if (_sameDate(day, cella.data ?? "")) {
          celle.add(cella);
        }
      }
    }
    celle.sort((a, b) {
      final format = DateFormat.Hm();
      final oraA = format.parse(a.oraInizio ?? "");
      final oraB = format.parse(b.oraInizio ?? "");
      return oraA.compareTo(oraB);
    });
    return timeTables[0].copyWith(celle: celle);
  }

  List<TimeTable> _filtering(List<TimeTable> timetables) {
    List<TimeTable> filtered = [];
    for (SelectedCourse selected in _configuration!.selectedCourses) {
      for (TimeTable timeTable in timetables) {
        if (timeTable.cds == selected.corso) {
          List<Celle> celleTemp = [];
          for (Year year in selected.years) {
            for (Celle cella in timeTable.celle ?? []) {
              if (year.elencoInsegnamenti.any((element) =>
                  element.valore == cella.codiceInsegnamento &&
                  element.selected)) {
                celleTemp.add(cella);
              }
            }
          }
          filtered.add(timeTable.copyWith(celle: celleTemp));
        }
      }
    }
    return filtered;
  }

  // Future<List<TimeTable>> _cachedTimetable(DateTime date) async {
  //   final cached = (await sharedPreferences).getString(_kAppCached);
  //   if (cached != null) {
  //       final timetable = List<TimeTable>.from(json.decode(cached));
  //       AppDateUtils.isSameWeek(timetable.first.firstDayLabel,DateTime.now());
  //   }
  // }
  // bool _timeCompare(String time, String time2) {
  //   double first = double.parse(time.split(":")[0]) * 60 +
  //       double.parse(time.split(":")[1]);
  //   double second = double.parse(time2.split(":")[0]) * 60 +
  //       double.parse(time2.split(":")[1]);
  //   return first < second;
  // }

  bool _sameDate(String date1, String date2) {
    return date1 == date2;
  }
}
