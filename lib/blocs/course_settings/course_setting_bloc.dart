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
import 'package:meta/meta.dart';
import 'package:school_timetable/models/academic_year.dart';
import 'package:school_timetable/models/preferences/configuration.dart';

import '../../models/courses/course.dart';
import '../../repositories/configuration_repository.dart';

part 'course_setting_bloc.freezed.dart';
part 'course_setting_event.dart';
part 'course_setting_state.dart';

class CourseSettingBloc extends Bloc<CourseSettingEvent, CourseSettingState> {
  final ConfigurationRepository repository;

  CourseSettingBloc({required this.repository})
      : super(CourseSettingState.initial()) {
    on<_ChosenCourseSettingEvent>(_onTeachingsLoad);
    on<_SavingCourseSettingEvent>(_onSaving);
  }

  Future<void> _onTeachingsLoad(
      _ChosenCourseSettingEvent event, Emitter<CourseSettingState> emit) async {
    try {
      repository.setAcademic(event.academicYear);
      emit(CourseSettingState.teachings(event.course));
    } catch (error) {
      //TODO: Implement
    }
  }

  Future<void> _onSaving(
      _SavingCourseSettingEvent event, Emitter<CourseSettingState> emit) async {
    try {
      if (await repository.setConfiguration(event.course)) {
        emit(CourseSettingState.saved());
      }
      //emit(CourseSettingState.teachings());
    } catch (error) {
      //TODO : ERROR Implement
    }
  }

  void chosenCourse(AcademicYear academicYear, Course course) =>
      add(_ChosenCourseSettingEvent(academicYear, course));

  void savingCourse(Course course) => add(_SavingCourseSettingEvent(course));
}
