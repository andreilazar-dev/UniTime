/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:school_timetable/models/courses/year.dart';
import 'package:school_timetable/repositories/courses_repository.dart';
import 'package:school_timetable/models/academic_year.dart';
import 'package:school_timetable/models/courses/courses.dart';

part 'courses_bloc.freezed.dart';

part 'courses_event.dart';

part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesRepository coursesRepository;

  CoursesBloc({required this.coursesRepository})
      : super(CoursesState.fetching()) {
    on<_LoadCoursesEvent>(_onLoad);
    on<_GetYearsCoursesEvent>(_onGetYears);
  }

  Future<void> _onLoad(
      _LoadCoursesEvent event, Emitter<CoursesState> emit) async {
    try {
      emit(CoursesState.fetching());
      final academicYears = await coursesRepository.academicYears();
      final courses =
          await coursesRepository.courses(academicYear: academicYears[0].value);
      if (courses != null) {
        emit(CoursesState.fetched(academicYears, courses));
      } else {
        emit(CoursesState.error());
      }
    } catch (error) {
      emit(CoursesState.error());
    }
  }

  Future<void> _onGetYears(
      _GetYearsCoursesEvent event, Emitter<CoursesState> emit) async {
    try {
      final years = await coursesRepository.courseYears(
          courseValue: event.courseValue,
          academicYear: event.academicYear,
          code: event.code);
      if (years != null) {
        emit(CoursesState.fetchedYears(years));
      } else {
        emit(CoursesState.error());
      }
    } catch (error) {
      emit(CoursesState.error());
    }
  }

  void load() => add(_LoadCoursesEvent());

  //void courseSelected(Course course) => add(_CourseSaveCoursesEvent(course));

  void getYears(String courseValue, String academicYear, String code) =>
      add(_GetYearsCoursesEvent(courseValue, academicYear, code));
}
