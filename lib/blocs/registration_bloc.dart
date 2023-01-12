/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_essentials_kit/errors/localized_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:school_timetable/models/academic_year.dart';

import '../repositories/courses_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';
part 'registration_bloc.freezed.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final CoursesRepository courseRepository;
  RegistrationBloc({required this.courseRepository})
      : super(const RegistrationState.initial()) {
    on<_YearsRegistrationEvent>(_mapPerformYears);
  }

  Future<void> _mapPerformYears(event, emit) async {
    emit(const RegistrationState.perform());
    try {
      final years = await courseRepository.academicYears();
      //final courses = await courseRepository.courses();
      if (years != null) {
        emit(RegistrationState.years(years));
      }
    } on LocalizedError catch (error) {
      emit(RegistrationState.yearError(error));
    }
  }

  void yearsReq() => add(RegistrationEvent.years());
}
