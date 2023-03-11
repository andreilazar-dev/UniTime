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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:school_timetable/models/academic_year.dart';
import 'package:school_timetable/models/courses/course.dart';
import 'package:school_timetable/repositories/configuration_repository.dart';

part 'course_setting_bloc.freezed.dart';

part 'course_setting_event.dart';

part 'course_setting_state.dart';

class CourseSettingBloc extends Bloc<CourseSettingEvent, CourseSettingState> {
  final ConfigurationRepository repository;

  CourseSettingBloc({required this.repository})
      : super(const CourseSettingState.initial()) {
    on<_SelectionCourseSettingEvent>(_onInitial);
    on<_ChosenCourseSettingEvent>(_onTeachingsLoad);
    on<_SavingCourseSettingEvent>(_onSaving);
  }

  Future<void> _onInitial(_SelectionCourseSettingEvent event,
      Emitter<CourseSettingState> emit) async {
    try {
      emit(const CourseSettingState.initial());
    } catch (error) {
      //TODO: Implement
    }
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
      if (await repository.setCourse(event.course)) {
        emit(const CourseSettingState.saved());
      }
    } catch (error) {
      //TODO : ERROR Implement
    }
  }

  void initial() => add(const _SelectionCourseSettingEvent());

  void chosenCourse(AcademicYear academicYear, Course course) =>
      add(_ChosenCourseSettingEvent(academicYear, course));

  void savingCourse(Course course) => add(_SavingCourseSettingEvent(course));
}
